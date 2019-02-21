//
//  UIButton+LCFRepeatClick.m
//  kehou_netstudy
//
//  Created by lcf on 2018/12/18.
//  Copyright © 2018 lichengfu575@gmail.com. All rights reserved.
//

#import "UIButton+LCFRepeatClick.h"
#import <objc/runtime.h>

static NSTimeInterval defaultDurationTime = 0.5f;
static BOOL _isIgnoreEvent = NO;
static char * const clickDurationTimeKey = "clickDurationTimeKey";

static void restartIgnoreEvent () {
    _isIgnoreEvent = NO;
}

@implementation UIButton (LCFRepeatClick)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method fromMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        Method toMethod = class_getInstanceMethod([self class], @selector(LCF_sendAction:to:forEvent:));
        
        BOOL didAddMethod = class_addMethod([self class], @selector(sendAction:to:forEvent:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod));
        
        if (didAddMethod) {
            class_replaceMethod([self class], @selector(LCF_sendAction:to:forEvent:), method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
        }else{
            method_exchangeImplementations(fromMethod, toMethod);
        }
    });
}

- (void)LCF_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {
    
    if ([self isKindOfClass:[UIButton class]]) {
        self.clickDurationTime = self.clickDurationTime == 0 ? defaultDurationTime : self.clickDurationTime;
        if (_isIgnoreEvent) {
            return;
        }
        else if (self.clickDurationTime > 0) {
            _isIgnoreEvent = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                restartIgnoreEvent();
            });
            [self LCF_sendAction:action to:target forEvent:event];
        }
        else {
            [self LCF_sendAction:action to:target forEvent:event];
        }
    }
    else {
        [self LCF_sendAction:action to:target forEvent:event];
    }
}

- (void)setClickDurationTime:(NSTimeInterval)clickDurationTime {
    objc_setAssociatedObject(self, clickDurationTimeKey, @(clickDurationTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)clickDurationTime {
    return [objc_getAssociatedObject(self, clickDurationTimeKey) doubleValue];
}

@end
