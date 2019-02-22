//
//  UIImage+LCFAddition.m
//  kehou_netstudy
//
//  Created by lcf on 2019/2/21.
//  Copyright © 2019 lichengfu575@gmail.com. All rights reserved.
//

#import "UIImage+LCFAddition.h"

@implementation UIImage (LCFAddition)

+ (UIImage *)imageClearTraceOfImage:(UIImage *)image
                            redData:(char *)redData
                              value:(unsigned int)value {
    
    CGImageRef imageRef = [image CGImage];
    size_t imageWidth = CGImageGetWidth(imageRef);
    size_t imageHeight = CGImageGetHeight(imageRef);
    
    char *rgbImageBuf = (char *)calloc(4 * imageWidth * imageHeight, 1);
    size_t bytesPerRow = 4 * imageWidth;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, 16385);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, image.size.width, image.size.height), imageRef);
    
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

+ (char *)redDataOfImage:(UIImage *)image {
    
    CGImageRef imageRef = [image CGImage];
    int64_t imageWidth = CGImageGetWidth(imageRef);
    int64_t imageHeight = CGImageGetHeight(imageRef);
    char * rgbImageBuf= (char *)calloc(4 * imageWidth * imageHeight, 1);
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    size_t bytesPerRow = 4 * imageWidth;
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, spaceRef, 16385);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), imageRef);
    Byte *beginByte = (Byte *)calloc(imageWidth * imageHeight, 1);
    bzero(beginByte, imageWidth * imageHeight);
    
    if (imageHeight) {
        int64_t mark = 0;
        SInt64 newRgbImageBuf = (SInt64)(rgbImageBuf + 2);
        Byte *newBeginByte = beginByte;
        do {
            
            uint8_t *tmpRgbImgBuf = (uint8_t *)newRgbImageBuf;
            Byte *tmpBeginByte = newBeginByte;
            for (int64_t i = imageWidth; i; --i) {
                uint bImgBuf = *(tmpRgbImgBuf - 2);
                uint gImgBuf = *(tmpRgbImgBuf - 1);
                uint rImgBuf = *tmpRgbImgBuf;
                uint tmpImgBuf;
                if (gImgBuf <= rImgBuf) {
                    tmpImgBuf = *tmpRgbImgBuf;
                }
                else {
                    tmpImgBuf = *(tmpRgbImgBuf - 1);
                }
                uint tmpImgBuf1 ;
                if (tmpImgBuf <= bImgBuf) {
                    tmpImgBuf1 = *(tmpRgbImgBuf - 2);
                }
                else {
                    tmpImgBuf1 = tmpImgBuf;
                }
                
                if (tmpImgBuf1 > 0x77) {
                    if (gImgBuf > 0xD1 ||
                        ((gImgBuf + 15 >= bImgBuf || (bImgBuf >= 0x64 ? (tmpImgBuf >= bImgBuf) : (1))) &&
                         (gImgBuf + 30 >= bImgBuf || bImgBuf > 0x63 || tmpImgBuf > bImgBuf))) {
                            if (tmpImgBuf > 0x95) {
                                if(rImgBuf > 0xf0) {
                                    *tmpBeginByte = 2;
                                }
                                if (bImgBuf < gImgBuf) {
                                    bImgBuf = *(tmpRgbImgBuf -1);
                                }
                                
                                if ((signed int)bImgBuf < (signed int)rImgBuf) {
                                    *tmpBeginByte = 2;
                                }
                            }
                            unsigned int tmpBuf;
                            if (gImgBuf >= rImgBuf) {
                                tmpBuf = *tmpRgbImgBuf;
                            }
                            else {
                                tmpBuf = *(tmpRgbImgBuf - 1);
                            }
                            if (tmpBuf >= bImgBuf) {
                                tmpBuf = *(tmpRgbImgBuf - 2);
                            }
                            if ((signed int)(tmpImgBuf - tmpBuf) >= 20) {
                                if(rImgBuf > 0xf0) {
                                    *tmpBeginByte = 2;
                                }
                                if (bImgBuf < gImgBuf) {
                                    bImgBuf = *(tmpRgbImgBuf -1);
                                }
                                
                                if ((signed int)bImgBuf < (signed int)rImgBuf) {
                                    *tmpBeginByte = 2;
                                }
                            }
                        }
                    else {
                        *tmpBeginByte = 1;
                    }
                }
                uint tmpGImgBuf;
                if (gImgBuf >= rImgBuf) {
                    tmpGImgBuf = *tmpRgbImgBuf;
                }
                else {
                    tmpGImgBuf = *(tmpRgbImgBuf - 1);
                }
                if (tmpGImgBuf >= bImgBuf) {
                    tmpGImgBuf = *(tmpRgbImgBuf - 2);
                }
                if ((signed int)(tmpImgBuf1 - tmpGImgBuf) >= 20) {
                    if (gImgBuf > 0xD1 ||
                        ((gImgBuf + 15 >= bImgBuf || (bImgBuf >= 0x64 ? (tmpImgBuf >= bImgBuf) : (1))) &&
                         (gImgBuf + 30 >= bImgBuf || bImgBuf > 0x63 || tmpImgBuf > bImgBuf))) {
                            if (tmpImgBuf > 0x95) {
                                if(rImgBuf > 0xf0) {
                                    *tmpBeginByte = 2;
                                }
                                if (bImgBuf < gImgBuf) {
                                    bImgBuf = *(tmpRgbImgBuf -1);
                                }
                                
                                if ((signed int)bImgBuf < (signed int)rImgBuf) {
                                    *tmpBeginByte = 2;
                                }
                            }
                            unsigned int tmpBuf;
                            if (gImgBuf >= rImgBuf) {
                                tmpBuf = *tmpRgbImgBuf;
                            }
                            else {
                                tmpBuf = *(tmpRgbImgBuf - 1);
                            }
                            if (tmpBuf >= bImgBuf) {
                                tmpBuf = *(tmpRgbImgBuf - 2);
                            }
                            if ((signed int)(tmpImgBuf - tmpBuf) >= 20) {
                                if(rImgBuf > 0xf0) {
                                    *tmpBeginByte = 2;
                                }
                                if (bImgBuf < gImgBuf) {
                                    bImgBuf = *(tmpRgbImgBuf -1);
                                }
                                
                                if ((signed int)bImgBuf < (signed int)rImgBuf) {
                                    *tmpBeginByte = 2;
                                }
                            }
                        }
                    else {
                        *tmpBeginByte = 1;
                    }
                }
                ++tmpBeginByte;
                tmpRgbImgBuf += 4;
            }
            ++mark;
            newBeginByte += imageWidth;
            newRgbImageBuf += 4 * imageWidth;
        }
        while(mark != imageHeight);
    }
    
    CGColorSpaceRelease(spaceRef);
    CGContextRelease(contextRef);
    if (rgbImageBuf) {
        free(rgbImageBuf);
    }
    char *red = (char *)beginByte;
    return red;
}
@end
