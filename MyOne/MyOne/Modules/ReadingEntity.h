//
//  ReadingEntity.h
//  MyOne
//
//  Created by HelloWorld on 7/29/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadingEntity : NSObject

//"strContent" : "浪子与六......"
//"sRdNum" : "112108",
//"strContentId" : "1105",
//"subTitle" : "",
//"strContDayDiffer" : "",
//"strPraiseNumber" : "3079",
//"strLastUpdateDate" : "2015-07-28 10:13:35",
//"sGW" : "此刻的“萨德侯爵”，在天国门口，发射出马克沁重机枪般疯狂的子弹，宛如狂风暴雨扫过最漫长的那一夜，将世界摧枯拉朽地打成筛子，同时也耗尽自己最后一滴魂魄。",
//"sAuth" : "蔡骏，悬疑作家。",
//"sWebLk" : "http:\/\/m.wufazhuce.com\/article\/2015-07-28",
//"wImgUrl" : "http:\/\/211.152.49.184:9000\/upload\/onephoto\/f1437546015695.jpg",
//"strContAuthorIntroduce" : "（责任编辑：卫天成）",
//"strContTitle" : "黄片审查员萨德侯爵的一夜",
//"sWbN" : "@蔡骏",
//"strContAuthor" : "蔡骏",
//"strContMarketTime" : "2015-07-28"

@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) NSString *sRdNum;
@property (nonatomic, copy) NSString *strContentId;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *strContDayDiffer;
@property (nonatomic, copy) NSString *strPraiseNumber;
@property (nonatomic, copy) NSString *strLastUpdateDate;
@property (nonatomic, copy) NSString *sGW;
@property (nonatomic, copy) NSString *sAuth;
@property (nonatomic, copy) NSString *sWebLk;
@property (nonatomic, copy) NSString *wImgUrl;
@property (nonatomic, copy) NSString *strContAuthorIntroduce;
@property (nonatomic, copy) NSString *strContTitle;
@property (nonatomic, copy) NSString *sWbN;
@property (nonatomic, copy) NSString *strContAuthor;
@property (nonatomic, copy) NSString *strContMarketTime;

@end
