
#import "LFLoanListViewController.h"
#import "LFLoanListCell.h"
#import "LFLoanDetailsViewController.h"
#import "LFLoanFeeder.h"
#import "Loan.h"
#import "TSMessage.h"

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
    
    [self requestLoans];
}

- (void)requestLoans
{
    [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *updatedLoans) {
        
        [self updateWithLoans:updatedLoans];
        
    } failure:^(NSArray *fetchedLoans) {
        
        if (fetchedLoans) {
            [self updateWithLoans:fetchedLoans];
            [self showNoUpdateAlert];
        }
    }];
}

- (void)updateWithLoans:(NSArray *)loans
{
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
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *lastUpdateString = [formatter stringFromDate:lastUpdate];
    
    NSString *noUpdateMessage = [NSString stringWithFormat:NSLocalizedString(@"no.update.message", nil), lastUpdateString];
    
    [TSMessage showNotificationWithTitle:@"Not able to update data"
                                subtitle:[NSString stringWithFormat:@"Showing loans from %@", lastUpdateString]
                                    type:TSMessageNotificationTypeWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.loans.count > 0) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView = nil;
        return 1;
        
    } else {
        UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        noDataLabel.text = NSLocalizedString(@"no.data.message", nil);
        noDataLabel.numberOfLines = 0;
        noDataLabel.textColor = [UIColor blackColor];
        noDataLabel.textAlignment = NSTextAlignmentCenter;
        [noDataLabel sizeToFit];
        self.tableView.backgroundView = noDataLabel;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return 0;
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
