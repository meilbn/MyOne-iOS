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

/**
 *  按照给定的数据显示视图
 *
 *  @param homeEntity 要显示的数据
 *  @param animated   是否需要图片的加载动画
 */
- (void)configureViewWithHomeEntity:(HomeEntity *)homeEntity animated:(BOOL)animated;

/**
 *  刷新视图内的子视图，主要是为了准备显示新的 item
 */
- (void)refreshSubviewsForNewItem;

@end
