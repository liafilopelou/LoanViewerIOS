
#import "LFLoanListViewController.h"
#import "LFLoanListCell.h"
#import "LFLoanDetailsViewController.h"
#import "LFLoanFeeder.h"
#import "Loan.h"
#import "TSMessage.h"
#import "MBProgressHUD.h"

@interface LFLoanListViewController ()

@property (strong, nonatomic) NSArray *loans;

@end


@implementation LFLoanListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"loans.title", nil);
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(requestLoans)
                  forControlEvents:UIControlEventValueChanged];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestLoans];
}

- (void)requestLoans
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.dimBackground = YES;
    hud.labelText = NSLocalizedString(@"updating.message", nil);
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *updatedLoans) {
            
            [self updateWithLoans:updatedLoans];
            
        } failure:^(NSArray *fetchedLoans) {
            
            if (fetchedLoans) {
                [self updateWithLoans:fetchedLoans];
                [self showNoUpdateAlert];
            }
            else {
                [self setNoDataBackground];
            }
        }];
        
    });
}

- (void)updateWithLoans:(NSArray *)loans
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    });
    
    self.loans = loans;
    [self refreshView];
}

- (void)refreshView
{
    [self.tableView reloadData];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
}

- (void)showNoUpdateAlert
{
    NSDate *lastUpdate = [[NSUserDefaults standardUserDefaults] objectForKey:sharedKeyLastUpdate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy 'at' HH:mm"];
    NSString *lastUpdateString = [formatter stringFromDate:lastUpdate];
    
    [TSMessage showNotificationWithTitle:NSLocalizedString(@"no.update.message", nil)
                                subtitle:[NSString stringWithFormat:NSLocalizedString(@"last.update.message", nil), lastUpdateString]
                                    type:TSMessageNotificationTypeWarning];
}

- (void)setNoDataBackground
{
    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    noDataLabel.text = NSLocalizedString(@"no.data.message", nil);
    noDataLabel.numberOfLines = 0;
    noDataLabel.textColor = [UIColor blackColor];
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    [noDataLabel sizeToFit];
    self.tableView.backgroundView = noDataLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.loans.count > 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView = nil;
        return 1;
        
    } else {
        return 0;
    }
   
    //return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFLoanListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LFLoanListCell reuseIdentifier] forIndexPath:indexPath];
    cell.loan = self.loans[indexPath.row];
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetailsSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Loan *selectedLoan = self.loans[indexPath.row];
        
        LFLoanDetailsViewController *detailsViewController = (LFLoanDetailsViewController *)[segue destinationViewController];
        detailsViewController.loan = selectedLoan;
    }
}

@end
