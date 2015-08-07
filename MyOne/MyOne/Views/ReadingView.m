//
//  ReadingView.m
//  MyOne
//
//  Created by HelloWorld on 8/2/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "ReadingView.h"
#import "ReadingEntity.h"
#import "ReadingAuthorView.h"

@interface ReadingView () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) ReadingAuthorView *readingAuthorView;

@end

@implementation ReadingView {
	ReadingEntity *currentContent;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setUpViews];
	}
	
	return self;
}

- (void)setUpViews {
	self.backgroundColor = Is_Night_Mode ? NightBGViewColor : [UIColor whiteColor];
	// 设置夜间模式背景色
	self.nightBackgroundColor = NightBGViewColor;
	
	self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
	self.webView.scrollView.showsVerticalScrollIndicator = YES;
	self.webView.scrollView.showsHorizontalScrollIndicator = NO;
	self.webView.scalesPageToFit = NO;
	self.webView.tag = WebViewTag;
	self.webView.backgroundColor = WebViewBGColor;
	self.webView.nightBackgroundColor = NightBGViewColor;
	self.webView.scrollView.backgroundColor = WebViewBGColor;
	self.webView.scrollView.nightBackgroundColor = NightBGViewColor;
	self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
	self.webView.multipleTouchEnabled = NO;
	self.webView.scrollView.scrollsToTop = YES;
	
	// webView 顶部添加一个 UIView，高度为34，UIView 里面再添加一个 UILabel，x 为15，y 为12，高度为16，左右距离为15，水平垂直居中，系统默认字体，颜色#555555，大小为13。
	UIView *webViewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34)];
	webViewTopView.tag = TopViewTag;
	webViewTopView.backgroundColor = DawnDateViewBGColor;
	webViewTopView.nightBackgroundColor = NightBGViewColor;
	self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(webViewTopView.frame) - 30, 16)];
	self.dateLabel.tag = TopViewTimeLabelTag;
	self.dateLabel.font = systemFont(13.0);
	self.dateLabel.textColor = DateTextColor;
	self.dateLabel.nightTextColor = DateTextColor;
	[webViewTopView addSubview:self.dateLabel];
	self.dateLabel.center = webViewTopView.center;
	[self.webView.scrollView addSubview:webViewTopView];
	
	[self addSubview:self.webView];
}

- (void)configureReadingViewWithReadingEntity:(ReadingEntity *)readingEntity {
	currentContent = readingEntity;
	
	self.dateLabel.text = [BaseFunction getENMarketTimeWithOriginalMarketTime:readingEntity.strContMarketTime];
	
	NSString *webViewBGColor = Is_Night_Mode ? NightWebViewBGColorName : DawnWebViewBGColorName;
	NSString *webViewContentTextColor = Is_Night_Mode ? NightWebViewTextColorName : DawnWebViewTextColorName;
	NSString *webViewTitleTextColor = Is_Night_Mode ? NightWebViewTextColorName : @"#5A5A5A";
	NSString *webViewAuthorTitleTextColor = Is_Night_Mode ? @"#575757" : @"#888888";
	
	NSMutableString *HTMLContent = [[NSMutableString alloc] init];
	[HTMLContent appendString:[NSString stringWithFormat:@"<body style=\"margin: 0px; background-color: %@;\"><div style=\"margin-bottom: 10px; background-color: %@;\">", webViewBGColor, webViewBGColor]];
	[HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章标题 --><p style=\"color: %@; font-size: 21px; font-weight: bold; margin-top: 34px; margin-left: 15px;\">%@</p>", webViewTitleTextColor, readingEntity.strContTitle]];
	[HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章作者 --><p style=\"color: %@; font-size: 14px; font-weight: bold; margin-left: 15px; margin-top: -15px;\">%@</p><p></p>", webViewAuthorTitleTextColor, readingEntity.strContAuthor]];
	[HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章内容 --><div style=\"line-height: 26px; margin-top: 15px; margin-left: 15px; margin-right: 15px; color: %@; font-size: 16px;\">%@</div>", webViewContentTextColor, readingEntity.strContent]];
	[HTMLContent appendString:[NSString stringWithFormat:@"<!-- 文章责任编辑 --><p style=\"color: %@; font-size: 15px; font-style: oblique; margin-left: 15px;\">%@</p></div></body>", webViewContentTextColor, readingEntity.strContAuthorIntroduce]];
	
	[self.webView loadHTMLString:HTMLContent baseURL:nil];
	self.webView.delegate = self;
	[self.webView.scrollView scrollsToTop];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	ReadingAuthorView *readingAuthorView = nil;
	
	if (webView.scrollView.subviews.count < 4) {// 小于4说明还没有添加文章底部的作者详情 view
		// webView 底部添加一个作者的描述视图
		readingAuthorView = [[ReadingAuthorView alloc] initWithFrame:CGRectZero];
		readingAuthorView.tag = BottomViewTag;
	} else {
		readingAuthorView = (ReadingAuthorView *)[webView.scrollView viewWithTag:BottomViewTag];
	}
	
	[readingAuthorView configureAuthorViewWithReadingEntity:currentContent];
	
	CGSize readingContentSize = webView.scrollView.contentSize;
	readingContentSize.height += CGRectGetHeight(readingAuthorView.frame);
	webView.scrollView.contentSize = readingContentSize;
	
	CGFloat bottomViewHeight = CGRectGetHeight(readingAuthorView.frame);
	CGRect bottomViewFrame = CGRectMake(0, webView.scrollView.contentSize.height - bottomViewHeight, SCREEN_WIDTH, bottomViewHeight);
	readingAuthorView.frame = bottomViewFrame;
	
	if (!readingAuthorView.superview) {
		[webView.scrollView addSubview:readingAuthorView];
	}
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
