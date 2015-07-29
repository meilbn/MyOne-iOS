//
//  ThingEntity.h
//  MyOne
//
//  Created by HelloWorld on 7/29/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThingEntity : NSObject

//"strLastUpdateDate": "2015-07-24 17:59:48",
//"strPn": "0",
//"strBu": "http:\/\/pic.yupoo.com\/hanapp\/EPcPLEFq\/KKBKE.jpg",
//"strTm": "2015-07-27",
//"strWu": "http:\/\/m.wufazhuce.com\/thing\/2015-07-27",
//"strId": "569",
//"strTt": "创意拼图",
//"strTc": "拼出一天好心情！"

@property (nonatomic, copy) NSString *strLastUpdateDate;
@property (nonatomic, copy) NSString *strPn;
@property (nonatomic, copy) NSString *strBu;
@property (nonatomic, copy) NSString *strTm;
@property (nonatomic, copy) NSString *strWu;
@property (nonatomic, copy) NSString *strId;
@property (nonatomic, copy) NSString *strTt;
@property (nonatomic, copy) NSString *strTc;

@end
