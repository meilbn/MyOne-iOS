//
//  QuestionView.m
//  MyOne
//
//  Created by HelloWorld on 8/2/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "QuestionView.h"
#import "PraiseView.h"
#import "QuestionEntity.h"

@interface QuestionView () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) PraiseView *praiseView;

@end

@implementation QuestionView {
	QuestionEntity *currentQuestion;
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

- (void)configureQuestionViewWithQuestionEntity:(QuestionEntity *)questionEntity {
	currentQuestion = questionEntity;
	
	self.dateLabel.text = [BaseFunction getENMarketTimeWithOriginalMarketTime:questionEntity.strQuestionMarketTime];
	
	NSMutableString *HTMLString = [[NSMutableString alloc] init];
	// Questin Title
	[HTMLString appendString:@"<div style=\"margin-bottom: 20px; margin-top: 34px;\"><table style=\"width: 100%;\"><tbody style=\"display: table-row-group; vertical-align: middle; border-color: inherit;\"><tr style=\"display: table-row; vertical-align: inherit;\"><td style=\"width: 84px;\" align=\"center\"><img style=\"width: 42px; height: 42px; vertical-align: middle;\" alt=\"问题\" src=\"http://s2-cdn.wufazhuce.com/m.wufazhuce/images/question.png\" /></td>"];
	[HTMLString appendString:[NSString stringWithFormat:@"<td><p style=\"margin-top: 0; margin-left: 0; color: #5A5B5C; font-size: 16px; font-weight: bold;\">%@</p></td></tr></tbody></table>", questionEntity.strQuestionTitle]];
	// Question Content
	[HTMLString appendString:[NSString stringWithFormat:@"<div style=\"line-height: 26px; margin-top: 14px;\"><p style=\"margin-left: 20px; margin-right: 20px; margin-bottom: 0; text-shadow: none; font-size: 15px;\">%@</p></div>", questionEntity.strQuestionContent]];
	// Separate Line
	[HTMLString appendString:@"<div style=\"margin-top: 15px; margin-bottom: 15px; width: 95%; height: 1px; background-color: #d4d4d4; margin-left: auto; margin-right: auto;\"></div>"];
	// Answer Title
	[HTMLString appendString:[NSString stringWithFormat:@"<table style=\"width: 100%%;\"><tbody style=\"display: table-row-group; vertical-align: middle; border-color: inherit;\"><tr style=\"display: table-row; vertical-align: inherit; border-color: inherit;\"><td style=\"width: 84px;\" align=\"center\"><img style=\"width: 42px; height: 42px; vertical-align: middle;\" alt=\"回答\" src=\"http://s2-cdn.wufazhuce.com/m.wufazhuce/images/answer.png\" /></td><td align=\"left\"><p style=\"margin-top: 0; margin-left: 0; color: #5A5B5C; font-size: 16px; font-weight: bold; margin-right: 20px; margin-bottom: 0; text-shadow: none;\">%@</p></td></tr></tbody></table>", questionEntity.strAnswerTitle]];
	// Answer Content
	[HTMLString appendString:[NSString stringWithFormat:@"<div style=\"line-height: 26px; margin-top: 14px;\"><p></p><p style=\"margin-left: 20px; margin-right: 20px; margin-bottom: 0; text-shadow: none; font-size: 15px;\">%@</p><p></p></div>", questionEntity.strAnswerContent]];
	// Question Editor
	[HTMLString appendString:[NSString stringWithFormat:@"<p style=\"color: #333333; font-style: oblique; margin-left: 20px; margin-right: 20px; margin-bottom: 0; text-shadow: none; font-size: 15px;\">%@</p></div>", questionEntity.sEditor]];
	
	[self.webView loadHTMLString:HTMLString baseURL:nil];
	self.webView.delegate = self;
	[self.webView.scrollView scrollsToTop];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	PraiseView *praiseView = nil;
	
	if (webView.scrollView.subviews.count < 4) {// 小于4说明还没有添加文章底部的作者详情 view
		// webView 底部添加一个作者的描述视图
		praiseView = [[PraiseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 68)];
		praiseView.tag = BottomViewTag;
	} else {
		praiseView = (PraiseView *)[webView.scrollView viewWithTag:BottomViewTag];
	}
	
	[praiseView configureViewWithPraiseNumber:currentQuestion.strPraiseNumber];
	
	CGRect bottomViewFrame = praiseView.frame;
	bottomViewFrame.origin.y = webView.scrollView.contentSize.height - CGRectGetHeight(praiseView.frame) - 62;
	praiseView.frame = bottomViewFrame;
	
	if (!praiseView.superview) {
		[webView.scrollView addSubview:praiseView];
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
