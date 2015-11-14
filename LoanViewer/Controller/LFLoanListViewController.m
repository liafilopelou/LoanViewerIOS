
#import "LFLoanListViewController.h"
#import "LFLoanFeeder.h"
#import "Loan.h"

@interface LFLoanListViewController ()

@property (strong, nonatomic) NSArray *loans;

@end


@implementation LFLoanListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *loans) {
        self.loans = loans;
        [self.tableView reloadData];
    } failure:^{
        NSLog(@"Error during feed retrieval");
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Loan *loan = self.loans[indexPath.row];
    cell.textLabel.text = loan.name;
    return cell;
}

@end
