//
//  RightPullToRefreshView.m
//  MyOne
//
//  Created by HelloWorld on 7/28/15.
//  Copyright (c) 2015 melody. All rights reserved.
//

#import "RightPullToRefreshView.h"
#import <iCarousel/iCarousel.h>

#define LabelOffsetX 20
#define LeftRefreshLabelTextColor [UIColor colorWithRed:90 / 255.0 green:91 / 255.0 blue:92 / 255.0 alpha:1] // #5A5B5C

@interface RightPullToRefreshView () <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) iCarousel *carousel;
@property (strong, nonatomic) UILabel *leftRefreshLabel;

@end

@implementation RightPullToRefreshView {
	// 视图控件的高度
	CGFloat selfHeight;
	// 当前一共有多少个 item
	NSInteger numberOfItems;
	// 保存当 leftRefreshLabel 的 text 为“右拉刷新...”时的宽，在右拉的时候用到
	CGFloat leftRefreshLabelWidth;
	// 标记是否需要刷新，默认为 NO
	BOOL isNeedRefresh;
	// 保存右拉的 x 距离
	CGFloat draggedX;
	// 标记是否能够 scroll back，用在刷新的时候不改变 leftRefreshLabel 的 frame，默认为 YES
	BOOL canScrollBack;
	// 最后一次显示的 item 的下标
	NSInteger lastItemIndex;
}

#pragma mark - View Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setUp];
	}
	
	return self;
}

- (void)dealloc {
	self.carousel.delegate = nil;
	self.carousel.dataSource = nil;
	[self.carousel removeFromSuperview];
	self.carousel = nil;
	[self.leftRefreshLabel removeFromSuperview];
	self.leftRefreshLabel = nil;
}

#pragma mark - Private

- (void)setUp {
	[DKNightVersionManager addClassToSet:self.class];
	self.backgroundColor = [UIColor whiteColor];
	// 设置夜间模式背景色
	self.nightBackgroundColor = NightBGViewColor;
	
	selfHeight = CGRectGetHeight(self.frame);
	isNeedRefresh = NO;
	canScrollBack = YES;
	draggedX = 0;
	lastItemIndex = -1;
	
	[self setUpViews];
}

#pragma mark 初始化视图控件
- (void)setUpViews {
	self.carousel = [[iCarousel alloc] initWithFrame:self.bounds];
	self.carousel.delegate = self;
	self.carousel.dataSource = self;
	self.carousel.type = iCarouselTypeLinear;
	self.carousel.vertical = NO;
	self.carousel.pagingEnabled = YES;
	self.carousel.bounceDistance = 0.7;
	self.carousel.decelerationRate = 0.6;
	[self addSubview:self.carousel];
	
	self.leftRefreshLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	self.leftRefreshLabel.font = [UIFont systemFontOfSize:10.0f];
	self.leftRefreshLabel.textColor = LeftRefreshLabelTextColor;
	self.leftRefreshLabel.nightTextColor = LeftRefreshLabelTextColor;
	self.leftRefreshLabel.textAlignment = NSTextAlignmentRight;
	self.leftRefreshLabel.text = LeftDragToRightForRefreshHintText;
	[self.leftRefreshLabel sizeToFit];
	[self.leftRefreshLabel setNeedsDisplay];
	leftRefreshLabelWidth = CGRectGetWidth(self.leftRefreshLabel.frame);
	CGRect labelFrame = CGRectMake(0 - leftRefreshLabelWidth * 1.5 - LabelOffsetX, (CGRectGetMaxY(self.carousel.frame) - CGRectGetHeight(self.leftRefreshLabel.frame)) / 2.0, leftRefreshLabelWidth * 1.5, CGRectGetHeight(self.leftRefreshLabel.frame));
	self.leftRefreshLabel.frame = labelFrame;
	[self.carousel.contentView addSubview:self.leftRefreshLabel];
}

#pragma mark - Public

- (void)insertItemAtIndex:(NSInteger)index animated:(BOOL)animated {
	numberOfItems++;
	// 在 iCarousel 的最后插入一个新的 item
	[self.carousel insertItemAtIndex:(numberOfItems - 1) animated:YES];
}

- (void)reloadData {
	[self.carousel reloadData];
}

- (void)reloadItemAtIndex:(NSInteger)index animated:(BOOL)animated {
	[self.carousel reloadItemAtIndex:index animated:animated];
}

- (UIView *)itemViewAtIndex:(NSInteger)index {
	return [self.carousel itemViewAtIndex:index];
}

- (void)endRefreshing {
	if (isNeedRefresh) {
		CGRect frame = self.leftRefreshLabel.frame;
		frame.origin.x = 0 - leftRefreshLabelWidth * 1.5 - LabelOffsetX;
		
		[UIView animateWithDuration:DefaultAnimationDuration animations:^{
			self.carousel.contentOffset = CGSizeMake(0, 0);
			self.leftRefreshLabel.frame = frame;
		} completion:^(BOOL finished) {
			isNeedRefresh = NO;
			canScrollBack = YES;
		}];
	}
}

#pragma mark - Getter

- (NSInteger)currentItemIndex {
	return self.carousel.currentItemIndex;
}

- (UIView *)currentItemView {
	return [self.carousel itemViewAtIndex:self.currentItemIndex];
}

- (UIView *)contentView {
	return self.carousel.contentView;
}

#pragma mark - Setter

- (void)setDelegate:(id<RightPullToRefreshViewDelegate>)delegate {
	if (_delegate != delegate) {
		_delegate = delegate;
		
		if (_delegate && _dataSource) {
			[self setNeedsLayout];
		}
	}
}

- (void)setDataSource:(id<RightPullToRefreshViewDataSource>)dataSource {
	if (_dataSource != dataSource) {
		_dataSource = dataSource;
		
		if (_dataSource) {
			[self.carousel reloadData];
		}
	}
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
	numberOfItems = [self.dataSource numberOfItemsInRightPullToRefreshView:self];
//	NSLog(@"numberOfItems = %ld", numberOfItems);
	return numberOfItems;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
	return [self.dataSource rightPullToRefreshView:self viewForItemAtIndex:index reusingView:view];
}

#pragma mark - iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
	return CGRectGetWidth(self.frame);
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
//	NSLog(@"carousel CurrentItemIndexDidChange index = %ld", carousel.currentItemIndex);
	if ([self.delegate respondsToSelector:@selector(rightPullToRefreshViewCurrentItemIndexDidChange:)]) {
		[self.delegate rightPullToRefreshViewCurrentItemIndexDidChange:self];
	}
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel {
//	NSLog(@"carousel DidEndDecelerating index = %ld, numberOfItems = %ld", carousel.currentItemIndex, numberOfItems);
//	if (carousel.currentItemIndex == (numberOfItems - 1)) {
//		// 如果当前显示的是最后一个，则回调添加 item 方法
//		if ([self.delegate respondsToSelector:@selector(rightPullToRefreshViewDidScrollToLastItem:)]) {
//			[self.delegate rightPullToRefreshViewDidScrollToLastItem:self];
//		}
//	}
}

- (void)carouselDidScroll:(iCarousel *)carousel {
	// 当右拉的时候，改变 leftRefreshLabel 的 x，根据右拉的速度一点点显示 leftRefreshLabel
	if (carousel.scrollOffset <= 0) {
		if (canScrollBack) {
			// 计算右拉的距离
			draggedX = fabs(carousel.scrollOffset * carousel.itemWidth);
			//		NSLog(@"draggedX = %lf", draggedX);
			CGRect frame = self.leftRefreshLabel.frame;
			frame.origin.x = draggedX - CGRectGetWidth(self.leftRefreshLabel.frame) - LabelOffsetX;
			self.leftRefreshLabel.frame = frame;
			// 当右拉到一定的距离之后将 leftRefreshLabel 的文字改为“松开刷新数据...”，这里的距离为 leftRefreshLabel 宽度的1.5倍
			if (draggedX >= leftRefreshLabelWidth * 1.5 + LabelOffsetX) {
				// 刷新 leftRefreshLabel
				self.leftRefreshLabel.text = LeftReleaseToRefreshHintText;
				// 将刷新标记改为需要刷新
				isNeedRefresh = YES;
			} else {
				// 刷新 leftRefreshLabel
				self.leftRefreshLabel.text = LeftDragToRightForRefreshHintText;
				// 将刷新标记改为需要刷新
				isNeedRefresh = NO;
			}
		}
	}
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
//	NSLog(@"carousel DidEndDragging decelerate = %@", decelerate ? @"YES" : @"NO");
	// 当当前 item 为第一个的时候，右拉释放，decelerate为 NO，否则为 YES
	if (!decelerate && isNeedRefresh) {// 右拉释放并且需要刷新数据
		// 设置 leftRefreshLabel 的显示文字、X 轴坐标
		self.leftRefreshLabel.text = LeftReleaseIsRefreshingHintText;
		CGRect frame = self.leftRefreshLabel.frame;
		frame.origin.x = leftRefreshLabelWidth - CGRectGetWidth(self.leftRefreshLabel.frame);
		
		// 不改变 leftRefreshLabel 的 frame
		canScrollBack = NO;
		
		[UIView animateWithDuration:DefaultAnimationDuration animations:^{
			// 设置 carousel item 的 X 轴偏移
			carousel.contentOffset = CGSizeMake(CGRectGetMaxX(frame) + LabelOffsetX, 0);
			
			self.leftRefreshLabel.frame = frame;
		}];
		
		if ([self.delegate respondsToSelector:@selector(rightPullToRefreshViewRefreshing:)]) {
			[self.delegate rightPullToRefreshViewRefreshing:self];
		}
	}
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
//	NSLog(@"carousel DidEndScrollingAnimation");
	// 如果当前的 item 为第一个并且 leftRefreshLabel 可以 scroll back，那么就刷新 leftRefreshLabel
	if (carousel.currentItemIndex == 0 && canScrollBack) {
		self.leftRefreshLabel.text = LeftDragToRightForRefreshHintText;
		isNeedRefresh = NO;
	}
	
	if (lastItemIndex != carousel.currentItemIndex) {
		if ([self.delegate respondsToSelector:@selector(rightPullToRefreshView:didDisplayItemAtIndex:)]) {
			[self.delegate rightPullToRefreshView:self didDisplayItemAtIndex:carousel.currentItemIndex];
		}
	}
	
	lastItemIndex = carousel.currentItemIndex;
	
//	if (carousel.currentItemIndex == (numberOfItems - 1)) {
//		// 如果当前显示的是最后一个，则回调添加 item 方法
//		if ([self.delegate respondsToSelector:@selector(rightPullToRefreshViewDidScrollToLastItem:)]) {
//			[self.delegate rightPullToRefreshViewDidScrollToLastItem:self];
//		}
//	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
