//
//  UIButton+LCFRepeatClick.h
//  kehou_netstudy
//
//  Created by lcf on 2018/12/18.
//  Copyright © 2018 lichengfu575@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LCFRepeatClick)

/*!
 *  每次点击持续时间，默认1s
 */
@property (nonatomic, assign) NSTimeInterval clickDurationTime;

@end

