//
//  NSDictionary+LCFNilSafe.m
//  sSegment
//
//  Created by lichengfu on 2018/8/8.
//  Copyright © 2018年 lichengfu. All rights reserved.
//

#import "NSDictionary+LCFNilSafe.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (BOOL)lcf_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)lcf_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) lcf_swizzleMethod:origSel withMethod:altSel];
}

@end

@implementation NSDictionary (LCFNilSafe)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lcf_swizzleMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(lcf_initWithObjects:forKeys:count:)];
        [self lcf_swizzleClassMethod:@selector(dictionaryWithObjects:forKeys:count:) withMethod:@selector(lcf_dictionaryWithObjects:forKeys:count:)];
    });
}

+ (instancetype)lcf_dictionaryWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self lcf_dictionaryWithObjects:safeObjects forKeys:safeKeys count:j];
}

- (instancetype)lcf_initWithObjects:(const id [])objects forKeys:(const id<NSCopying> [])keys count:(NSUInteger)cnt {
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger j = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        id key = keys[i];
        id obj = objects[i];
        if (!key || !obj) {
            continue;
        }
        if (!obj) {
            obj = [NSNull null];
        }
        safeKeys[j] = key;
        safeObjects[j] = obj;
        j++;
    }
    return [self lcf_initWithObjects:safeObjects forKeys:safeKeys count:j];
}

@end

@implementation NSMutableDictionary (LCFNilSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"__NSDictionaryM");
        [class lcf_swizzleMethod:@selector(setObject:forKey:) withMethod:@selector(lcf_setObject:forKey:)];
        [class lcf_swizzleMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(lcf_setObject:forKeyedSubscript:)];
    });
}

- (void)lcf_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!aKey || !anObject) {
        return;
    }
    [self lcf_setObject:anObject forKey:aKey];
}

- (void)lcf_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!key || !obj) {
        return;
    }
    [self lcf_setObject:obj forKeyedSubscript:key];
}

@end

