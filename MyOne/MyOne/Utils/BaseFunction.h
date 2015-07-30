//
//  BaseFunction.h
//  MyOne
//
//  Created by HelloWorld on 7/28/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseFunction : NSObject

/**
 *  取一个随机整数 0~x-1
 *
 *  @param x
 *
 *  @return
 */
+ (int)random:(int)x;

/**
 *  MD5加密
 *
 *  @param str 待加密的字符串
 *
 *  @return 加密后的字符串
 */
+ (NSString *)md5Digest:(NSString *)str;

/**
 *  根据文件名来加载文件内容，并转化为 NSDictionary 对象
 *
 *  @param fileName 文件名
 *
 *  @return 转化之后的 NSDictionary 对象
 */
+ (NSDictionary *)loadTestDatasWithFileName:(NSString *)fileName;

/**
 *  根据“yyyy-MM-dd”格式的时间获取文章头部的时间格式
 *
 *  @param originalMarketTime 原数据中的时间
 *
 *  @return 转换之后的时间
 */
+ (NSString *)getReadingENMarketTimeWithOriginalMarketTime:(NSString *)originalMarketTime;

@end
