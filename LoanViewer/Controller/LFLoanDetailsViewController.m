
#import "LFLoanDetailsViewController.h"
#import "Loan+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"
#import "Geo+CoreDataProperties.h"
#import <MapKit/MapKit.h>

static NSString *const PinAnnotationIdentifier = @"PinAnnotationView";

@interface LFLoanDetailsViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectorLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (assign, nonatomic) CLLocationCoordinate2D location2d;

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
    self.location2d = CLLocationCoordinate2DMake([latitude doubleValue] , [longtitude doubleValue]);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location2d, 80000, 80000);
    [self.mapView setRegion:region animated:true];
    [self.mapView setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = self.location2d;
    [self.mapView addAnnotation:annotation];
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:PinAnnotationIdentifier];
        if (!annotationView)
        {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinAnnotationIdentifier];
            annotationView.animatesDrop = YES;
        }
        else
        {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

@end
