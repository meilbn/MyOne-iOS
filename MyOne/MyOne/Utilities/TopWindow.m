//
//  TopWindow.m
//  MyOne
//
//  Created by HelloWorld on 8/16/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "TopWindow.h"

@implementation TopWindow

static UIWindow *window;

//初始化window
+ (void)initialize {
	window = [[UIWindow alloc] init];
	window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
	window.windowLevel = UIWindowLevelAlert;
//	window.rootViewController = [[UIViewController alloc] init];
//	window.backgroundColor = [UIColor clearColor];
	[window addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show {
	window.hidden = NO;
}

+ (void)hide {
	window.hidden = YES;
}

// 监听窗口点击
+ (void)windowClick {
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview {
	for (UIScrollView *subview in superview.subviews) {
		// 如果是scrollview, 滚动最顶部
		if ([subview isKindOfClass:[UIScrollView class]] && [self isShowingOnKeyWindow:subview]) {
			CGPoint offset = subview.contentOffset;
			offset.y = - subview.contentInset.top;
			[subview setContentOffset:offset animated:YES];
		}
		// 递归继续查找子控件
		[self searchScrollViewInView:subview];
	}
}
+ (BOOL)isShowingOnKeyWindow:(UIView *)view {
	// 主窗口
	UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
	// 以主窗口左上角为坐标原点, 计算self的矩形框
	CGRect newFrame = [keyWindow convertRect:view.frame fromView:view.superview];
	CGRect winBounds = keyWindow.bounds;
	// 主窗口的bounds 和 self的矩形框 是否有重叠
	BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
	return !view.isHidden && view.alpha > 0.01 && view.window == keyWindow && intersects;
}

@end
