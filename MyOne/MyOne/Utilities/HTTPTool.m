//
//  HTTPTool.m
//  MyOne
//
//  Created by HelloWorld on 8/3/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "HTTPTool.h"

@implementation HTTPTool

+ (AFHTTPRequestOperationManager *)initAFHttpManager {
	static AFHTTPRequestOperationManager *manager;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		manager = [[AFHTTPRequestOperationManager alloc] init];
		manager.responseSerializer = [AFJSONResponseSerializer serializer];
		manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
		manager.operationQueue.maxConcurrentOperationCount = 1;
	});
	
	return manager;
}

+ (NSDictionary *)parametersWithIndex:(NSInteger)index {
	if (index > 9) {
		NSString *date = [BaseFunction stringDateBeforeTodaySeveralDays:index];
		NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
		
		return parameters;
	} else {
		NSString *date = [BaseFunction stringDateFromCurrent];
		NSDictionary *parameters = @{@"strDate" : date, @"strRow" : [@(++index) stringValue]};
		
		return parameters;
	}
}

/**
 *  获取首页数据
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestHomeContentByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strRow" : [@1 stringValue]};
	[manager GET:URL_GET_HOME_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

/**
 *  获取首页数据
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)requestHomeContentByIndex:(NSInteger)index success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = [self parametersWithIndex:index];
	[manager GET:URL_GET_HOME_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

/**
 *  获取文章
 *
 *  @param date           日期，"yyyy-MM-dd"格式
 *  @param lastUpdateDate 最后更新日期，"yyyy-MM-dd"格式或者也可以是"yyyy-MM-dd HH:mm:ss"格式
 *  @param success        请求成功 Block
 *  @param fail           请求失败 Block
 */
+ (void)requestReadingContentByDate:(NSString *)date lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
	[manager GET:URL_GET_READING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

//+ (void)requestReadingContentByIndex:(NSInteger)index lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
//	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
//	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
//	[manager GET:URL_GET_READING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		success(operation,responseObject);
//	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//		fail(operation,error);
//	}];
//}

/**
 *   获取问题
 *
 *  @param date           日期，"yyyy-MM-dd"格式
 *  @param lastUpdateDate 最后更新日期，"yyyy-MM-dd"格式
 *  @param success        请求成功 Block
 *  @param fail           请求失败 Block
 */
+ (void)requestQuestionContentByDate:(NSString *)date lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
	[manager GET:URL_GET_QUESTION_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

//+ (void)requestQuestionContentByIndex:(NSInteger)index lastUpdateDate:(NSString *)lastUpdateDate success:(SuccessBlock)success failBlock:(FailBlock)fail {
//	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
//	NSDictionary *parameters = @{@"strDate" : date, @"strLastUpdateDate" : lastUpdateDate};
//	[manager GET:URL_GET_QUESTION_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		success(operation,responseObject);
//	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//		fail(operation,error);
//	}];
//}

//+ (void)requestQuestionContentBackupByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail {
//	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
//	NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
//	[manager GET:URL_BACKUP_GET_QUESTION_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		success(operation,responseObject);
//	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//		fail(operation,error);
//	}];
//}

/**
 *  获取东西
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)requestThingContentByDate:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = @{@"strDate" : date, @"strRow" : @"1"};
	[manager GET:URL_GET_THING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

/**
 *  获取东西
 *
 *  @param index   要展示数据的 Item 的下标
 *  @param success 请求成功 Block
 *  @param fail    请求失败 Block
 */
+ (void)requestThingContentByIndex:(NSInteger)index success:(SuccessBlock)success failBlock:(FailBlock)fail {
	AFHTTPRequestOperationManager *manager = [HTTPTool initAFHttpManager];
	NSDictionary *parameters = [self parametersWithIndex:index];
	[manager GET:URL_GET_THING_CONTENT parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		success(operation,responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		fail(operation,error);
	}];
}

@end
