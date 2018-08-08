//
//  NSString+LCFCategory.h
//  Pods
//
//  Created by lichengfu on 2017/8/16.
//
//

#import <Foundation/Foundation.h>


#pragma mark - 字符验证
/*!
 *  @category   NSString+LCFVertify
 */
@interface NSString (LCFVertify)

/*!
 *  @method vertifyEmail
 *  验证字符串是否邮箱格式
 */
- (BOOL)vertifyEmail;

/*!
 *  @method vertifyChinese
 *  验证字符串是否中文
 */
- (BOOL)vertifyChinese;

/*!
 *  @method vertifyPassword
 *  验证字符串是否6-18位大小字母混合数字密码
 */
- (BOOL)vertifyPassword;

/*!
 *  @method vertifyHyperLink
 *  验证字符串是否超链接
 */
- (BOOL)vertifyHyperLink;

/*!
 *  @method vertifyTelephone
 *  验证字符串是否固机号码
 */
- (BOOL)vertifyTelephone;

/*!
 *  @method vertifyIpAddress
 *  验证字符串是否IP地址
 */
- (BOOL)vertifyIpAddress;

/*!
 *  @method vertifyMobilePhone
 *  验证字符串是否手机号码
 */
- (BOOL)vertifyMobilePhone;

/*!
 *  @method vertifyCarNumber
 *  验证字符串是否车牌号码
 */
- (BOOL)vertifyCarNumber;

/*!
 *  @method vertifyIdentifierNumber
 *  验证字符串是否身份证号码
 */
- (BOOL)vertifyIdentifierNumber;

/*!
 *  @method vertifyStringWithExp:
 *  验证字符串是否符合正则表达式规则
 */
- (BOOL)vertifyStringWithExp: (NSString *)exp;

@end


#pragma mark - 字符匹配截取
/*!
 *  @category   NSString+LCFMatch
 */
@interface NSString (LCFMatch)

/*!
 *  @method matchNumbersInString:
 *  获取所有数字子串
 */
- (NSArray<NSString *> *)matchNumbersInString: (NSString *)string;

/*!
 *  @method matchNumberRangesInString:
 *  获取所有数字子串的range
 */
- (NSArray<NSString *> *)matchNumberRangesInString: (NSString *)string;

/*!
 *  @method matchHyperLinksInString:
 *  获取所有超链接子串
 */
- (NSArray<NSString *> *)matchHyperLinksInString: (NSString *)string;

/*!
 *  @method matchHyperLinkRangesInString:
 *  获取所有超链接的range
 */
- (NSArray<NSString *> *)matchHyperLinkRangesInString: (NSString *)string;

/*!
 *  @method matchMatchesWithRegexExp:
 *  获取所有匹配正则的子串
 */
- (NSArray<NSString *> *)matchMatchesWithRegexExp: (NSString *)regexExp;

/*!
 *  @method matchMatchRangesWithRegexExp:
 *  获取匹配正则的子串range
 */
- (NSArray<NSString *> *)matchMatchRangesWithRegexExp: (NSString *)regexExp;

@end


#pragma mark - 字符转换
/*!
 *  @category   NSString+LCFConvert
 *  字符转换
 */
@interface NSString (LCFConvert)

/*!
 *  @method MD5String
 *  返回字符摘要
 */
- (NSString *)MD5String;

/*!
 *  @method spellString
 *  返回拼音
 */
- (NSString *)spellString;

/*!
 *  @method absoluteUrl
 *  返回绝对网址
 */
- (NSString * __nullable)absoluteUrl;

@end

@interface NSString (LCFURL)
/*!
 *  @method base64EncodedString
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/*!
 *  @method base64DecodedString
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

/*!
 *  @method URLEncodedString
 *  URLEncode
 */
- (NSString *)URLEncodedString;
/*!
 *  @method URLDecodedString
 *  URLDecode
 */
- (NSString *)URLDecodedString;

@end

#import <UIKit/UIKit.h>

typedef void (^LCF_MakeCallBlock)(BOOL success);

@interface NSString (MakeCall)

/*!
 *  @method 进行拨打系统电话
 *  LCF_makeCall:
 */
- (void)LCF_makeCall:(LCF_MakeCallBlock)block;
@end

@interface NSString (MakeCallByWeb) <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *cacheWebV;

@property (assign, nonatomic) BOOL didBecomeActive;

- (void)LCF_makeCallUseWebView:(LCF_MakeCallBlock)block;

@end

@interface NSString (MakeCallByOpenUrl)

- (void)LCF_makeCallUseOpenUrl:(LCF_MakeCallBlock)callBlock;

@end







