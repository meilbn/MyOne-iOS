//
//  ThingEntity.m
//  MyOne
//
//  Created by HelloWorld on 7/29/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "ThingEntity.h"

@implementation ThingEntity

- (NSString *)description {
	return [NSString stringWithFormat:@"strLastUpdateDate = %@, strPn = %@, strBu = %@, strTm = %@, strWu = %@, strId = %@, strTt = %@, strTc = %@.", self.strLastUpdateDate, self.strPn, self.strBu, self.strTm, self.strWu, self.strId, self.strTt, self.strTc];
}

@end
