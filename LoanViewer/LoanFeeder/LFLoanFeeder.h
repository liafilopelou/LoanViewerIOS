
#import <Foundation/Foundation.h>

@class Loan;

extern NSString * const sharedKeyLastUpdate;

@interface LFLoanFeeder : NSObject

+ (instancetype)sharedFeeder;

- (void)retrieveLoansFeedForSuccess:(void (^)(NSArray *updatedLoans))successBLock failure:(void (^)(NSArray *existingLoans))failureBlock;

@end
