
#import "Location+CoreDataProperties.h"
#import "Geo+CoreDataProperties.h"

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
        
        [_mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"geo" toKeyPath:@"geo" withMapping:[Geo mapping]]];
    });
    return _mapping;
}

+ (NSString *)entityName
{
    return @"Location";
}

@end
