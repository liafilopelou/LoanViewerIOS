//
//  Location+CoreDataProperties.h
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location.h"
#import <RestKit/RestKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Location (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *countryCode;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) NSString *town;
@property (nullable, nonatomic, retain) Geo *geo;

+ (RKObjectMapping *)mapping;
+ (NSString *)entityName;

@end

NS_ASSUME_NONNULL_END
