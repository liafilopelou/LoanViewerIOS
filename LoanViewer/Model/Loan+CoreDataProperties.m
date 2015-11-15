//
//  Loan+CoreDataProperties.m
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Loan+CoreDataProperties.h"
#import "Location+CoreDataProperties.h"

@implementation Loan (CoreDataProperties)

@dynamic loanId;
@dynamic name;
@dynamic status;
@dynamic activity;
@dynamic sector;
@dynamic location;

+ (RKObjectMapping *)mapping
{
    __strong static RKEntityMapping *_mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKManagedObjectStore *store = [[RKObjectManager sharedManager] managedObjectStore];
        _mapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class]) inManagedObjectStore:store];
        

        [_mapping addAttributeMappingsFromDictionary: @{ @"id" : @"loanId",
                                                         @"name" : @"name",
                                                         @"status" : @"status",
                                                         @"activity" : @"activity",
                                                         @"sector" : @"sector" }];

        _mapping.identificationAttributes = @[ @"loanId" ];
        
        [_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:[Location mapping]]];
    });
    return _mapping;
}

+ (NSString *)entityName
{
    return @"Loan";
}

@end
