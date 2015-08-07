//
//  AboutViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AboutViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	// 设置夜间模式背景色
	self.view.nightBackgroundColor = NightBGViewColor;
	
	[self setTitleView];
	[self setUpViews];
	
	[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.wufazhuce.com/about?from=ONEApp"]]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.webView.frame = self.view.bounds;
}

#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)setTitleView {
	UILabel *titleLabel = [UILabel new];
	titleLabel.text = @"关于";
	titleLabel.textColor = TitleTextColor;
	titleLabel.nightTextColor = TitleTextColor;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17];
	[titleLabel sizeToFit];
	self.navigationItem.titleView = titleLabel;
}

- (void)setUpViews {
	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	self.webView.scalesPageToFit = NO;
	self.webView.multipleTouchEnabled = NO;
	self.webView.exclusiveTouch = NO;
	self.webView.backgroundColor = [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1];;
	self.webView.scrollView.backgroundColor = self.webView.backgroundColor;
	self.webView.scrollView.scrollsToTop = YES;
	[self.view addSubview:self.webView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
