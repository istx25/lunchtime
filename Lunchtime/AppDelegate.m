//
//  AppDelegate.m
//  Lunchtime
//
//  Created by Willow Bumby on 2015-11-13.
//  Copyright © 2015 Lighthouse Labs. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>

static NSString *kUserCreatedFlag = @"USER_CREATED";
static NSString *kSetupPageViewController = @"SetupPageViewController";
static NSString *kSetupStoryboardName = @"Setup";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self checkIfUserExists];
    [self appearance];

    NSLog(@"Realm Path: %@", [RLMRealm defaultRealm].path);
    
    return YES;
}

- (void)checkIfUserExists {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // [defaults removeObjectForKey:kUserCreatedFlag];

    if (![defaults objectForKey:kUserCreatedFlag]) {
        UIStoryboard *setup = [UIStoryboard storyboardWithName:kSetupStoryboardName bundle:[NSBundle mainBundle]];
        [self.window setRootViewController:[setup instantiateViewControllerWithIdentifier:kSetupPageViewController]];

        return;
    }
}

- (void)appearance {
    // [[UIView appearance] setTintColor:[UIColor blackColor]];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"Lunchtime has received a new notification!");
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
