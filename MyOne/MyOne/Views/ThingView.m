//
//  ThingView.m
//  MyOne
//
//  Created by HelloWorld on 8/2/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "ThingView.h"
#import "ThingEntity.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

#define ThingNameTextColor [UIColor colorWithRed:90 / 255.0 green:91 / 255.0 blue:92 / 255.0 alpha:1] // #5A5B5C
#define ThingDescriptionColor [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] // #333333

@interface ThingView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *thingImageView;
@property (nonatomic, strong) UILabel *thingNameLabel;
@property (nonatomic, strong) UITextView *thingDescriptionTextView;

@end

@implementation ThingView

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
	self.containerView.backgroundColor = self.scrollView.backgroundColor;
	[self.scrollView addSubview:self.containerView];
	[self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
	}];
	
	// 初始化 dateLabel
	self.dateLabel = [UILabel new];
	self.dateLabel.font = systemFont(13);
	self.dateLabel.textColor = DateTextColor;
	[self.containerView addSubview:self.dateLabel];
	[self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.containerView.mas_top).with.offset(12);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
	}];
	
	// 初始化 thingImageView
	self.thingImageView = [UIImageView new];
	CGFloat imgWidth = SCREEN_WIDTH - 20;
	CGFloat imgHeight = imgWidth;
	[self.containerView addSubview:self.thingImageView];
	[self.thingImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.dateLabel.mas_bottom).with.offset(10);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView.mas_right).with.offset(-10);
		make.height.mas_equalTo(@(imgHeight));
	}];
	
	// 初始化 thingNameLabel
	self.thingNameLabel = [UILabel new];
	self.thingNameLabel.numberOfLines = 0;
	self.thingNameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
	self.thingNameLabel.textColor = ThingNameTextColor;
	[self.containerView addSubview:self.thingNameLabel];
	[self.thingNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.thingImageView.mas_bottom).with.offset(32);
		make.left.equalTo(self.containerView.mas_left).with.offset(15);
		make.right.equalTo(self.containerView.mas_right).with.offset(-15);
	}];
	
	// 初始化 thingDescriptionTextView
	self.thingDescriptionTextView = [UITextView new];
	self.thingDescriptionTextView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0);
	self.thingDescriptionTextView.editable = NO;
	self.thingDescriptionTextView.scrollEnabled = NO;
	self.thingDescriptionTextView.pagingEnabled = NO;
	self.thingDescriptionTextView.scrollsToTop = NO;
	self.thingDescriptionTextView.directionalLockEnabled = NO;
	self.thingDescriptionTextView.alwaysBounceVertical = NO;
	self.thingDescriptionTextView.alwaysBounceHorizontal = NO;
	[self.containerView addSubview:self.thingDescriptionTextView];
	[self.thingDescriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.thingNameLabel.mas_bottom).with.offset(25);
		make.left.equalTo(self.containerView.mas_left).with.offset(10);
		make.right.equalTo(self.containerView).with.offset(-10);
		make.bottom.equalTo(self.containerView.mas_bottom).with.offset(-10);
	}];
}

- (void)configureViewWithThingEntity:(ThingEntity *)thingEntity {
	self.dateLabel.text = [BaseFunction getENMarketTimeWithOriginalMarketTime:thingEntity.strTm];
	[self.thingImageView sd_setImageWithURL:[NSURL URLWithString:thingEntity.strBu]];
	self.thingNameLabel.text = thingEntity.strTt;

	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = 5;
	NSDictionary *attribute = @{NSParagraphStyleAttributeName : paragraphStyle,
								NSForegroundColorAttributeName : ThingDescriptionColor,
								NSFontAttributeName : [UIFont systemFontOfSize:15]};
	self.thingDescriptionTextView.attributedText = [[NSAttributedString alloc] initWithString:thingEntity.strTc attributes:attribute];
	[self.thingDescriptionTextView sizeToFit];
	
	self.scrollView.contentSize = CGSizeMake(0, CGRectGetHeight(self.containerView.frame));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
