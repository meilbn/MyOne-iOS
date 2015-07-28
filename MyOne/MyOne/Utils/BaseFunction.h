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

@end
