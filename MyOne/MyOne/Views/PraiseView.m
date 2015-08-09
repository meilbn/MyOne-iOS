//
//  PraiseView.m
//  MyOne
//
//  Created by HelloWorld on 8/2/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "PraiseView.h"

@interface PraiseView ()

@property (strong, nonatomic) UIButton *praiseNumberBtn;

@end

@implementation PraiseView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setUpViews];
	}
	
	return self;
}

- (void)setUpViews {
	[DKNightVersionManager addClassToSet:self.class];
	self.backgroundColor = [UIColor clearColor];
	self.nightBackgroundColor = [UIColor clearColor];
	// 初始化点赞 Button
	self.praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.praiseNumberBtn.titleLabel.font = systemFont(12);
	[self.praiseNumberBtn setTitleColor:PraiseBtnTextColor forState:UIControlStateNormal];
	self.praiseNumberBtn.nightTitleColor = PraiseBtnTextColor;
	UIImage *btnImage = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:20 topCapHeight:2];
	[self.praiseNumberBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
	[self.praiseNumberBtn setImage:[UIImage imageNamed:@"home_like"] forState:UIControlStateNormal];
	[self.praiseNumberBtn setImage:[UIImage imageNamed:@"home_like_hl"] forState:UIControlStateSelected];
	self.praiseNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
	self.praiseNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[self addSubview:self.praiseNumberBtn];
}

- (void)configureViewWithPraiseNumber:(NSString *)praiseNumber {
	[self.praiseNumberBtn setTitle:praiseNumber forState:UIControlStateNormal];
	[self.praiseNumberBtn sizeToFit];
//	NSLog(@"self.praiseNumberBtn.frame = %@", NSStringFromCGRect(self.praiseNumberBtn.frame));
	CGFloat btnWidth = CGRectGetWidth(self.praiseNumberBtn.frame) + 22;
	CGRect btnFrame = CGRectMake(SCREEN_WIDTH - btnWidth, 30, btnWidth, CGRectGetHeight(self.praiseNumberBtn.frame));
	self.praiseNumberBtn.frame = btnFrame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
