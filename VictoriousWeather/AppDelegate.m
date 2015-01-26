//
//  AppDelegate.m
//  VictoriousWeather
//
//  Created by Zuri Biringer on 1/16/15.
//  Copyright (c) 2015 Zuri Biringer. All rights reserved.
//

#import "AppDelegate.h"
#import "ZMBWeatherModel.h"
#import "ZMBNetworkController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    
    NSDate *timeAppClosed = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:timeAppClosed forKey:@"timeAppClosed"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"notFirstTime"] == NO) {
        
        [[ZMBNetworkController sharedController] downloadData];
        [[ZMBNetworkController sharedController] startTimer];
       
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"notFirstTime"];
        
    } else {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"weather"];
        [ZMBNetworkController sharedController].weatherModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [[ZMBNetworkController sharedController].delegate updateWeather];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"timeAppClosed"] timeIntervalSinceNow] > 1800) {
            [[ZMBNetworkController sharedController] downloadData];
        }
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
}

@end
