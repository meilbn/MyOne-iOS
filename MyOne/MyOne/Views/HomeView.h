//
//  HomeView.h
//  MyOne
//
//  Created by HelloWorld on 7/31/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeEntity;

@interface HomeView : UIView

- (void)configureViewWithHomeEntity:(HomeEntity *)homeEntity animated:(BOOL)animated;

- (void)refreshSubviewsForNewItem;

@end
