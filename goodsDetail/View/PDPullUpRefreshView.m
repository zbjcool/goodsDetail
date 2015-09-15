//
//  PDPullUpRefreshView.m
//  iWedding
//
//  Created by jack steven on 04/08/15.
//  Copyright (c) 2015年 jack steven. All rights reserved.
//

#import "PDPullUpRefreshView.h"

#define REFRESH_PULL_UP_STATUS @"继续拖动，查看图文详情"
#define REFRESHER_HEIGHT 50.0f

@interface PDPullUpRefreshView ()

@end

@implementation PDPullUpRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.refreshLabel = [[UILabel alloc] init];
        self.refreshLabel.backgroundColor = [UIColor clearColor];
        self.refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
        self.refreshLabel.textAlignment = NSTextAlignmentCenter;
        self.refreshLabel.text = REFRESH_PULL_UP_STATUS;
        self.refreshLabel.hidden = YES;
        self.hasMore = YES;
    }
    return self;
}

- (void)setupWithOwner:(UIScrollView *)owner  delegate:(id)delegate {
    self.owner = owner;
    self.delegate = delegate;
    
    [_owner addSubview:self];
}

- (void)updateOffsetY:(CGFloat)y
{
    CGRect originFrame = self.frame;
    self.frame = CGRectMake(originFrame.origin.x, y, originFrame.size.width, originFrame.size.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!isLoading && scrollView.contentOffset.y < 0) {
        return;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading || !self.hasMore) return;
    isDragging = NO;
    
    // 上拉刷新
    if(scrollView.contentOffset.y > 0 && [self contentOffsetBottom:scrollView] <= -REFRESHER_HEIGHT){
        [self startLoading];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (isLoading || !self.hasMore) return;
    
    if(scrollView.contentOffset.y > 0 && [self contentOffsetBottom:scrollView] <= -REFRESHER_HEIGHT){
        [self startLoading];
    }
}

- (void)startLoading
{
    if (isLoading) {
        return;
    }
    isLoading = YES;

    if ([self.delegate respondsToSelector:@selector(pullUpRefreshDidFinish)]) {
        [self.delegate performSelector:@selector(pullUpRefreshDidFinish) withObject:nil];
    }
}

- (void)stopLoading
{
    isLoading = NO;
    
    // Hide the footer
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    // Reset the footer
//    NSLog(@"%f",self.owner.contentSize.height);
    
    self.refreshLabel.text = REFRESH_PULL_UP_STATUS;
    
//    [self setFrame:CGRectMake(0, self.owner.contentSize.height, self.frame.size.width, 50)];
}


// helper
// ------

- (float)contentOffsetBottom:(UIScrollView *)scrollView
{
    return scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom);
}

@end
