//
//  AppDelegate.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "AppDelegate.h"
#import "WKSelectedViewController.h"
#import "WKHomeViewController.h"
#import "WKAcademyViewController.h"
#import "WKTeacherViewController.h"
#import "WKMeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    NSLog(@"job_edit= %@",JOB_SEARCH);
    // Override point for customization after application launch.
//    WKHomeViewController *home=[[WKHomeViewController alloc]init];
//    home.tabBarItem.title=@"消息";
//    
//    WKAcademyViewController *academy=[[WKAcademyViewController alloc]init];
//    academy.tabBarItem.title=@"微学院";
//    WKTeacherViewController *teacher=[[WKTeacherViewController alloc]init];
//    teacher.tabBarItem.title=@"教师专栏";
//    WKMeViewController *me=[[WKMeViewController alloc]init];
//    me.tabBarItem.title=@"我的";
//    UITabBarController *tabbar=[[UITabBarController alloc]init];
//    tabbar.viewControllers=@[home,academy,teacher,me];
//    self.nav=[[UINavigationController alloc]initWithRootViewController:tabbar];
    WKSelectedViewController *selectView=[[WKSelectedViewController alloc]init];
    //self.window.rootViewController=nav;
//    [self.window addSubview:self.nav.view];
//    [self.window makeKeyAndVisible];
    //[[UIApplication sharedApplication]setStatusBarHidden:NO];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
