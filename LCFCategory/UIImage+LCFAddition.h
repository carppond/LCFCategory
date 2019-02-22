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
*  Clear the blue color from the image.
*
*  @param  image - The image after black and white processing.
*  @param  redData - Color data,by method'[UIImage redDataOfImage:]'.
@  @return - The image after clear the blue color.
*/
+ (UIImage *)imageClearBlueOfImage:(UIImage *)image
                           redData:(char *)redData;

/*!
 *  Clear the red color from the image.
 *
 *  @param  image - The image after black and white processing.
 *  @param  redData - Color data,by method'[UIImage redDataOfImage:]'.
 @  @return - The image after clear the red color.
 */
+ (UIImage *)imageClearRedOfImage:(UIImage *)image
                          redData:(char *)redData;

/*!
 *  Clear the red and blue color from the image.
 *
 *  @param  image - The image after black and white processing.
 *  @param  redData - Color data,by method'[UIImage redDataOfImage:]'.
 @  @return - The image after clear the color.
 */
+ (UIImage *)imageClearTraceOfImage:(UIImage *)image
                            redData:(char *)redData;

/*!
 *  Clear the red and blue color from the image.
 *
 *  @param  image - The image after black and white processing.
 *  @param  redData - Color data,by method'[UIImage redDataOfImage:]'.
 *  @param  value - Clear red color 'value = 1'; Clear blue color 'value = 2';Clear the red and blue color 'value = 3';
 @  @return - The image after clear the color.
 */
+ (UIImage *)imageClearTraceOfImage:(UIImage *)image
                            redData:(char *)redData
                              value:(unsigned int)value;

/*!
 *  Get the color data.
 *
 *  @param image - Original image.
 *  @return char * - Color data.
 */
+ (char *)redDataOfImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
