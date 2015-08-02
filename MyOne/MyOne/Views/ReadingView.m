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
	self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
	self.webView.scrollView.showsVerticalScrollIndicator = YES;
	self.webView.scrollView.showsHorizontalScrollIndicator = NO;
	self.webView.scalesPageToFit = NO;
	self.webView.tag = WebViewTag;
	self.webView.backgroundColor = WebViewBGColor;
	self.webView.scrollView.backgroundColor = self.webView.backgroundColor;
	self.webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
	self.webView.multipleTouchEnabled = NO;
	self.webView.scrollView.scrollsToTop = YES;
	
	// webView 顶部添加一个 UIView，高度为34，UIView 里面再添加一个 UILabel，x 为15，y 为12，高度为16，左右距离为15，水平垂直居中，系统默认字体，颜色#555555，大小为13。
	UIView *webViewTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 34)];
	webViewTopView.tag = TopViewTag;
	self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(webViewTopView.frame) - 30, 16)];
	self.dateLabel.tag = TopViewTimeLabelTag;
	self.dateLabel.font = systemFont(13.0);
	self.dateLabel.textColor = DateTextColor;
	[webViewTopView addSubview:self.dateLabel];
	self.dateLabel.center = webViewTopView.center;
	[self.webView.scrollView addSubview:webViewTopView];
	
	[self addSubview:self.webView];
}

- (void)configureReadingViewWithReadingEntity:(ReadingEntity *)readingEntity {
	currentContent = readingEntity;
	
	self.dateLabel.text = [BaseFunction getENMarketTimeWithOriginalMarketTime:readingEntity.strContMarketTime];
	
	NSMutableString *HTMLString = [[NSMutableString alloc] initWithString:readingEntity.strContent];
	NSString *insertString = [NSString stringWithFormat:@"<div style=\"margin-bottom: 10px;\"><p style=\"color: #5A5A5A; font-size: 21px; font-weight: bold; margin-top: 34px; margin-left: 5px;\">%@</p><p style=\"color: #888888; font-size: 14px; font-weight: bold; margin-left: 5px; margin-top: -15px;\">%@</p><p></p><div style=\"line-height: 26px; margin-top: 14px; margin-left: 5px; margin-right: 5px; color: #333333; font-size: 16px;\">", readingEntity.strContTitle, readingEntity.strContAuthor];
	[HTMLString insertString:insertString atIndex:0];
	NSString *appendString = [NSString stringWithFormat:@"</div><p style=\"color: #333333; font-size: 15px; font-style: oblique; margin-left: 5px;\">%@</p></div>", readingEntity.strContAuthorIntroduce];
	[HTMLString appendString:appendString];
	
	[self.webView loadHTMLString:HTMLString baseURL:nil];
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
