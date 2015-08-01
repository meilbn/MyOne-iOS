//
//  HomeView.m
//  MyOne
//
//  Created by HelloWorld on 7/31/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "HomeView.h"
#import <Masonry/Masonry.h>
#import "HomeEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define VOLTextColor [UIColor colorWithRed:85 / 255.0 green:85 / 255.0 blue:85 / 255.0 alpha:1] // #555555
#define PaintInfoTextColor [UIColor colorWithRed:85 / 255.0 green:85 / 255.0 blue:85 / 255.0 alpha:1] // #555555
#define DayTextColor [UIColor colorWithRed:55 / 255.0 green:194 / 255.0 blue:241 / 255.0 alpha:1] // #37C2F1
#define MonthAndYearTextColor [UIColor colorWithRed:173 / 255.0 green:173 / 255.0 blue:173 / 255.0 alpha:1] // #ADADAD
#define PraiseBtnTextColor [UIColor colorWithRed:80 / 255.0 green:80 / 255.0 blue:80 / 255.0 alpha:1] // #505050

@interface HomeView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *volLabel;
@property (nonatomic, strong) UIImageView *paintImageView;
@property (nonatomic, strong) UILabel *paintNameLabel;
@property (nonatomic, strong) UILabel *paintAuthorLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *monthAndYearLabel;
@property (nonatomic, strong) UIImageView *contentBGImageView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *praiseNumberBtn;

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setUpViews];
	}
	
	return self;
}

- (void)setUpViews {
	// 初始化 ScrollView
	self.scrollView = [UIScrollView new];
	self.scrollView.showsVerticalScrollIndicator = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.alwaysBounceVertical = YES;
	self.scrollView.backgroundColor = [UIColor whiteColor];
	[self addSubview:self.scrollView];
	[self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
	}];
	
	// 初始化 containerView
	self.containerView = [UIView new];
	[self.scrollView addSubview:self.containerView];
	[self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
	}];
	
	// 初始化 volLabel
	self.volLabel = [UILabel new];
	self.volLabel.font = systemFont(13);
	self.volLabel.textColor = VOLTextColor;
	[self.containerView addSubview:self.volLabel];
	[self.volLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.top.equalTo(self.containerView.mas_top).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
		make.height.mas_equalTo(@16);
	}];
	
	// 初始化 paintImageView
	self.paintImageView = [UIImageView new];
	[self.containerView addSubview:self.paintImageView];
	CGFloat paintWidth = SCREEN_WIDTH - 20;
	CGFloat paintHeight = paintWidth * 0.75;
	[self.paintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.volLabel.mas_bottom).with.offset(10);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
		make.height.mas_equalTo(@(paintHeight));
	}];
	
	// 初始化 paintNameLabel
	self.paintNameLabel = [UILabel new];
	self.paintNameLabel.textColor = PaintInfoTextColor;
	self.paintNameLabel.font = systemFont(12);
	self.paintNameLabel.textAlignment = NSTextAlignmentRight;
	[self.containerView addSubview:self.paintNameLabel];
	[self.paintNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintImageView.mas_bottom).with.offset(10);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化 paintAuthorLabel
	self.paintAuthorLabel = [UILabel new];
	self.paintAuthorLabel.textColor = PaintInfoTextColor;
	self.paintAuthorLabel.font = systemFont(12);
	self.paintAuthorLabel.textAlignment = NSTextAlignmentRight;
	[self.containerView addSubview:self.paintAuthorLabel];
	[self.paintAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintNameLabel.mas_bottom).with.offset(0);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化 dayLabel
	self.dayLabel = [UILabel new];
	self.dayLabel.textColor = DayTextColor;
	self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:43];
	self.dayLabel.textAlignment = NSTextAlignmentCenter;
	self.dayLabel.shadowOffset = CGSizeMake(1, 1);
	self.dayLabel.shadowColor = [UIColor whiteColor];
	[self.containerView addSubview:self.dayLabel];
	[self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintAuthorLabel.mas_bottom).with.offset(20);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.width.mas_equalTo(@70);
		make.height.mas_equalTo(@33);
	}];
	
	// 初始化 monthAndYearLabel
	self.monthAndYearLabel = [UILabel new];
	self.monthAndYearLabel.textColor = MonthAndYearTextColor;
	self.monthAndYearLabel.font = [UIFont fontWithName:@"CenturyGothic-Bold" size:10];
	self.monthAndYearLabel.textAlignment = NSTextAlignmentCenter;
	self.monthAndYearLabel.shadowOffset = CGSizeMake(1, 1);
	self.monthAndYearLabel.shadowColor = [UIColor whiteColor];
	[self.containerView addSubview:self.monthAndYearLabel];
	[self.monthAndYearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.dayLabel.mas_bottom).with.offset(2);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.width.mas_equalTo(@70);
		make.height.mas_equalTo(@12);
	}];
	
	// 初始化 contentBGImageView
	self.contentBGImageView = [UIImageView new];
	[self.containerView addSubview:self.contentBGImageView];
	[self.contentBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintAuthorLabel.mas_bottom).with.offset(20);
		make.left.equalTo(self.dayLabel.mas_right).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化 contentTextView
	self.contentTextView = [UITextView new];
	self.contentTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
	self.contentTextView.editable = NO;
	self.contentTextView.scrollEnabled = NO;
	self.contentTextView.backgroundColor = [UIColor clearColor];
	[self.contentBGImageView addSubview:self.contentTextView];
	[self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.contentBGImageView.mas_left).with.offset(6);
		make.top.equalTo(self.contentBGImageView.mas_top).with.offset(0);
		make.right.equalTo(self.contentBGImageView.mas_right).with.offset(-6);
		make.bottom.equalTo(self.contentBGImageView.mas_bottom).with.offset(0);
	}];
	
	// 初始化 praiseNumberBtn
	self.praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.praiseNumberBtn.titleLabel.font = systemFont(12);
	[self.praiseNumberBtn setTitleColor:PraiseBtnTextColor forState:UIControlStateNormal];
	UIImage *btnImage = [[UIImage imageNamed:@"home_likeBg"] stretchableImageWithLeftCapWidth:20 topCapHeight:2];
	[self.praiseNumberBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
	[self.praiseNumberBtn setImage:[UIImage imageNamed:@"home_like"] forState:UIControlStateNormal];
	[self.praiseNumberBtn setImage:[UIImage imageNamed:@"home_like_hl"] forState:UIControlStateSelected];
	self.praiseNumberBtn.imageEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
	self.praiseNumberBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
	[self.praiseNumberBtn addTarget:self action:@selector(praise) forControlEvents:UIControlEventTouchUpInside];
	[self.containerView addSubview:self.praiseNumberBtn];
	[self.praiseNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.contentBGImageView.mas_bottom).with.offset(30);
		make.right.equalTo(self.containerView.mas_right).with.offset(0);
		make.height.mas_equalTo(@28);
		make.bottom.equalTo(self.containerView.mas_bottom).with.offset(-16);
	}];
}

- (void)configureViewWithHomeEntity:(HomeEntity *)homeEntity {
	self.volLabel.text = homeEntity.strHpTitle;
	[self.paintImageView sd_setImageWithURL:[NSURL URLWithString:homeEntity.strThumbnailUrl]];
	self.paintNameLabel.text = [homeEntity.strAuthor componentsSeparatedByString:@"&"][0];
	self.paintAuthorLabel.text = [homeEntity.strAuthor componentsSeparatedByString:@"&"][1];
	NSString *marketTime = [BaseFunction getHomeENMarketTimeWithOriginalMarketTime:homeEntity.strMarketTime];
	self.dayLabel.text = [marketTime componentsSeparatedByString:@"&"][0];
	self.monthAndYearLabel.text = [marketTime componentsSeparatedByString:@"&"][1];
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 5;
	NSDictionary *attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
								NSForegroundColorAttributeName : [UIColor whiteColor],
								NSFontAttributeName : [UIFont systemFontOfSize:13]};
	self.contentTextView.attributedText = [[NSAttributedString alloc] initWithString:homeEntity.strContent attributes:attribute];
	[self.contentTextView sizeToFit];
	
	self.contentBGImageView.image = [[UIImage imageNamed:@"contBack"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
	
	[self.praiseNumberBtn setTitle:[NSString stringWithFormat:@"  %@", homeEntity.strPn] forState:UIControlStateNormal];
	[self.praiseNumberBtn sizeToFit];

	self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.containerView.frame));
}

- (void)praise {
	self.praiseNumberBtn.selected = !self.praiseNumberBtn.isSelected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
