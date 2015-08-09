//
//  QuestionViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "QuestionViewController.h"
#import "RightPullToRefreshView.h"
#import <unistd.h>
#import "QuestionEntity.h"
#import <MJExtension/MJExtension.h>
#import "QuestionView.h"
#import "HTTPTool.h"

@interface QuestionViewController () <RightPullToRefreshViewDelegate, RightPullToRefreshViewDataSource>

@property (nonatomic, strong) RightPullToRefreshView *rightPullToRefreshView;

@end

@implementation QuestionViewController {
	// 当前一共有多少 item，默认为3个
	NSInteger numberOfItems;
	// 保存当前查看过的数据
//	NSMutableArray *readItems;
	NSMutableDictionary *readItems;
	// 测试数据
//	QuestionEntity *questionEntity;
	// 最后更新的日期
	NSString *lastUpdateDate;
	// 最后展示的 item 的下标
//	NSInteger lastConfigureViewForItemIndex;
	// 当前展示的 item 的下标
	NSInteger currentItemIndex;
}

#pragma mark - View Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) {
		UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_question"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_question_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 底部导航item
		UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"问题" image:nil tag:0];
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
	readItems = [[NSMutableDictionary alloc] init];
	lastUpdateDate = [BaseFunction stringDateBeforeTodaySeveralDays:0];
//	lastConfigureViewForItemIndex = -1;
	currentItemIndex = 0;
	
//	[self loadTestData];
	
	self.rightPullToRefreshView = [[RightPullToRefreshView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
	self.rightPullToRefreshView.delegate = self;
	self.rightPullToRefreshView.dataSource = self;
	[self.view addSubview:self.rightPullToRefreshView];
	
	__weak typeof(self) weakSelf = self;
	self.hudWasHidden = ^() {
		[weakSelf whenHUDWasHidden];
	};
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionNightFallingNotification" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionDawnComingNotification" object:nil];
	
	[self requestQuestionContentAtIndex:0];
}

#pragma mark - Lifecycle

- (void)dealloc {
	self.rightPullToRefreshView.delegate = nil;
	self.rightPullToRefreshView.dataSource = nil;
	self.rightPullToRefreshView = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - NSNotification

- (void)nightModeSwitch:(NSNotification *)notification {
	[self.rightPullToRefreshView reloadData];
}

#pragma mark - RightPullToRefreshViewDataSource

- (NSInteger)numberOfItemsInRightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView {
	return numberOfItems;
}

- (UIView *)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	QuestionView *questionView = nil;
	
	//create new view if no view is available for recycling
	if (view == nil) {
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rightPullToRefreshView.frame), CGRectGetHeight(rightPullToRefreshView.frame))];
		questionView = [[QuestionView alloc] initWithFrame:view.bounds];
		
		[view addSubview:questionView];
	} else {
		questionView = (QuestionView *)view.subviews[0];
	}
	
	//remember to always set any properties of your carousel item
	//views outside of the `if (view == nil) {...}` check otherwise
	//you'll get weird issues with carousel item content appearing
	//in the wrong place in the carousel
	if (index == numberOfItems - 1 || index == readItems.count) {// 当前这个 item 是没有展示过的
		NSLog(@"question refresh index = %ld", index);
		[questionView refreshSubviewsForNewItem];
	} else {// 当前这个 item 是展示过了但是没有显示过数据的
		NSLog(@"question configure index = %ld", index);
//		lastConfigureViewForItemIndex = MAX(index, lastConfigureViewForItemIndex);
		[questionView configureViewWithQuestionEntity:readItems[[@(index) stringValue]]];
	}
	
	return view;
}

#pragma mark - RightPullToRefreshViewDelegate

- (void)rightPullToRefreshViewRefreshing:(RightPullToRefreshView *)rightPullToRefreshView {
	[self showHUDWaitingWhileExecuting:@selector(request)];
}

- (void)rightPullToRefreshView:(RightPullToRefreshView *)rightPullToRefreshView didDisplayItemAtIndex:(NSInteger)index {
	currentItemIndex = index;
	NSLog(@"question didDisplayItemAtIndex index = %ld, numberOfItems = %ld", index, numberOfItems);
	if (index == numberOfItems - 1) {// 如果当前显示的是最后一个，则添加一个 item
		NSLog(@"question add new item ----");
		numberOfItems++;
		[self.rightPullToRefreshView insertItemAtIndex:(numberOfItems - 1) animated:YES];
	}
	
	if (index < readItems.count && readItems[[@(index) stringValue]]) {
//		NSLog(@"question lastConfigureViewForItemIndex = %ld index = %ld", lastConfigureViewForItemIndex, index);
		NSLog(@"question didDisplay index = %ld", index);
		QuestionView *questionView = (QuestionView *)[rightPullToRefreshView itemViewAtIndex:index].subviews[0];
		[questionView configureViewWithQuestionEntity:readItems[[@(index) stringValue]]];
	} else {
		[self requestQuestionContentAtIndex:index];
	}
}

#pragma mark - Network Requests

- (void)request {
	sleep(2);
}

- (void)requestQuestionContentAtIndex:(NSInteger)index {
	NSString *date = [BaseFunction stringDateBeforeTodaySeveralDays:index];
	[HTTPTool requestQuestionContentByDate:date lastUpdateDate:lastUpdateDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if ([responseObject[@"result"] isEqualToString:REQUEST_SUCCESS]) {
			NSLog(@"question request index = %ld date = %@ success-------", index, date);
			QuestionEntity *returnQuestionEntity = [QuestionEntity objectWithKeyValues:responseObject[@"questionAdEntity"]];
			if (IsStringEmpty(returnQuestionEntity.strQuestionId)) {
				returnQuestionEntity.strQuestionMarketTime = date;
			}
			[readItems setObject:returnQuestionEntity forKey:[@(index) stringValue]];
			[self.rightPullToRefreshView reloadItemAtIndex:index animated:NO];
		}
	} failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"question error = %@", error);
	}];
}

#pragma mark - Private

- (void)whenHUDWasHidden {
	[self.rightPullToRefreshView endRefreshing];
}

- (void)loadTestData {
	// 先不做成可变的
//	NSDictionary *testData = [BaseFunction loadTestDatasWithFileName:@"question_content"];
//	questionEntity = [QuestionEntity objectWithKeyValues:testData[@"questionAdEntity"]];
//	NSLog(@"questionEntity = %@", questionEntity);
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
