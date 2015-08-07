//
//  AppDelegate.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ReadingViewController.h"
#import "QuestionViewController.h"
#import "ThingViewController.h"
#import "PersonViewController.h"
#import "DSNavigationBar.h"
#import "AppConfigure.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	UITabBarController *rootTabBarController = [[UITabBarController alloc] init];
	
	// 首页
	HomeViewController *homeViewController = [[HomeViewController alloc] init];
	UINavigationController *homeNavigationController = [self dsNavigationController];
	[homeNavigationController setViewControllers:@[homeViewController]];
	// 文章
	ReadingViewController *readingViewController = [[ReadingViewController alloc] init];
	UINavigationController *readingNavigationController = [self dsNavigationController];
	[readingNavigationController setViewControllers:@[readingViewController]];
	// 问题
	QuestionViewController *questionViewController = [[QuestionViewController alloc] init];
	UINavigationController *questionNavigationController = [self dsNavigationController];
	[questionNavigationController setViewControllers:@[questionViewController]];
	// 东西
	ThingViewController *thingViewController = [[ThingViewController alloc] init];
	UINavigationController *thingNavigationController = [self dsNavigationController];
	[thingNavigationController setViewControllers:@[thingViewController]];
	// 个人
	PersonViewController *personViewController = [[PersonViewController alloc] init];
	UINavigationController *personNavigationController = [self dsNavigationController];
	[personNavigationController setViewControllers:@[personViewController]];
	
	rootTabBarController.viewControllers = @[homeNavigationController, readingNavigationController, questionNavigationController, thingNavigationController, personNavigationController];
	rootTabBarController.tabBar.tintColor = [UIColor colorWithRed:55 / 255.0 green:196 / 255.0 blue:242 / 255.0 alpha:1];
	rootTabBarController.tabBar.barTintColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1];
	rootTabBarController.tabBar.backgroundColor = [UIColor clearColor];
	
	if ([AppConfigure boolForKey:APP_THEME_NIGHT_MODE]) {
		UIColor * color = [UIColor colorWithRed:32 / 255.0 green:32 / 255.0 blue:32 / 255.0 alpha:1];
		[[DSNavigationBar appearance] setNavigationBarWithColor:color];
		
		rootTabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:48 / 255.0 green:48 / 255.0 blue:48 / 255.0 alpha:1]];
		
		// 设置状态栏的字体颜色为黑色
		[application setStatusBarStyle:UIStatusBarStyleLightContent];
		
		[DKNightVersionManager nightFalling];
	} else {
		// create a color and set it to the DSNavigationBar appereance
		UIColor * color = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1];
		[[DSNavigationBar appearance] setNavigationBarWithColor:color];
		
		rootTabBarController.tabBar.backgroundImage = [self imageWithColor:[UIColor colorWithRed:241 / 255.0 green:241 / 255.0 blue:241 / 255.0 alpha:1]];
		
		// 设置状态栏的字体颜色为白色
		[application setStatusBarStyle:UIStatusBarStyleDefault];
	}
	
	self.window.rootViewController = rootTabBarController;
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (UINavigationController *)dsNavigationController {
	UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
	[navigationController.navigationBar setOpaque:YES];
	
	return navigationController;
}

- (UIImage *)imageWithColor:(UIColor *)color {
	CGRect rect = CGRectMake(0, 0, 1, 1);
	UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
	[color setFill];
	UIRectFill(rect);
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
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
