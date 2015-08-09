//
//  PersonViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/27/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "PersonViewController.h"
#import "AboutViewController.h"
#import "SettingsViewController.h"

#define rad(degrees) ((degrees) / (180.0 / M_PI))

@interface PersonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *AccountCellID = @"AccountCell";
static NSString *OtherCellID = @"OtherCell";

@implementation PersonViewController

#pragma mark - View Lifecycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	
	if (self) {
		UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_person_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		// 底部导航item
		UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:nil tag:0];
		tabBarItem.image = deselectedImage;
		tabBarItem.selectedImage = selectedImage;
		self.tabBarItem = tabBarItem;
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self setUpNavigationBarShowRightBarButtonItem:NO];
	[self dontShowBackButtonTitle];
	
	[self setUpViews];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionNightFallingNotification" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightModeSwitch:) name:@"DKNightVersionDawnComingNotification" object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;
	// 真蛋疼，这行代码在这个方法的原因是为了解决点击了其他模块之后返回个人界面点击列表项进入下一个界面导航栏的 tintColor 变成白色
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:229 / 255.0];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - Lifecycle

- (void)dealloc {
	self.tableView.delegate = nil;
	self.tableView.dataSource = nil;
	[self.tableView removeFromSuperview];
	self.tableView = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSNotification

- (void)nightModeSwitch:(NSNotification *)notification {
	[self.tableView reloadData];
}

#pragma mark - Pirvate

- (void)setUpViews {
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - CGRectGetHeight(self.tabBarController.tabBar.frame))];
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
	self.tableView.backgroundColor = [UIColor whiteColor];
	self.tableView.nightBackgroundColor = NightBGViewColor;
	self.tableView.separatorColor = TableViewCellSeparatorDawnColor;
	self.tableView.nightSeparatorColor = [UIColor blackColor];
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
		NSString *imageName = Is_Night_Mode ? @"copyright_nt" : @"copyright";
		cell.imageView.image = [UIImage imageNamed:imageName];
	}
	
	cell.textLabel.textColor = DawnTextColor;
	cell.textLabel.nightTextColor = NightTextColor;
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.backgroundColor = [UIColor whiteColor];
	cell.nightBackgroundColor = NightBGViewColor;
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 0) {// 点击进入个人中心
		
	} else if (indexPath.row == 1) {// 点击进入设置
		SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
		[self.navigationController pushViewController:settingsViewController animated:YES];
	} else if (indexPath.row == 2) {// 点击进入关于界面
		AboutViewController *aboutViewController = [[AboutViewController alloc] init];
		[self.navigationController pushViewController:aboutViewController animated:YES];
	}
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
