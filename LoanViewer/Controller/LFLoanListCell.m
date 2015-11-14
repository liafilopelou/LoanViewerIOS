//
//  LFLoanListCell.m
//  LoanViewer
//
//  Created by Lia Filopelou on 14/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//

#import "LFLoanListCell.h"
#import "Loan.h"

@interface LFLoanListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation LFLoanListCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.text = [self.loan name];
}

@end
