//
//  AppConfigure.h
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <Foundation/Foundation.h>

// 当前 APP 版本
#define CURRENT_APP_VERSION 1.0
// 用户第一次安装 APP 展示引导页的版本
#define LAST_SHOW_GUIDE_APP_VERSION @"Last_Show_Guide_App_Version"
// 用户是否已经登录
#define IS_LOGINED @"User_Login_Status"
// App 主题模式是否开启夜间模式
#define APP_THEME_NIGHT_MODE @"Night_Mode_Is_On"

@interface AppConfigure : NSObject

+ (id)objectForKey:(NSString *)key;
+ (NSString *)valueForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;
+ (void)setObject:(id)value ForKey:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

@end
