
#import "Geo+CoreDataProperties.h"

@implementation Geo (CoreDataProperties)

@dynamic level;
@dynamic pairs;
@dynamic type;

+ (RKObjectMapping *)mapping
{
    __strong static RKEntityMapping *_mapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        RKManagedObjectStore *store = [[RKObjectManager sharedManager] managedObjectStore];
        _mapping = [RKEntityMapping mappingForEntityForName:NSStringFromClass([self class]) inManagedObjectStore:store];
        
        
        [_mapping addAttributeMappingsFromDictionary: @{ @"level" : @"level",
                                                         @"pairs" : @"pairs",
                                                         @"type" : @"type" }];
    });
    return _mapping;
}

+ (NSString *)entityName
{
    return @"Geo";
}

@end
