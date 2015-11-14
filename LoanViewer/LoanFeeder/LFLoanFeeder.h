
#import <Foundation/Foundation.h>

@interface LFLoanFeeder : NSObject

+ (instancetype)sharedFeeder;

- (void)retrieveLoansFeedForSuccess:(void (^)(NSArray *loans))successBLock failure:(void (^)(void))failureBlock;

@end
