
#import "Loan.h"
#import <RestKit/RestKit.h>

@class Location;

NS_ASSUME_NONNULL_BEGIN

@interface Loan (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *loanId;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *activity;
@property (nullable, nonatomic, retain) NSString *sector;
@property (nullable, nonatomic, retain) NSManagedObject *location;

+ (RKObjectMapping *)mapping;
+ (NSString *)entityName;

@end

NS_ASSUME_NONNULL_END
