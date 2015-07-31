//
//  HomeViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "HomeViewController.h"
#import "RightPullToRefreshView.h"
#import <unistd.h>
#import "HomeEntity.h"
#import <MJExtension/MJExtension.h>
#import "HomeView.h"

@interface HomeViewController () <RightPullToRefreshViewDelegate, RightPullToRefreshViewDataSource>

@property (nonatomic, strong) RightPullToRefreshView *rightPullToRefreshView;

@end

@implementation HomeViewController {
	// 中间展示的视图控件的高度
	CGFloat refreshHeight;
	// 当前一共有多少篇文章，默认为3篇
	NSInteger numberOfItems;
	// 保存当前查看过的数据
	NSMutableArray *readItems;
	// 测试数据
	HomeEntity *homeEntity;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:55 / 255.0 green:196 / 255.0 blue:242 / 255.0 alpha:1];
	[self setUpNavigationBarShowRightBarButtonItem:YES];
	
	refreshHeight = SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame);
	numberOfItems = 2;
	readItems = [[NSMutableArray alloc] init];
	
	[self loadTestData];
	
	self.rightPullToRefreshView = [[RightPullToRefreshView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, refreshHeight)];
	self.rightPullToRefreshView.delegate = self;
	self.rightPullToRefreshView.dataSource = self;
	[self.view addSubview:self.rightPullToRefreshView];
	
	__weak typeof(self) weakSelf = self;
	self.hudWasHidden = ^() {
		NSLog(@"hudWasHidden");
		[weakSelf whenHUDWasHidden];
	};
	
//	NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//	NSArray *fontNames;
//	NSInteger indFamily, indFont;
//	NSLog(@"[familyNames count] === %ld", [familyNames count]);
//	for (indFamily = 0; indFamily < [familyNames count]; ++indFamily) {
//		NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//		fontNames = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
//		for (indFont = 0; indFont < [fontNames count]; ++indFont) {
//			NSLog(@"Font name: %@", [fontNames objectAtIndex:indFont]);
//		}
//	}
	
	
//	UIDevice *device = [UIDevice currentDevice];
//	NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
//	NSString *deviceID = [BaseFunction md5Digest:currentDeviceId];
//	// @"761784e559875c76cc95222cc8c8135a17bb61e1079fb654100ce81f4ef8e6ef"
//	NSString *myid = @"761784e559875c76cc95222cc8c8135a17bb61e1079fb654100ce81f4ef8e6ef";
//	NSLog(@"myid.length = %ld", myid.length);
//	NSLog(@"deviceID = %@, deviceID.length = %ld", deviceID, deviceID.length);
}

#pragma mark - Lifecycle

- (void)dealloc {
	self.rightPullToRefreshView.delegate = nil;
	self.rightPullToRefreshView = nil;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - RightPullToRefreshViewDataSource

- (NSInteger)numberOfItemsInRightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView {
	NSLog(@"Person numberOfItemsInRightPullToRefreshView");
	return numberOfItems;
}

- (UIView *)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
//	UIWebView *webView = nil;
	
	//create new view if no view is available for recycling
	if (view == nil) {
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
		
		HomeView *homeView = [[HomeView alloc] initWithFrame:view.bounds];
		[homeView configureViewWithHomeEntity:homeEntity];
		[view addSubview:homeView];
		
//		webView = [[UIWebView alloc] initWithFrame:view.bounds];
//		webView.scrollView.showsVerticalScrollIndicator = YES;
//		webView.scrollView.showsHorizontalScrollIndicator = NO;
//		webView.scalesPageToFit = NO;
//		webView.tag = 1;
//		[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
//		[view addSubview:webView];
	} else {
//		webView = (UIWebView *)[view viewWithTag:1];
	}
	
	//remember to always set any properties of your carousel item
	//views outside of the `if (view == nil) {...}` check otherwise
	//you'll get weird issues with carousel item content appearing
	//in the wrong place in the carousel
	
	return view;
}

#pragma mark - RightPullToRefreshViewDelegate

- (void)rightPullToRefreshViewRefreshing:(RightPullToRefreshView *)rightPullToRefreshView {
	[self showHUDWaitingWhileExecuting:@selector(request)];
}

- (void)rightPullToRefreshViewDidScrollToLastItem:(RightPullToRefreshView *)rightPullToRefreshView {
	numberOfItems++;
	[self.rightPullToRefreshView insertItemAtIndex:(numberOfItems - 1) animated:YES];
}

#pragma mark - Network Requests

- (void)request {
	sleep(2);
//	[readItems addObject:homeEntity];
}

#pragma mark - Private

- (void)whenHUDWasHidden {
	[self.rightPullToRefreshView endRefreshing];
}

- (void)loadTestData {
	// 先不做成可变的
	NSDictionary *testData = [BaseFunction loadTestDatasWithFileName:@"home_content"];
	homeEntity = [HomeEntity objectWithKeyValues:testData[@"hpEntity"]];
	NSLog(@"homeEntity = %@", homeEntity);
}

#pragma mark - Parent

- (void)share {
	[super share];
	NSLog(@"share --------");
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
