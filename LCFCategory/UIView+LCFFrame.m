//
//  UIView+LCFFrame.m
//  Pods
//
//  Created by lichengfu on 2018/4/18.
//  Copyright © 2018年 lichengfu. All rights reserved.
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


@end






















