//
//  UIView+LCFFrame.m
//  Pods
//
//  Created by lichengfu on 2018/4/18.
//  Copyright © 2018年 lichengfu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCFFrame)
/// width
@property(assign ,nonatomic)CGFloat lcf_width;
/// height
@property(assign ,nonatomic)CGFloat lcf_height;
/// x
@property(assign ,nonatomic)CGFloat lcf_x;
/// y
@property(assign ,nonatomic)CGFloat lcf_y;
/// size
@property(assign ,nonatomic)CGSize lcf_size;
/// centerX
@property(assign ,nonatomic)CGFloat lcf_centerX;
/// centerY
@property(assign ,nonatomic)CGFloat lcf_centerY;
/// left
@property (nonatomic, assign) CGFloat lcf_left;
/// right
@property (nonatomic, assign) CGFloat lcf_right;
/// top
@property (nonatomic, assign) CGFloat lcf_top;
/// bottom
@property (nonatomic, assign) CGFloat lcf_bottom;
/// lcf_origin
@property (nonatomic, assign) CGPoint lcf_origin;

/// 最大Y值
-(CGFloat)lcf_MaxY;
/// 最小Y值
-(CGFloat)lcf_MinY;
/// 最新X值
-(CGFloat)lcf_MinX;
/// 最大X值
-(CGFloat)lcf_MaxX;

- (void)heightEqualToView:(UIView *)view;

- (void)widthEqualToView:(UIView *)view;

- (void)setLCF_centerX:(CGFloat)centerX;

- (void)setLCF_centerY:(CGFloat)centerY;

- (void)centerXEqualToView:(UIView *)view;

- (void)centerYEqualToView:(UIView *)view;

- (void)centerEqualToView:(UIView *)view;

- (void)fromTheTop:(CGFloat)distance ofView:(UIView *)view;

- (void)fromTheBottom:(CGFloat)distance ofView:(UIView *)view;

- (void)fromTheLeft:(CGFloat)distance ofView:(UIView *)view;

- (void)fromTheRight:(CGFloat)distance ofView:(UIView *)view;

@end
