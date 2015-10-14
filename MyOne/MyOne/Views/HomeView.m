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
#import "CustomImageView.h"

#define PaintInfoTextColor [UIColor colorWithRed:85 / 255.0 green:85 / 255.0 blue:85 / 255.0 alpha:1] // #555555
#define DayTextColor [UIColor colorWithRed:55 / 255.0 green:194 / 255.0 blue:241 / 255.0 alpha:1] // #37C2F1
#define MonthAndYearTextColor [UIColor colorWithRed:173 / 255.0 green:173 / 255.0 blue:173 / 255.0 alpha:1] // #ADADAD

@interface HomeView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *volLabel;
@property (nonatomic, strong) CustomImageView *paintImageView;
@property (nonatomic, strong) UILabel *paintNameLabel;
@property (nonatomic, strong) UILabel *paintAuthorLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *monthAndYearLabel;
@property (nonatomic, strong) UIImageView *contentBGImageView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *praiseNumberBtn;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;// item 加载中转转的菊花

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
	[DKNightVersionManager addClassToSet:self.class];
	self.backgroundColor = [UIColor whiteColor];
	// 设置夜间模式背景色
	self.nightBackgroundColor = NightBGViewColor;
	// 初始化 ScrollView
	self.scrollView = [UIScrollView new];
	self.scrollView.showsVerticalScrollIndicator = YES;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.alwaysBounceVertical = YES;
	self.scrollView.tag = ScrollViewTag;
	self.scrollView.backgroundColor = [UIColor whiteColor];
	self.scrollView.nightBackgroundColor = NightBGViewColor;
	self.scrollView.scrollsToTop = YES;
	[self addSubview:self.scrollView];
	[self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
	}];
	
	// 初始化容器视图
	self.containerView = [UIView new];
	[self.scrollView addSubview:self.containerView];
	self.containerView.backgroundColor = [UIColor whiteColor];
	self.containerView.nightBackgroundColor = NightBGViewColor;
	[self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
	}];
	
	// 初始化 VOL 文字控件
	self.volLabel = [UILabel new];
	self.volLabel.font = systemFont(13);
	self.volLabel.textColor = VOLTextColor;
	self.volLabel.nightTextColor = VOLTextColor;
	self.volLabel.backgroundColor = [UIColor whiteColor];
	self.volLabel.nightBackgroundColor = NightBGViewColor;
	[self.containerView addSubview:self.volLabel];
	[self.volLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.top.equalTo(self.containerView.mas_top).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
		make.height.mas_equalTo(@16);
	}];
	
	// 初始化显示画控件
	self.paintImageView = [[CustomImageView alloc] init];
	self.paintImageView.backgroundColor = [UIColor whiteColor];
	self.paintImageView.nightBackgroundColor = NightBGViewColor;
	[self.containerView addSubview:self.paintImageView];
	CGFloat paintWidth = SCREEN_WIDTH - 20;
	CGFloat paintHeight = paintWidth * 0.75;
	[self.paintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.volLabel.mas_bottom).with.offset(10);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
		make.height.mas_equalTo(@(paintHeight));
	}];
	
	// 初始化画名文字控件
	self.paintNameLabel = [UILabel new];
	self.paintNameLabel.textColor = PaintInfoTextColor;
	self.paintNameLabel.nightTextColor = PaintInfoTextColor;
	self.paintNameLabel.font = systemFont(12);
	self.paintNameLabel.textAlignment = NSTextAlignmentRight;
	[self.containerView addSubview:self.paintNameLabel];
	[self.paintNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintImageView.mas_bottom).with.offset(10);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化画作者
	self.paintAuthorLabel = [UILabel new];
	self.paintAuthorLabel.textColor = PaintInfoTextColor;
	self.paintAuthorLabel.nightTextColor = PaintInfoTextColor;
	self.paintAuthorLabel.font = systemFont(12);
	self.paintAuthorLabel.textAlignment = NSTextAlignmentRight;
	[self.containerView addSubview:self.paintAuthorLabel];
	[self.paintAuthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintNameLabel.mas_bottom).with.offset(0);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化日文字控件
	self.dayLabel = [UILabel new];
	self.dayLabel.textColor = DayTextColor;
	self.dayLabel.nightTextColor = DayTextColor;
	self.dayLabel.backgroundColor = [UIColor whiteColor];
	self.dayLabel.nightBackgroundColor = NightBGViewColor;
	self.dayLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:43];
	self.dayLabel.textAlignment = NSTextAlignmentCenter;
	self.dayLabel.shadowOffset = CGSizeMake(1, 1);
	self.dayLabel.shadowColor = [UIColor whiteColor];
	[self.containerView addSubview:self.dayLabel];
	[self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintAuthorLabel.mas_bottom).with.offset(20);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.width.mas_equalTo(@70);
		make.height.mas_equalTo(@40);
	}];
	
	// 初始化月和年文字控件
	self.monthAndYearLabel = [UILabel new];
	self.monthAndYearLabel.textColor = MonthAndYearTextColor;
	self.monthAndYearLabel.nightTextColor = MonthAndYearTextColor;
	self.monthAndYearLabel.backgroundColor = [UIColor whiteColor];
	self.monthAndYearLabel.nightBackgroundColor = NightBGViewColor;
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
	
	// 初始化内容背景图片控件
	self.contentBGImageView = [UIImageView new];
	[self.containerView addSubview:self.contentBGImageView];
	[self.contentBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.paintAuthorLabel.mas_bottom).with.offset(20);
		make.left.equalTo(self.dayLabel.mas_right).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化内容控件
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
	
	// 初始化点赞按钮
	self.praiseNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	self.praiseNumberBtn.titleLabel.font = systemFont(12);
	[self.praiseNumberBtn setTitleColor:PraiseBtnTextColor forState:UIControlStateNormal];
	self.praiseNumberBtn.nightTitleColor = PraiseBtnTextColor;
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
	
	// 初始化加载中的菊花控件
	self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.indicatorView.hidesWhenStopped = YES;
	[self addSubview:self.indicatorView];
}

- (void)startRefreshing {
	self.indicatorView.center = self.center;
	if (Is_Night_Mode) {
		self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
	} else {
		self.indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	}
	[self.indicatorView startAnimating];
}

- (void)configureViewWithHomeEntity:(HomeEntity *)homeEntity animated:(BOOL)animated {
	self.scrollView.backgroundColor =  Is_Night_Mode ? NightBGViewColor : [UIColor whiteColor];
	
	[self.indicatorView stopAnimating];
	self.containerView.hidden = NO;
	
	CGFloat activationPointX = self.scrollView.accessibilityActivationPoint.x;
	if (activationPointX > 0 && activationPointX < SCREEN_WIDTH) {
		self.scrollView.scrollsToTop = YES;
	} else {
		self.scrollView.scrollsToTop = NO;
	}
	
	self.volLabel.text = homeEntity.strHpTitle;
	[self.paintImageView configureImageViwWithImageURL:[NSURL URLWithString:homeEntity.strThumbnailUrl] animated:animated];
	self.paintNameLabel.text = [homeEntity.strAuthor componentsSeparatedByString:@"&"][0];
	self.paintAuthorLabel.text = [homeEntity.strAuthor componentsSeparatedByString:@"&"][1];
	NSString *marketTime = [BaseFunction homeENMarketTimeWithOriginalMarketTime:homeEntity.strMarketTime];
	self.dayLabel.text = [marketTime componentsSeparatedByString:@"&"][0];
	self.monthAndYearLabel.text = [marketTime componentsSeparatedByString:@"&"][1];
	if (Is_Night_Mode) {
		self.dayLabel.shadowColor = [UIColor blackColor];
		self.monthAndYearLabel.shadowColor = [UIColor blackColor];
	}
	
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 5;
	NSDictionary *attribute;
	if (Is_Night_Mode) {
		attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
					  NSForegroundColorAttributeName : NightHomeTextColor,
					  NSFontAttributeName : [UIFont systemFontOfSize:13]};
	} else {
		attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
					  NSForegroundColorAttributeName : [UIColor whiteColor],
					  NSFontAttributeName : [UIFont systemFontOfSize:13]};
	}
	
	self.contentTextView.attributedText = [[NSAttributedString alloc] initWithString:homeEntity.strContent attributes:attribute];
	[self.contentTextView sizeToFit];
	
	if (Is_Night_Mode) {
		self.contentBGImageView.image = [[UIImage imageNamed:@"contBack_nt"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
	} else {
		self.contentBGImageView.image = [[UIImage imageNamed:@"contBack"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
	}
	
	[self.praiseNumberBtn setTitle:[NSString stringWithFormat:@"  %@", homeEntity.strPn] forState:UIControlStateNormal];
	[self.praiseNumberBtn sizeToFit];

	self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.containerView.frame));
}

- (void)refreshSubviewsForNewItem {
	self.volLabel.text = @"";
//	self.paintImageView.image = nil;
	self.paintNameLabel.text = @"";
	self.paintAuthorLabel.text = @"";
	self.dayLabel.text = @"";
	self.monthAndYearLabel.text = @"";
	
	self.contentTextView.text = @"";
	[self.contentTextView sizeToFit];
	
	self.contentBGImageView.image = nil;
	
	[self.praiseNumberBtn setTitle:@"" forState:UIControlStateNormal];
	[self.praiseNumberBtn sizeToFit];
	
	self.containerView.hidden = YES;
	self.scrollView.scrollsToTop = NO;
	
	[self startRefreshing];
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
