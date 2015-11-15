//
//  Loan+CoreDataProperties.h
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Loan.h"
#import <RestKit/RestKit.h>

@class Location;

NS_ASSUME_NONNULL_BEGIN

@interface Loan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *loanId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *activity;
@property (nullable, nonatomic, retain) NSString *sector;
@property (nullable, nonatomic, retain) NSManagedObject *location;

+ (RKObjectMapping *)mapping;

@end

NS_ASSUME_NONNULL_END
