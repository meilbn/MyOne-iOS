//
//  BaseViewController.m
//  MyOne
//
//  Created by HelloWorld on 7/28/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define HUD_DELAY 1.5

@interface BaseViewController () <MBProgressHUDDelegate>

@end

@implementation BaseViewController {
	MBProgressHUD *HUD;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

- (void)setUpNavigationBarShowRightBarButtonItem:(BOOL)show {
	// 显示导航栏上的《一个》图标
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navLogo"]];
	if (show) {
		// 初始化导航栏右侧的分享按钮
		UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
		[shareButton setBackgroundImage:[UIImage imageNamed:@"nav_share_btn_normal"] forState:UIControlStateNormal];
		[shareButton setBackgroundImage:[UIImage imageNamed:@"nav_share_btn_highlighted"] forState:UIControlStateHighlighted];
		
		UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
		
		self.navigationItem.rightBarButtonItem = shareItem;
	}
}

#pragma mark - Touch Events

- (void)share {
	
}

#pragma mark - MBProgressHUD

- (void)showHUDWaitingWhileExecuting:(SEL)method {
	// The hud will dispable all input on the view (use the higest view possible in the view hierarchy)
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
	HUD.color = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:0.9];
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
	
	// Show the HUD while the provided method executes in a new thread
	[HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
}

- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay {
	if (!HUD.isHidden) {
		[HUD hide:NO];
	}
	HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	// Configure for text only and offset down
	HUD.mode = MBProgressHUDModeText;
	HUD.labelText = text;
	HUD.margin = 10.f;
	HUD.removeFromSuperViewOnHide = YES;
	[HUD hide:YES afterDelay:delay];
}

- (void)showHUDDone {
	[self showHUDDoneWithText:@"Done"];
}

- (void)showHUDDoneWithText:(NSString *)text {
	if (!HUD.isHidden) {
		[HUD hide:NO];
	}
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_right"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = text;
	[HUD show:YES];
	[HUD hide:YES afterDelay:HUD_DELAY];
}

- (void)showHUDErrorWithText:(NSString *)text {
	if (!HUD.isHidden) {
		[HUD hide:NO];
	}
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_error"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = text;
	[HUD show:YES];
	[HUD hide:YES afterDelay:HUD_DELAY];
}

- (void)showHUDNetError {
	[self showHUDErrorWithText:BAD_NETWORK];
}

- (void)showHUDServerError {
	[self showHUDErrorWithText:@"Server Error"];
}

- (void)showWithLabelText:(NSString *)showText executing:(SEL)method {
	if (!HUD.isHidden) {
		[HUD hide:NO];
	}
	HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.labelText = showText;
	[HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
}

- (void)showHUDWithText:(NSString *)text {
	[self hideHud];
	HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	// Configure for text only and offset down
	HUD.mode = MBProgressHUDModeIndeterminate;
	HUD.labelText = text;
	HUD.margin = 10.f;
	HUD.removeFromSuperViewOnHide = YES;
}

- (void)processServerErrorWithCode:(NSInteger)code andErrorMsg:(NSString *)msg {
	if (code == 500) {
		[self showHUDServerError];
	} else {
		[self showHUDDoneWithText:msg];
	}
}

- (void)hideHud {
	if (!HUD.isHidden) {
		[HUD hide:NO];
	}
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	if (self.hudWasHidden) {
		self.hudWasHidden();
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
