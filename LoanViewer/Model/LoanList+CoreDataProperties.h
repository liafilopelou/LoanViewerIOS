//
//  LoanList+CoreDataProperties.h
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LoanList.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoanList (CoreDataProperties)

@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *loans;
@property (nullable, nonatomic, retain) NSManagedObject *paging;

@end

@interface LoanList (CoreDataGeneratedAccessors)

- (void)addLoansObject:(NSManagedObject *)value;
- (void)removeLoansObject:(NSManagedObject *)value;
- (void)addLoans:(NSSet<NSManagedObject *> *)values;
- (void)removeLoans:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
