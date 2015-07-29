//
//  HomeEntity.h
//  MyOne
//
//  Created by HelloWorld on 7/29/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeEntity : NSObject

//"strLastUpdateDate": "2015-07-22 15:50:45",
//"strDayDiffer": "",
//"strHpId": "1043",
//"strHpTitle": "VOL.1024",
//"strThumbnailUrl": "http:\/\/pic.yupoo.com\/hanapp\/EOTa3fZW\/69lSZ.jpg",
//"strOriginalImgUrl": "http:\/\/pic.yupoo.com\/hanapp\/EOTa3fZW\/69lSZ.jpg",
//"strAuthor": "花&高思远 作品",
//"strContent": "分别是，从此就一个人站在茫茫人群中，一个人站在世界上。我的每句话、每件事，都不能再说给你听。 by 苏更生",
//"strMarketTime": "2015-07-28",
//"sWebLk": "http:\/\/m.wufazhuce.com\/one\/2015-07-28",
//"strPn": "20592",
//"wImgUrl": "http:\/\/211.152.49.184:9000\/upload\/onephoto\/f1437551445290.jpg"

@property (nonatomic, copy) NSString *strLastUpdateDate;
@property (nonatomic, copy) NSString *strDayDiffer;
@property (nonatomic, copy) NSString *strHpId;
@property (nonatomic, copy) NSString *strHpTitle;
@property (nonatomic, copy) NSString *strThumbnailUrl;
@property (nonatomic, copy) NSString *strOriginalImgUrl;
@property (nonatomic, copy) NSString *strAuthor;
@property (nonatomic, copy) NSString *strContent;
@property (nonatomic, copy) NSString *strMarketTime;
@property (nonatomic, copy) NSString *sWebLk;
@property (nonatomic, copy) NSString *strPn;
@property (nonatomic, copy) NSString *wImgUrl;

@end
