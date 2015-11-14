//
//  AppDelegate.m
//  LoanViewer
//
//  Created by Lia Filopelou on 13/11/15.
//  Copyright © 2015 Lia Filopelou. All rights reserved.
//

#import "AppDelegate.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURL *baseURL = [NSURL URLWithString:@"http://api.kivaws.org"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"LoanViewerDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    [managedObjectStore createManagedObjectContexts];
    
    
    RKEntityMapping *loanMapping = [RKEntityMapping mappingForEntityForName:@"Loan" inManagedObjectStore:managedObjectStore];
    loanMapping.identificationAttributes = @[ @"loanId" ];
    [loanMapping addAttributeMappingsFromDictionary:
     @{
       @"id" : @"loanId",
       @"name" : @"name",
       @"status" : @"status",
       @"activity" : @"activity",
       @"sector" : @"sector"
       }
     ];
    
    RKEntityMapping *locationMapping = [RKEntityMapping mappingForEntityForName:@"Location" inManagedObjectStore:managedObjectStore];
    [loanMapping addAttributeMappingsFromDictionary:
     @{
       @"country_code" : @"countryCode",
       @"country" : @"country",
       @"town" : @"town"
       }
     ];
    
    [loanMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];

    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:loanMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/v1/loans/search.json"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
