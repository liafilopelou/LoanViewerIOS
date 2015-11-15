
#import "LFLoanFeeder.h"
#import <RestKit/RestKit.h>
#import "Loan.h"

NSString * const sharedKeyLastUpdate = @"LastUpdate";

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

- (void)retrieveLoansFeedForSuccess:(void (^)(NSArray *updatedLoans))successBLock failure:(void (^)(NSArray *existingLoans))failureBlock
{
    [[RKObjectManager sharedManager] getObjectsAtPath:self.requestPath parameters:self.requestParameters success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        if (mappingResult.array) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:sharedKeyLastUpdate];
            successBLock(mappingResult.array);
        }
        else {
            failureBlock([self fetchLoans]);
        }
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         
         failureBlock([self fetchLoans]);
         
         RKLogError(@"Load failed with error: %@", error);
     }];
}

- (NSArray *)fetchLoans
{
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[Loan entityName]];

    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];

    return fetchedObjects;
}

@end
