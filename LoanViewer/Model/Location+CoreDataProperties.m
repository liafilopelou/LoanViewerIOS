//
//  Location+CoreDataProperties.m
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Location+CoreDataProperties.h"

@implementation Location (CoreDataProperties)

@dynamic countryCode;
@dynamic country;
@dynamic town;
@dynamic geo;

+ (RKObjectMapping *)mapping
{
    __strong static RKEntityMapping *_mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKManagedObjectStore *store = [[RKObjectManager sharedManager] managedObjectStore];
        _mapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class]) inManagedObjectStore:store];
        
        
        [_mapping addAttributeMappingsFromDictionary: @{ @"country_code" : @"countryCode",
                                                         @"country" : @"country",
                                                         @"town" : @"town" }];
    });
    return _mapping;
}

+ (NSString *)entityName
{
    return @"Location";
}

@end
