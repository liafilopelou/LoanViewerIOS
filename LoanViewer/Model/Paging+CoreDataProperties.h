//
//  Paging+CoreDataProperties.h
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Paging.h"

NS_ASSUME_NONNULL_BEGIN

@interface Paging (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *page;
@property (nullable, nonatomic, retain) NSNumber *total;
@property (nullable, nonatomic, retain) NSNumber *pageSize;
@property (nullable, nonatomic, retain) NSNumber *pages;

@end

NS_ASSUME_NONNULL_END
