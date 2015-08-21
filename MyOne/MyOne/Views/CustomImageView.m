//
//  CustomImageView.m
//  MyOne
//
//  Created by HelloWorld on 8/3/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "CustomImageView.h"
#import "CircularLoaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CustomImageView ()

@property (nonatomic, strong) CircularLoaderView *progressIndicatorView;

@end

@implementation CustomImageView

- (instancetype)init {
	self = [super init];
	
	if (self) {
		self.progressIndicatorView = [[CircularLoaderView alloc] initWithFrame:CGRectZero];
		[self addSubview:self.progressIndicatorView];
	}
	
	return self;
}

- (void)configureImageViwWithImageURL:(NSURL *)url animated:(BOOL)animated {
//	NSLog(@"%@, animated = %@", NSStringFromSelector(_cmd), animated ? @"YES" : @"NO");
	if (animated) {
		self.progressIndicatorView.frame = self.bounds;
		[self.progressIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		
		[self sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
			self.progressIndicatorView.progress = @(receivedSize).floatValue / @(expectedSize).floatValue;
		} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
			[self.progressIndicatorView reveal];
		}];
	} else {
		self.progressIndicatorView.frame = CGRectZero;
		[self sd_setImageWithURL:url];
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
