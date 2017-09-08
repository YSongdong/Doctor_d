//
//  NSDictionary+Unicode.m
//  TestPlist
//
//  Created by archerzz on 15/7/28.
//  Copyright (c) 2015年 archerzz. All rights reserved.
//

#import "NSDictionary+Unicode.h"
@import ObjectiveC;

@implementation NSDictionary (Unicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(descriptionWithLocale:);
        SEL swizzledSelector = @selector(my_description);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = \
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}


- (NSString*)my_description {
    NSString *desc = [self my_description];
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:gbkEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

@end



@implementation NSArray (Unicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(descriptionWithLocale:);
        SEL swizzledSelector = @selector(my_description);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = \
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}


- (NSString*)my_description {
    NSString *desc = [self my_description];
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:gbkEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}


@end


@implementation NSString (UrlEncode)

//// 将中文编码成url
- (NSString *)urlEncodeString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8));
    return result;
}


@end
