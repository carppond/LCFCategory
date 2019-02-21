//
//  UIView+LCFFrame.m
//  Pods
//
//  Created by lichengfu on 2018/4/18.
//  Copyright © 2018年 lichengfu575@gmail.com. All rights reserved.
//

#import "UIView+LCFFrame.h"

@implementation UIView (LCFFrame)

-(void)setLcf_x:(CGFloat)lcf_x{
    CGRect rect = self.frame;
    rect.origin.x = round(lcf_x);
    self.frame = rect;
}
-(CGFloat)lcf_x{
    return self.frame.origin.x;
}
-(void)setLcf_y:(CGFloat)lcf_y{
    CGRect rect = self.frame;
    rect.origin.y = round(lcf_y);
    self.frame = rect;
}
-(CGFloat)lcf_y{
    return self.frame.origin.y;
}
-(void)setLcf_width:(CGFloat)lcf_width{
    CGRect rect = self.frame;
    rect.size.width = round(lcf_width);
    self.frame = rect;
}
- (CGPoint)lcf_origin
{
    return self.frame.origin;
}

- (void)setLcf_origin:(CGPoint)lcf_origin
{
    CGRect rect = self.frame;
    rect.origin = lcf_origin;
    self.frame = rect;
}

-(CGFloat)lcf_width{
    return self.frame.size.width;
}
-(void)setLcf_height:(CGFloat)lcf_height{
    CGRect rect = self.frame;
    rect.size.height = round(lcf_height);
    self.frame = rect;
}
-(CGFloat)lcf_height{
    return self.frame.size.height;
}
-(void)setLcf_size:(CGSize)lcf_size{
    CGRect rect = self.frame;
    rect.size = CGSizeMake(round(lcf_size.width), round(lcf_size.height));
    self.frame = rect;
}
-(CGSize)lcf_size{
    return self.frame.size;
}
-(void)setLcf_centerX:(CGFloat)lcf_centerX{
    CGPoint center = self.center;
    center.x = lcf_centerX;
    self.center = center;
}
-(CGFloat)lcf_centerX{
    return self.center.x;
}
-(void)setLcf_centerY:(CGFloat)lcf_centerY{
    CGPoint center = self.center;
    center.y = lcf_centerY;
    self.center = center;
}
-(CGFloat)lcf_centerY{
    return self.center.y;
}

- (void)setLcf_left:(CGFloat)lcf_left
{
    CGRect rect = self.frame;
    rect.origin.x = round(lcf_left);
    self.frame = rect;
}

- (CGFloat)lcf_left
{
    return self.frame.origin.x;
}

- (void)setLcf_right:(CGFloat)lcf_right
{
    CGRect rect = self.frame;
    rect.origin.x = round(lcf_right - rect.size.width);
    self.frame = rect;
}

- (CGFloat)lcf_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setLcf_top:(CGFloat)lcf_top
{
    CGRect rect = self.frame;
    rect.origin.y = round(lcf_top);
    self.frame = rect;
}

- (CGFloat)lcf_top
{
    return self.frame.origin.y;
}

- (void)setLcf_bottom:(CGFloat)lcf_bottom
{
    CGRect rect = self.frame;
    rect.origin.y = round(lcf_bottom - rect.size.height);
    self.frame = rect;
}

- (CGFloat)lcf_bottom
{
    return CGRectGetMaxY(self.frame);
}


-(CGFloat)lcf_MaxY{
    
    return CGRectGetMaxY(self.frame);
}
-(CGFloat)lcf_MinY{
    
    return CGRectGetMinY(self.frame);
}
-(CGFloat)lcf_MinX{
    
    return CGRectGetMinX(self.frame);
}
-(CGFloat)lcf_MaxX{
    
    return CGRectGetMaxX(self.frame);
}

- (void)heightEqualToView:(UIView *)view {
    
    self.lcf_height = view.lcf_height;
}

- (void)widthEqualToView:(UIView *)view {
    
    self.lcf_width = view.lcf_width;
}

- (void)setLCF_centerX:(CGFloat)centerX
{
    CGPoint center = CGPointMake(self.lcf_centerX, self.lcf_centerY);
    center.x = centerX;
    self.center = center;
}

- (void)setLCF_centerY:(CGFloat)centerY
{
    CGPoint center = CGPointMake(self.lcf_centerX, self.lcf_centerY);
    center.y = centerY;
    self.center = center;
}

- (void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.lcf_centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.lcf_centerY = centerPoint.y;
}

- (void)centerEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.topSuperView];
    CGPoint centerPoint = [self.topSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.lcf_centerX = centerPoint.x;
    self.lcf_centerY = centerPoint.y;
}

- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.lcf_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.lcf_y = newOrigin.y - distance - self.lcf_height;
}

- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.lcf_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.lcf_y = floorf(newOrigin.y + distance + view.lcf_height);
}

- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.lcf_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.lcf_x = newOrigin.x - distance - self.lcf_width;
}

- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.lcf_origin toView:self.topSuperView];
    CGPoint newOrigin = [self.topSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.lcf_x = newOrigin.x + distance + view.lcf_width;
}

- (UIView *)topSuperView
{
    UIView *topSuperView = self.superview;
    
    if (topSuperView == nil) {
        topSuperView = self;
    } else {
        while (topSuperView.superview) {
            topSuperView = topSuperView.superview;
        }
    }
    
    return topSuperView;
}


@end






















