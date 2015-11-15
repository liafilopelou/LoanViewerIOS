
#import "LFLoanListViewController.h"
#import "LFLoanListCell.h"
#import "LFLoanDetailsViewController.h"
#import "LFLoanFeeder.h"
#import "Loan.h"

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
    [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *loans) {
        self.loans = loans;
        [self refreshView];
    } failure:^{
        [self refreshView];
        NSLog(@"Error during feed retrieval");
    }];
}

- (void)refreshView
{
    [self.tableView reloadData];
    if ([self.refreshControl isRefreshing]) {
        [self.refreshControl endRefreshing];
    }
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
        noDataLabel.text = @"No data could be retrieved. \nPlease pull down to refresh.";
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
