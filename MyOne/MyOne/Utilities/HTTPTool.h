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
// 获取问题后援接口地址 (What the f**k! 日了狗了，试了几次不同日期，获取过来都是最新一天的(也就是今天))，没办法，只能显示一个官方的手机版网页了
//#define URL_BACKUP_GET_QUESTION_CONTENT @"http://bea.wufazhuce.com/OneForWeb/one/getQ_N"
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
+ (void)requestHomeContentByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取首页数据
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)requestHomeContentByIndex:(NSInteger)index success:(SuccessBlock)success failBlock:(FailBlock)fail ;

/**
 *  获取文章
 *
 *  @param date           日期，"yyyy-MM-dd"格式
 *  @param lastUpdateDate 最后更新日期，"yyyy-MM-dd"格式或者也可以是"yyyy-MM-dd HH:mm:ss"格式
 *  @param success        请求成功 Block
 *  @param fail           请求失败 Block
 */
+ (void)requestReadingContentByDate:(NSString *)date lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *   获取问题
 *
 *  @param date           日期，"yyyy-MM-dd"格式
 *  @param lastUpdateDate 最后更新日期，"yyyy-MM-dd"格式
 *  @param success        请求成功 Block
 *  @param fail           请求失败 Block
 */
+ (void)requestQuestionContentByDate:(NSString *)date lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  What the f**k! 日了狗了，上一个获取在有些日期的时候会没有数据，而这个方法使用的接口获取就有数据，
 *  所以如果上一个方法请求返回的数据为空的话，就继续用这个方法来获取数据，要是这个方法还是不能获取，那么，就再说吧
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
//+ (void)requestQuestionContentBackupByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取东西
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestThingContentByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail;

/**
 *  获取东西
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)requestThingContentByIndex:(NSInteger)index success:(SuccessBlock)success failBlock:(FailBlock)fail;

@end
