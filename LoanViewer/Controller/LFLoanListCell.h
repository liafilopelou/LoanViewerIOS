
#import <UIKit/UIKit.h>

@class Loan;

@interface LFLoanListCell : UITableViewCell

@property (strong, nonatomic) Loan *loan;

+ (NSString *)reuseIdentifier;

@end
