//
//  CircularLoaderView.h
//  MyOne
//
//  Created by HelloWorld on 8/3/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularLoaderView : UIView

@property (nonatomic, assign) CGFloat progress;
//@property (nonatomic, assign) CAShapeLayer *circlePathLayer;
//@property (nonatomic, assign, getter=isRevealed) BOOL revealed;

- (void)reveal;

@end
