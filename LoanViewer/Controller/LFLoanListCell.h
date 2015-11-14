//
//  LFLoanListCell.h
//  LoanViewer
//
//  Created by Lia Filopelou on 14/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Loan;

@interface LFLoanListCell : UITableViewCell

@property (strong, nonatomic) Loan *loan;

+ (NSString *)reuseIdentifier;

@end
