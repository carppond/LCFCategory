//
//  NSString+LCFCategory.m
//  Pods
//
//  Created by lichengfu on 2017/8/16.
//
//

#import "NSString+LCFCategory.h"
#import <CommonCrypto/CommonCrypto.h>
#import <objc/runtime.h>


#pragma mark - 字符验证
@implementation NSString (LCFVertify)


- (BOOL)vertifyEmail {
    return [self vertifyStringWithExp: @"^(\\S+@\\S+\\.[a-zA-Z]{2,4})$"];
}

- (BOOL)vertifyChinese {
    return [self vertifyStringWithExp: @"^([\u4e00-\u9fa5]+)$"];
}

- (BOOL)vertifyPassword {
    NSString * lengthMatch = @"^(.{6,18})$";
    NSString * numberMatch = @"^(.*\\d+.*)$";
    NSString * lowerMatch = @"^(.*[a-z]+.*)$";
    NSString * upperMatch = @"^(.*[A-Z]+.*)$";
    return [self vertifyStringWithExp: lengthMatch] &&
        [self vertifyStringWithExp: numberMatch] &&
        [self vertifyStringWithExp: lowerMatch] &&
        [self vertifyStringWithExp: upperMatch];
}

- (BOOL)vertifyCarNumber {
    return [self vertifyStringWithExp: @"^([\u4e00-\u9fa5]{1}[a-zA-Z]{1}\\w{4}[a-zA-Z0-9[\u4e00-\u9fa5]]{1})$"];
}

- (BOOL)vertifyHyperLink {
    return [self vertifyStringWithExp: @"^((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)$"];
}

- (BOOL)vertifyIpAddress {
    return [self vertifyStringWithExp: @"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(0\\.0\\.0\\.0)$"];
}

- (BOOL)vertifyTelephone {
    return [self vertifyStringWithExp: @"^(0\\d{2}-?\\d{8})|(\\d{8})|(0\\d{3}-?\\d{8})|(400-\\d{3}-\\d{4})$"];
}

- (BOOL)vertifyMobilePhone {
    return [self vertifyStringWithExp: @"^1\\d{10}$"];
}

- (BOOL)vertifyIdentifierNumber {
    /// http://blog.csdn.net/wei549434510/article/details/50596207
    return [self vertifyStringWithExp: @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"];
}

- (BOOL)vertifyStringWithExp: (NSString *)exp {
    if (![exp isKindOfClass: [NSString class]]) { return NO; }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", exp];
    return [predicate evaluateWithObject:self];
}


@end



#pragma mark - 字符匹配截取
@implementation NSString (LCFMatch)


- (NSArray<NSString *> *)matchNumbersInString: (NSString *)string {
    return [self matchMatchesWithRegexExp: @"^(\\d+(\\.\\d+)?)$"];
}

- (NSArray<NSString *> *)matchNumberRangesInString: (NSString *)string {
    return [self matchMatchRangesWithRegexExp: @"^(\\d+(\\.\\d+)?)$"];
}

- (NSArray<NSString *> *)matchHyperLinksInString: (NSString *)string {
    return [self matchMatchesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

- (NSArray<NSString *> *)matchHyperLinkRangesInString: (NSString *)string {
    return [self matchMatchRangesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

- (NSArray<NSString *> *)matchMatchesWithRegexExp: (NSString *)regexExp {
    if (![regexExp isKindOfClass: [NSString class]]) { return @[]; }
    
    NSArray<NSString *> *ranges = [self matchMatchRangesWithRegexExp: regexExp];
    NSMutableArray * matches = @[].mutableCopy;
    for (NSString * range in ranges) {
        [matches addObject: [self substringWithRange: NSRangeFromString(range)]];
    }
    return [NSArray arrayWithArray: matches];
}

- (NSArray<NSString *> *)matchMatchRangesWithRegexExp: (NSString *)regexExp {
    if (![regexExp isKindOfClass: [NSString class]]) { return @[]; }
    
    NSRegularExpression * matcher = [NSRegularExpression regularExpressionWithPattern: regexExp options: NSRegularExpressionAnchorsMatchLines error: nil];
    NSArray<NSTextCheckingResult *> * result = [matcher matchesInString: self options: NSMatchingReportProgress range: NSMakeRange(0, self.length)];
    NSMutableArray * ranges = @[].mutableCopy;
    [result enumerateObjectsUsingBlock: ^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ranges addObject: NSStringFromRange(obj.range)];
    }];
    return [NSArray arrayWithArray: ranges];
}

@end

@implementation NSString (LCFConvert)

- (NSString *)MD5String {
    if (self.length == 0) { return self; }
    const char * cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString * result = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat: @"%02x", digest[i]];
    }
    return [result copy];
}

- (NSString *)spellString {
    if ([self vertifyStringWithExp: @"^.*[\u4e00-\u9fa5]+.*$"]) {
        NSMutableString * spell = [self mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformStripCombiningMarks, NO);
        return [spell copy];
    }
    return self;
}

- (NSString *)absoluteUrl {
    if ([self vertifyHyperLink]) {
        if ([self hasPrefix: @"http://"] || [self hasPrefix: @"https://"]) {
            return self;
        }
        return [NSString stringWithFormat: @"http://%@", self];
    }
    return nil;
}

@end

@implementation NSString (LCFURL)
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
/**
 *  URLEncode
 */
- (NSString *)URLEncodedString
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *unencodedString = self;
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end

typedef void (^AlertCallBack)(UIAlertView *alertView, NSInteger buttonIndex);
@interface UIAlertView (LCF) <UIAlertViewDelegate>

/**
 *  点击回调
 */
@property (nonatomic, copy) AlertCallBack alertCallBack;
/**
 *  显示提示框
 *
 *  @param callback 点击回调
 */
- (void)LCF_ShowWithCallBack:(AlertCallBack)callback;
@end

@interface NSString ()

@property (copy, nonatomic) LCF_MakeCallBlock makeCallBlock;
@end

@implementation NSString (MakeCall)
- (LCF_MakeCallBlock)makeCallBlock
{
    return objc_getAssociatedObject(self, @selector(makeCallBlock));
}
- (void)setMakeCallBlock:(LCF_MakeCallBlock)makeCallBlock
{
    objc_setAssociatedObject(self, @selector(makeCallBlock), makeCallBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)LCF_makeCall:(LCF_MakeCallBlock)block
{
    if (![self hasPrefix:@"tel:"])
    {
        [[NSString stringWithFormat:@"tel:%@", self] LCF_makeCall:block];
    }
    else
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.2)
            {
                //在10.2以下是不会弹出提示框的
                UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:[self stringByReplacingOccurrencesOfString:@"tel:" withString:@""] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
                [alertV LCF_ShowWithCallBack:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    if (buttonIndex == 0)
                    {
                        if (block)
                        {
                            block(NO);
                        }
                    }
                    else if (buttonIndex == 1)
                    {
                        [self LCF_makeCallUseOpenUrl:block];
                    }
                }];
            }
            else
            {
                //10.2以上会弹出提示框，所以10.2以上不需要弹出框
                [self LCF_makeCallUseOpenUrl:block];
            }
        }
        else
        {
            [self LCF_makeCallUseWebView:block];
        }
    }
}
@end

@implementation NSString (MakeCallByOpenUrl)

- (void)LCF_makeCallUseOpenUrl:(LCF_MakeCallBlock)callBlock
{
    self.makeCallBlock = callBlock;
    NSURL *phoneUrl = [NSURL URLWithString:self];
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)])
    {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:phoneUrl
                                               options:@{}
                                     completionHandler:^(BOOL success) {
                                         if (self.makeCallBlock)
                                         {
                                             self.makeCallBlock(success);
                                         }
                                     }];
        } else {
            // Fallback on earlier versions
        }
    }
    else
    {
        
        BOOL result = [[UIApplication sharedApplication] openURL:phoneUrl];
        if (self.makeCallBlock)
        {
            self.makeCallBlock(result);
        }
    }
}

@end

@implementation NSString (MakeCallByWeb)

- (BOOL)didBecomeActive
{
    return [objc_getAssociatedObject(self, @selector(didBecomeActive)) boolValue];
}
- (void)setDidBecomeActive:(BOOL)didBecomeActive
{
    objc_setAssociatedObject(self, @selector(didBecomeActive), [NSNumber numberWithBool:didBecomeActive], OBJC_ASSOCIATION_ASSIGN);
}
- (UIWebView *)cacheWebV
{
    return objc_getAssociatedObject(self, @selector(cacheWebV));
}
- (void)setCacheWebV:(UIWebView *)cacheWebV
{
    objc_setAssociatedObject(self, @selector(cacheWebV), cacheWebV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)LCF_makeCallUseWebView:(LCF_MakeCallBlock)block
{
    self.makeCallBlock = block;
    self.cacheWebV = [[UIWebView alloc] init];
    self.cacheWebV.delegate = self;
    NSURLRequest *phoneRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [self.cacheWebV loadRequest:phoneRequest];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL result = NO;
    if ([request.URL.absoluteString hasPrefix:@"tel:"])
    {
        //电话呼叫
        result = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //8秒后还没有开始通话，假设为点击取消按钮了，所以为失败
            if (self.makeCallBlock)
            {
                self.makeCallBlock(NO);
            }
        });
    }
    //添加一个计时器
    return result;
}
- (void)applicationWillResignActive
{
    if (self.didBecomeActive)
    {
        if (self.makeCallBlock)
        {
            //移除通知以及webView，执行回调
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
            
            self.makeCallBlock(YES);
            
            self.cacheWebV = nil;
            self.makeCallBlock = nil;
            self.didBecomeActive = NO;
        }
    }
}
- (void)applicationDidBecomeActive
{
    //调用该方法后，再调用applicationWillResignActive就是开始通话了，所以这里记录调用了该方法
    self.didBecomeActive = YES;
}

@end

@implementation UIAlertView (LCF)
/**
 *  显示提示框
 *
 *  @param callback 点击回调
 */
- (void)LCF_ShowWithCallBack:(AlertCallBack)callback
{
    self.alertCallBack = callback;
    self.delegate = self;
    [self show];
}
- (AlertCallBack)alertCallBack
{
    return objc_getAssociatedObject(self, @selector(alertCallBack));
}
- (void)setAlertCallBack:(AlertCallBack)alertCallBack
{
    objc_setAssociatedObject(self, @selector(alertCallBack), alertCallBack, OBJC_ASSOCIATION_COPY);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.alertCallBack) {
        __weak typeof(self) weakSelf = self;
        self.alertCallBack(weakSelf,buttonIndex);
    }
}

@end








