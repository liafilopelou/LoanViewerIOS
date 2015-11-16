
#import "LFLoanDetailsViewController.h"
#import "Loan+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"
#import "Geo+CoreDataProperties.h"
#import <MapKit/MapKit.h>

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
    
    Geo *geo = (Geo *)location.geo;
    NSString *pairs = geo.pairs;
    
    NSArray *coordinates = [pairs componentsSeparatedByString:@" "];
    NSString *latitude = coordinates[0];
    NSString *longtitude = coordinates[1];
    CLLocationCoordinate2D location2d = CLLocationCoordinate2DMake([latitude doubleValue] , [longtitude doubleValue]);
    
}

@end
