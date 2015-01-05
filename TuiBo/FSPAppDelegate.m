//
//  FSPAppDelegate.m
//  TuiBo
//
//  Created by Miracolo Bosco on 14/12/7.
//  Copyright (c) 2014年 随便什么组. All rights reserved.
//

#import "FSPAppDelegate.h"
#import "FSPMainViewController.h"
#import "FSPAuthViewController.h"
#import "FSPAccount.h"
#import "FSPAuthViewController.h"
#import "FSPAccountTool.h"
#import "FSPFirstLoginViewController.h"

@implementation FSPAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
////    self.window.rootViewController = [[[FSPMainViewController alloc] init] autorelease];
//    self.window.rootViewController = [[[FSPAuthViewController alloc] init] autorelease];
    // 先判断有无存储账号信息
    FSPAccount *account = [FSPAccountTool account];
    NSLog(@"------------------");
    NSLog(@"access_token1 = %@", account.access_token);
    if (account) { // 之前登录成功
//        [FSPAccountTool chooseRootController];
        FSPMainViewController *mainVC = [[FSPMainViewController alloc] init];
        self.window.rootViewController = mainVC;
        [mainVC release];
    } else { // 之前没有登录成功
//        FSPAuthViewController *authVC = [[FSPAuthViewController alloc] init];
//        self.window.rootViewController = authVC;
        FSPFirstLoginViewController *loginVC = [[FSPFirstLoginViewController alloc]init];
        self.window.rootViewController = loginVC;
#warning 此处不能release，会导致授权成功跳转到主程序页面时崩溃，暂时解决办法 1.在autorelease前retain 2.不释放;
//        [authVC release];
        [loginVC release];
    }

    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
