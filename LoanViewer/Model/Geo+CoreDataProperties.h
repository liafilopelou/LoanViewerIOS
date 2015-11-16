
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
