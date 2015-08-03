//
//  HTTPTool.h
//  MyOne
//
//  Created by HelloWorld on 8/3/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

// 获取首页内容接口地址
#define URL_GET_HOME_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getHp_N"
// 获取文章接口地址
#define URL_GET_READING_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getOneContentInfo"
// 获取问题接口地址
#define URL_GET_QUESTION_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getOneQuestionInfo"
// 获取东西接口地址
#define URL_GET_THING_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/o_f"

@interface HTTPTool : NSObject

// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);

// 请求失败之后回调的 Block
typedef void(^FailBlock) (AFHTTPRequestOperation *operation, NSError *error);

/**
 *  获取首页数据
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestHomeContentByDate:(NSString *)date  success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取文章
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestReadingContentByDate:(NSString *)date  success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取问题
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestQuestionContentByDate:(NSString *)date  success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取东西
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestThingContentByDate:(NSString *)date  success:(SuccessBlock)success failBlock:(FailBlock)fail;

@end
