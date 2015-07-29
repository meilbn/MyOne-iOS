//
//  PersonViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "PersonViewController.h"

#define rad(degrees) ((degrees) / (180.0 / M_PI))

@interface PersonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *AccountCellID = @"AccountCell";
static NSString *OtherCellID = @"OtherCell";

@implementation PersonViewController{
	// 中间展示的视图控件的高度
	CGFloat tableViewHeight;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setUpNavigationBarShowRightBarButtonItem:NO];
	
	tableViewHeight = SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame);
	
	[self setUpViews];
}

#pragma mark - Lifecycle

- (void)dealloc {
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
	[self.tableView removeFromSuperview];
	self.tableView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pirvate

- (void)setUpViews {
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tableViewHeight)];
	// 不显示空 cell
	self.tableView.tableFooterView = [[UIView alloc] init];
	// 设置 cell 的行高，固定为69
	self.tableView.rowHeight = 69;
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	// 设置 tableView 的 分割线
	self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AccountCellID];
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:OtherCellID];
	[self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 如果是第一行，则使用 AccountCellID，否则使用 OtherCellID
	NSString *cellID = indexPath.row == 0 ? AccountCellID : OtherCellID;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

	if (indexPath.row == 0) {
		cell.textLabel.text = @"我的眼里只有代码";
		cell.imageView.image = [UIImage imageNamed:@"person_icon"];
	} else if (indexPath.row == 1) {
		cell.textLabel.text = @"设置";
		cell.imageView.image = [UIImage imageNamed:@"setting"];
	} else if (indexPath.row == 2) {
		cell.textLabel.text = @"关于";
		cell.imageView.image = [UIImage imageNamed:@"copyright"];
	}
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
