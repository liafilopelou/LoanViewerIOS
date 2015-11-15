
#import "LFLoanDetailsViewController.h"
#import "Loan+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"

@interface LFLoanDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectorLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end


@implementation LFLoanDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.loan.name;
    
    self.statusLabel.text = self.loan.status;
    self.activityLabel.text = self.loan.activity;
    self.sectorLabel.text = self.loan.sector;
    
    Location *location = (Location *)self.loan.location;
    self.locationLabel.text = location.town;
}

@end
