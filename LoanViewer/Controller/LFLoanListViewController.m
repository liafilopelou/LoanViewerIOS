
#import "LFLoanListViewController.h"
#import "LFLoanListCell.h"
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
    LFLoanListCell *cell = [tableView dequeueReusableCellWithIdentifier:[LFLoanListCell reuseIdentifier] forIndexPath:indexPath];
    cell.loan = self.loans[indexPath.row];
    
    return cell;
}

@end
