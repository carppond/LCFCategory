//
//  UIImage+LCFAddition.h
//  kehou_netstudy
//
//  Created by lcf on 2019/2/21.
//  Copyright © 2019 lichengfu575@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LCFAddition)

/*!
 *  去除红色或者蓝色.
 *
 *  @param image 灰度(黑白,二值化)处理之后的图片.
 *  @param redData 传''.
 *  @param value 去除红色传值1, 去除蓝色传值2,同时去除红色和蓝色传值3.
 */
- (UIImage *)imageClearTraceOfImage:(UIImage *)image redData:(char *)redData value:(unsigned int)value;

@end

NS_ASSUME_NONNULL_END
