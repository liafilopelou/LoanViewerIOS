
#import "LFLoanDetailsViewController.h"
#import "Loan.h"

@interface LFLoanDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectorLabel;

@end


@implementation LFLoanDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.statusLabel.text = self.loan.status;
    self.activityLabel.text = self.loan.activity;
    self.sectorLabel.text = self.loan.sector;
}

@end
