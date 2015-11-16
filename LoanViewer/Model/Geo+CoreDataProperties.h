//
//  Geo+CoreDataProperties.h
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Geo.h"
#import <RestKit/RestKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Geo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *level;
@property (nullable, nonatomic, retain) NSString *pairs;
@property (nullable, nonatomic, retain) NSString *type;

+ (RKObjectMapping *)mapping;
+ (NSString *)entityName;

@end

NS_ASSUME_NONNULL_END
