
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestLoans];
}

- (void)requestLoans
{
    self.tableView.backgroundView = nil;
    
    [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *updatedLoans) {
        
        [self suspendRefreshControl];
        [self updateWithLoans:updatedLoans];
        
    } failure:^(NSArray *fetchedLoans) {
        
        [self suspendRefreshControl];
        
        if (fetchedLoans && fetchedLoans.count>0)
        {
            [self updateWithLoans:fetchedLoans];
            [self showNoUpdateAlert];
        }
        else
        {
            [self setNoDataBackground];
        }
    }];
}

- (void)updateWithLoans:(NSArray *)loans
{
    self.loans = loans;
    [self.tableView reloadData];
}

- (void)suspendRefreshControl
{
    if ([self.refreshControl isRefreshing])
    {
        [self.refreshControl endRefreshing];
    }
}

- (void)showNoUpdateAlert
{
    NSDate *lastUpdate = [[NSUserDefaults standardUserDefaults] objectForKey:sharedKeyLastUpdate];
    NSString *dateSubtitle = nil;
    
    if (lastUpdate)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy 'at' HH:mm"];
        NSString *lastUpdateString = [formatter stringFromDate:lastUpdate];
        dateSubtitle = [NSString stringWithFormat:NSLocalizedString(@"last.update.message", nil), lastUpdateString];
    }
    
    [TSMessage showNotificationWithTitle:NSLocalizedString(@"no.update.message", nil)
                                subtitle:dateSubtitle
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
    NSInteger count = 0;
    if (self.loans.count > 0)
    {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView = nil;
        count = 1;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFLoanListCell *cell = (LFLoanListCell *)[tableView dequeueReusableCellWithIdentifier:[LFLoanListCell reuseIdentifier] forIndexPath:indexPath];
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
