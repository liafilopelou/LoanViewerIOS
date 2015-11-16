
#import "Location.h"
#import <RestKit/RestKit.h>

@class Geo;

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
