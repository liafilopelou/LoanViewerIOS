
#import "LFLoanListCell.h"
#import "Loan.h"

@interface LFLoanListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation LFLoanListCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.text = [self.loan name];
}

@end
