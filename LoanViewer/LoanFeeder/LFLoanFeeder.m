
#import "LFLoanFeeder.h"
#import <RestKit/RestKit.h>


@interface LFLoanFeeder ()

@property (strong, nonatomic) NSString *requestPath;
@property (strong, nonatomic) NSDictionary *requestParameters;

@end


@implementation LFLoanFeeder

+ (instancetype)sharedFeeder
{
    static id _sharedFeeder = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFeeder = [[[self class] alloc] init];
    });
    return _sharedFeeder;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.requestPath = @"/v1/loans/search.json";
        self.requestParameters = @{ @"status" : @"fundraising" };
    }
    return self;
}

- (void)retrieveLoansFeedForSuccess:(void (^)(NSArray *loans))successBLock failure:(void (^)(void))failureBlock
{
    [[RKObjectManager sharedManager] getObjectsAtPath:self.requestPath parameters:self.requestParameters success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray *loans = [self fetchLoans];
        if (loans) {
            successBLock(loans);
        }
        else {
            failureBlock();
        }
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         
         RKLogError(@"Load failed with error: %@", error);
         failureBlock();
     }];
}

- (NSArray *)fetchLoans
{
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Loan"];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

@end
