//
//  ReadingView.h
//  MyOne
//
//  Created by HelloWorld on 8/2/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReadingEntity;

@interface ReadingView : UIView

- (void)configureReadingViewWithReadingEntity:(ReadingEntity *)readingEntity;

- (void)refreshSubviewsForNewItem;

@end
