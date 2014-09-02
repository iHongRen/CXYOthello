//
//  CXYAppDelegate.h
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXYAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
