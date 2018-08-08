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
/// 最大Y值
-(CGFloat)lcf_MaxY;
/// 最小Y值
-(CGFloat)lcf_MinY;
/// 最新X值
-(CGFloat)lcf_MinX;
/// 最大X值
-(CGFloat)lcf_MaxX;

@end
