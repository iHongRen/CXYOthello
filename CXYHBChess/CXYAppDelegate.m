//
//  CXYAppDelegate.m
//  CXYHBChess
//
//  Created by iMac on 14-9-2.
//  Copyright (c) 2014年 ___cxy___. All rights reserved.
//

#import "CXYAppDelegate.h"
#import "CXYGameViewController.h"

@implementation CXYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CXYGameViewController *c = [CXYGameViewController new];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:c];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
