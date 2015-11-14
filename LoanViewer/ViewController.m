//
//  ViewController.m
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//

#import "ViewController.h"
#import "LFLoanFeeder.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *loans;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[LFLoanFeeder sharedFeeder] retrieveLoansFeedForSuccess:^(NSArray *loans) {
        self.loans = loans;
    } failure:^{
        NSLog(@"Error during feed retrieval");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
