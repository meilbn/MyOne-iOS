//
//  ReadingAuthorView.m
//  MyOne
//
//  Created by HelloWorld on 7/30/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "ReadingAuthorView.h"
#import "ReadingEntity.h"

#define AuthorTextViewColor [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] // #333333
#define AuthorTextColor [UIColor colorWithRed:90 / 255.0 green:91 / 255.0 blue:92 / 255.0 alpha:1] // #5A5B5C
#define AuthorWenNameTextColor [UIColor colorWithRed:172 / 255.0 green:177 / 255.0 blue:180 / 255.0 alpha:1] // #ACB1B4

#define PaddingLeftRight 15
#define PaddingTopBottom 30

@interface ReadingAuthorView ()

@property (strong, nonatomic) UIButton *praiseNumberBtn;
@property (strong, nonatomic) UIImageView *horizontalLine;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *authorWebNameLabel;
@property (strong, nonatomic) UITextView *authorDescriptionTextView;

@end

@implementation ReadingAuthorView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setUpViews];
	}
	
	return self;
}

- (void)setUpViews {
	[DKNightVersionManager addClassToSet:self.class];
	self.backgroundColor = [UIColor whiteColor];
	// 设置夜间模式背景色
	self.nightBackgroundColor = NightBGViewColor;
	// 初始化点赞 Button
	self.praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.praiseNumberBtn.titleLabel.font = systemFont(12);
	[self.praiseNumberBtn setTitleColor:PraiseBtnTextColor forState:UIControlStateNormal];
	self.praiseNumberBtn.nightTitleColor = PraiseBtnTextColor;
	UIImage *btnImage = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:45 topCapHeight:0];
	[self.praiseNumberBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
	[self.praiseNumberBtn setImage:[UIImage imageNamed:@"home_like"] forState:UIControlStateNormal];
	[self.praiseNumberBtn setImage:[UIImage imageNamed:@"home_like_hl"] forState:UIControlStateSelected];
	self.praiseNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
	self.praiseNumberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
	[self addSubview:self.praiseNumberBtn];
	
	// 初始化水平分割线
	self.horizontalLine = [[UIImageView alloc] initWithFrame:CGRectMake(PaddingLeftRight, 88, SCREEN_WIDTH - PaddingLeftRight * 2, 1)];
	self.horizontalLine.image = [UIImage imageNamed:@"horizontalLine"];
	[self addSubview:self.horizontalLine];
	
	// 初始化作者名字 Label
	self.authorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.authorLabel.textColor = AuthorTextColor;
	self.authorLabel.nightTextColor = NightTextColor;
	self.authorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
	[self addSubview:self.authorLabel];
	
	// 初始化作者网名 Label
	self.authorWebNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.authorWebNameLabel.textColor = AuthorWenNameTextColor;
	self.authorWebNameLabel.nightTextColor = UIColorFromRGB(0xACB1B4);
	self.authorWebNameLabel.font = systemFont(13);
	[self addSubview:self.authorWebNameLabel];
	
	// 初始化作者介绍 TextView
	self.authorDescriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
	self.authorDescriptionTextView.font = systemFont(15);
	self.authorDescriptionTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
	self.authorDescriptionTextView.editable = NO;
	self.authorDescriptionTextView.scrollEnabled = NO;
	self.authorDescriptionTextView.pagingEnabled = NO;
	self.authorDescriptionTextView.showsVerticalScrollIndicator = NO;
	self.authorDescriptionTextView.showsHorizontalScrollIndicator = NO;
	self.authorDescriptionTextView.backgroundColor = [UIColor whiteColor];
	self.authorDescriptionTextView.nightBackgroundColor = NightBGViewColor;
	[self addSubview:self.authorDescriptionTextView];
}

- (void)configureAuthorViewWithReadingEntity:(ReadingEntity *)readingEntity {
	// 点赞按钮
	[self.praiseNumberBtn setTitle:readingEntity.strPraiseNumber forState:UIControlStateNormal];
	[self.praiseNumberBtn sizeToFit];
//	NSLog(@"self.praiseNumberBtn.frame = %@", NSStringFromCGRect(self.praiseNumberBtn.frame));
	CGFloat btnWidth = CGRectGetWidth(self.praiseNumberBtn.frame) + 22;
	CGRect btnFrame = CGRectMake(SCREEN_WIDTH - btnWidth, PaddingTopBottom, btnWidth, CGRectGetHeight(self.praiseNumberBtn.frame));
	self.praiseNumberBtn.frame = btnFrame;
	
	// 作者
	self.authorLabel.text = readingEntity.strContAuthor;
	[self.authorLabel sizeToFit];
//	NSLog(@"self.authorLabel.frame = %@", NSStringFromCGRect(self.authorLabel.frame));
	CGRect authorLabelFrame = CGRectMake(PaddingLeftRight, CGRectGetMaxY(self.horizontalLine.frame) + 10, CGRectGetWidth(self.authorLabel.frame), CGRectGetHeight(self.authorLabel.frame));
	self.authorLabel.frame = authorLabelFrame;
	
	// 作者网名
	self.authorWebNameLabel.text = readingEntity.sWbN;
	[self.authorWebNameLabel sizeToFit];
//	NSLog(@"self.authorWebNameLabel.frame = %@", NSStringFromCGRect(self.authorWebNameLabel.frame));
	CGFloat wnLabelHeight = CGRectGetHeight(self.authorWebNameLabel.frame);
	CGFloat wnLabelY = CGRectGetMaxY(self.authorLabel.frame) - wnLabelHeight;
	CGFloat wnLabelX = CGRectGetMaxX(self.authorLabel.frame) + 5;
	CGRect authorWNLabelFrame = CGRectMake(wnLabelX, wnLabelY, SCREEN_WIDTH - wnLabelX, wnLabelHeight);
	self.authorWebNameLabel.frame = authorWNLabelFrame;
	
	// 作者介绍
	self.authorDescriptionTextView.text = readingEntity.sAuth;
	if (Is_Night_Mode) {
		self.authorDescriptionTextView.textColor = NightTextColor;
		self.authorDescriptionTextView.backgroundColor = NightBGViewColor;
	} else {
		self.authorDescriptionTextView.textColor = AuthorTextViewColor;
		self.authorDescriptionTextView.backgroundColor = [UIColor whiteColor];
	}
	[self.authorDescriptionTextView sizeToFit];
//	NSLog(@"self.authorDescriptionTextView.frame = %@", NSStringFromCGRect(self.authorDescriptionTextView.frame));
	CGRect textViewFrame = CGRectMake(PaddingLeftRight, CGRectGetMaxY(self.authorLabel.frame) + 20, SCREEN_WIDTH - PaddingLeftRight * 2, CGRectGetHeight(self.authorDescriptionTextView.frame));
	self.authorDescriptionTextView.frame = textViewFrame;
	
	CGRect selfFrame = self.frame;
	selfFrame.size.height = CGRectGetMaxY(self.authorDescriptionTextView.frame) + 10;
	self.frame = selfFrame;
	[self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
