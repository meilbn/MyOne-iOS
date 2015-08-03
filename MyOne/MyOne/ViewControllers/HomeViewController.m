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
#import "HTTPTool.h"

@interface HomeViewController () <RightPullToRefreshViewDelegate, RightPullToRefreshViewDataSource>

@property (nonatomic, strong) RightPullToRefreshView *rightPullToRefreshView;

@end

@implementation HomeViewController {
	// 当前一共有多少篇文章，默认为3篇
	NSInteger numberOfItems;
	// 保存当前查看过的数据
	NSMutableArray *readItems;
	// 测试数据
	HomeEntity *homeEntity;
}

#pragma mark - View Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) {
		UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 底部导航item
		UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:0];
		tabBarItem.image = deselectedImage;
		tabBarItem.selectedImage = selectedImage;
		self.tabBarItem = tabBarItem;
	}
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self setUpNavigationBarShowRightBarButtonItem:YES];
	
	numberOfItems = 2;
	readItems = [[NSMutableArray alloc] init];
	
	[self loadTestData];
	
	self.rightPullToRefreshView = [[RightPullToRefreshView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
	self.rightPullToRefreshView.delegate = self;
	self.rightPullToRefreshView.dataSource = self;
	[self.view addSubview:self.rightPullToRefreshView];
	
	__weak typeof(self) weakSelf = self;
	self.hudWasHidden = ^() {
//		NSLog(@"hudWasHidden");
		[weakSelf whenHUDWasHidden];
	};
	
//	[HTTPTool requestHomeContentByDate:@"2015-08-03" success:^(AFHTTPRequestOperation *operation, id responseObject) {
//		NSLog(@"responseObject = %@", responseObject);
//	} failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//		NSLog(@"error = %@", error);
//	}];
	
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
	self.rightPullToRefreshView.dataSource = nil;
	self.rightPullToRefreshView = nil;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - RightPullToRefreshViewDataSource

- (NSInteger)numberOfItemsInRightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView {
//	NSLog(@"Person numberOfItemsInRightPullToRefreshView");
	return numberOfItems;
}

- (UIView *)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	HomeView *homeView = nil;
	
	//create new view if no view is available for recycling
	if (view == nil) {
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
		homeView = [[HomeView alloc] initWithFrame:view.bounds];
		[view addSubview:homeView];
	} else {
		homeView = (HomeView *)view.subviews[0];
	}
	
	//remember to always set any properties of your carousel item
	//views outside of the `if (view == nil) {...}` check otherwise
	//you'll get weird issues with carousel item content appearing
	//in the wrong place in the carousel
	[homeView configureViewWithHomeEntity:homeEntity];
	
	NSLog(@"date = %@", [BaseFunction stringDateBeforeTodaySeveralDays:index]);
	
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
//	NSLog(@"homeEntity = %@", homeEntity);
}

#pragma mark - Parent

- (void)share {
	[super share];
//	NSLog(@"share --------");
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
