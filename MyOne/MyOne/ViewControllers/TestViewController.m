//
//  TestViewController.m
//  MyOne
//
//  Created by HelloWorld on 8/5/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "TestViewController.h"
#import <TFHpple.h>

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor whiteColor];
	
//	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.wufazhuce.com/question/2015-08-05"]];
//	TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
//	
//	NSArray *questionDetail = [doc searchWithXPathQuery:@"//table"];
//	NSLog(@"questionDetail = %@", questionDetail);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
