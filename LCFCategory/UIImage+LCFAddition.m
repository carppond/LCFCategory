//
//  UIImage+LCFAddition.m
//  kehou_netstudy
//
//  Created by lcf on 2019/2/21.
//  Copyright © 2019 lichengfu575@gmail.com. All rights reserved.
//

#import "UIImage+LCFAddition.h"

@implementation UIImage (LCFAddition)

- (UIImage *)imageClearTraceOfImage:(UIImage *)image redData:(char *)redData value:(unsigned int)value {
    CGImageRef imageRef = [image CGImage];
    size_t imageWidth = CGImageGetWidth(imageRef);
    size_t imageHeight = CGImageGetHeight(imageRef);
    
    char *rgbImageBuf = (char *)calloc(4 * imageWidth * imageHeight, 1);
    size_t bytesPerRow = 4 * imageWidth;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, 16385);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    
    char *tmpArg2 = redData;
    if (imageHeight) {
        size_t mark = 0;
        SInt64 rgbImageBuff = (SInt64)(rgbImageBuf + 1);
        do {
            SInt64 tmpPtr = rgbImageBuff;
            char *tmpRedData = redData;
            
            for (size_t i = imageWidth; i; --i) {
                if ((uint8_t)*tmpRedData & value) {
                    //                    *(Byte *)(ptr + 1) = -1;
                    //                    *(Byte *)(ptr - 1) = -1;
                    
                    *(Byte *)(tmpPtr + 1) = 255;
                    *(Byte *)(tmpPtr - 1) = 255;
                    *(Byte *)(tmpPtr) = 255;
                    
                }
                ++tmpRedData;
                tmpPtr += 4;
            }
            ++mark;
            redData += imageWidth;
            rgbImageBuff += 4 * imageWidth;
        } while (mark != imageHeight);
    }
    
    CGImageRef imgRef = CGBitmapContextCreateImage(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    UIImage *newImg = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    if (rgbImageBuf) {
        free(rgbImageBuf);
    }
    return newImg;
}
@end
