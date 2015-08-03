//
//  ThingViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "ThingViewController.h"
#import "RightPullToRefreshView.h"
#import <unistd.h>
#import "ThingEntity.h"
#import <MJExtension/MJExtension.h>
#import "ThingView.h"

@interface ThingViewController () <RightPullToRefreshViewDelegate, RightPullToRefreshViewDataSource>

@property (nonatomic, strong) RightPullToRefreshView *rightPullToRefreshView;

@end

@implementation ThingViewController {
	// 当前一共有多少 item，默认为3个
	NSInteger numberOfItems;
	// 保存当前查看过的数据
	NSMutableArray *readItems;
	// 测试数据
	ThingEntity *thingEntity;
}

#pragma mark - View Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) {
		UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_thing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_thing_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 底部导航item
		UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"东西" image:nil tag:0];
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
	
	numberOfItems = 3;
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
	ThingView *thingView = nil;
	
	//create new view if no view is available for recycling
	if (view == nil) {
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
		thingView = [[ThingView alloc] initWithFrame:view.bounds];
		[view addSubview:thingView];
	} else {
		thingView = (ThingView *)view.subviews[0];
	}
	
	//remember to always set any properties of your carousel item
	//views outside of the `if (view == nil) {...}` check otherwise
	//you'll get weird issues with carousel item content appearing
	//in the wrong place in the carousel
	[thingView configureViewWithThingEntity:thingEntity];
	
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
}

#pragma mark - Private

- (void)whenHUDWasHidden {
	[self.rightPullToRefreshView endRefreshing];
}

- (void)loadTestData {
	// 先不做成可变的
	NSDictionary *testData = [BaseFunction loadTestDatasWithFileName:@"thing_content"];
	thingEntity = [ThingEntity objectWithKeyValues:testData[@"entTg"]];
//	NSLog(@"thingEntity = %@", thingEntity);
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
