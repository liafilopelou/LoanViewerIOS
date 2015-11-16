
#import "LFLoanListViewController.h"
#import "LFLoanListCell.h"
#import "LFLoanDetailsViewController.h"
#import "LFLoanFeeder.h"
#import "Loan.h"
#import "TSMessage.h"
#import "MBProgressHUD.h"

@interface LFLoanListViewController ()

@property (strong, nonatomic) NSArray *loans;
@property (strong, nonatomic) MBProgressHUD *hud;
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
    
    self.hud.mode = MBProgressHUDModeDeterminate;
    self.hud.dimBackground = YES;
    self.hud.labelText = NSLocalizedString(@"updating.message", nil);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestLoans];
}

- (void)requestLoans
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *updatedLoans) {
        
        [self updateWithLoans:updatedLoans];
        
    } failure:^(NSArray *fetchedLoans) {
        
        if (fetchedLoans)
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
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    self.loans = loans;
    [self refreshView];
}

- (void)refreshView
{
    [self.tableView reloadData];
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
