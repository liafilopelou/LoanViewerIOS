
#import <Foundation/Foundation.h>

@class Loan;

static NSString * const sharedKeyLastUpdate = @"LastUpdate";

@interface LFLoanFeeder : NSObject

+ (instancetype)sharedFeeder;

- (void)retrieveLoansFeedForSuccess:(void (^)(NSArray *updatedLoans))successBLock failure:(void (^)(NSArray *existingLoans))failureBlock;

@end
