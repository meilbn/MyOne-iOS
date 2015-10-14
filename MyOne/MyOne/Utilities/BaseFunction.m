//
//  BaseFunction.m
//  MyOne
//
//  Created by HelloWorld on 7/28/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "BaseFunction.h"
#import <CommonCrypto/CommonDigest.h>
#import <MJExtension/MJExtension.h>

// 1天的长度
static const NSTimeInterval oneDay = 24 * 60 * 60;

@implementation BaseFunction

/**
 *  取一个随机整数 0~x-1
 **/
+ (int)random:(int)x {
	return arc4random() % x;
}

/**
 *  MD5加密
 **/
+ (NSString *)md5Digest:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_BLOCK_BYTES];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
	
	NSMutableString *md5Result = [[NSMutableString alloc] init];
	for (int i = 0; i < CC_MD5_BLOCK_BYTES; i++) {
		[md5Result appendFormat:@"%02x", result[i]];
	}
	
	return md5Result;
//	return [NSString stringWithFormat:
//			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//			result[0], result[1], result[2], result[3],
//			result[4], result[5], result[6], result[7],
//			result[8], result[9], result[10], result[11],
//			result[12], result[13], result[14], result[15]];
}

+ (NSDictionary *)loadTestDatasWithFileName:(NSString *)fileName {
	NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".txt"];
	NSData *fileData = [NSData dataWithContentsOfFile:filePath];
	NSDictionary *testData = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:nil];
	
	return testData;
}

+ (NSString *)enMarketTimeWithOriginalMarketTime:(NSString *)originalMarketTime {
	NSDate *marketTime = [self dateFromString:originalMarketTime];
	NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setDateFormat:@"MMMM dd, yyyy"];
	NSString *readingENMarketTime = [dateformatter stringFromDate:marketTime];
	
	return readingENMarketTime;
}

+ (NSString *)homeENMarketTimeWithOriginalMarketTime:(NSString *)originalMarketTime {
	NSDate *marketTime = [self dateFromString:originalMarketTime];
	NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setDateFormat:@"dd&MMM , yyyy"];
	NSString *readingENMarketTime = [dateformatter stringFromDate:marketTime];
	
	return readingENMarketTime;
}

+ (NSDate *)dateFromString:(NSString *)dateStr {
	NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
	[inputFormatter setDateFormat:@"yyyy-MM-dd"];
	[inputFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
	// 标准时间
	return [inputFormatter dateFromString:dateStr];
}

// 将当前时间转成字符串，格式：yyyy-MM-dd
+ (NSString *)stringDateFromCurrent {
	NSDate *currentDate = [NSDate date];
	NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setDateFormat:@"yyyy-MM-dd"];
	NSString *currDateString = [dateformatter stringFromDate:currentDate];
	
	return currDateString;
}

/**
 *  获取今天之前的相应天数的日期
 *
 *  @param days 几天之前
 *
 *  @return 相应天数之前的那天的日期
 */
+ (NSString *)stringDateBeforeTodaySeveralDays:(NSInteger)days {
	NSString *stringDate = @"";
	
	NSDate *now = [NSDate date];
	NSDate *theDate;
	
	if (days != 0) {
		theDate = [now initWithTimeIntervalSinceNow:(-oneDay * days)];
	} else {
		theDate = now;
	}
	
	stringDate = [BaseFunction stringDateFromDate:theDate];
	
	return stringDate;
}

+ (NSString *)stringDateFromDate:(NSDate *)date {
	NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
	[dateformatter setDateFormat:@"yyyy-MM-dd"];
	NSString *dateString = [dateformatter stringFromDate:date];
	
	return dateString;
}

@end
