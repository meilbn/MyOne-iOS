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
	unsigned char result[16];
	CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
	return [NSString stringWithFormat:
			@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];
}

+ (NSDictionary *)loadTestDatasWithFileName:(NSString *)fileName {
	NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@".txt"];
	NSData *fileData = [NSData dataWithContentsOfFile:filePath];
	NSDictionary *testData = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:nil];
	
	return testData;
}

@end
