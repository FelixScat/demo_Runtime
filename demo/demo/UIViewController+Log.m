//
//  UIViewController+Log.m
//  demo
//
//  Created by FelixPlus on 2019/8/28.
//  Copyright © 2019 Felix. All rights reserved.
//

#import "UIViewController+Log.h"
#import <objc/runtime.h>

@implementation UIViewController (Log)

- (void)setFlag:(NSString *)flag {
    objc_setAssociatedObject(self, @selector(flag), flag, OBJC_ASSOCIATION_COPY);
}

- (NSString *)flag {
    return objc_getAssociatedObject(self, _cmd);
}

static void AGExchangeMethod(Class cls, SEL originSelector, SEL newSelector) {
    
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
    
    //    method_exchangeImplementations(newMethod, originMethod);
    
    BOOL addMethod = class_addMethod(cls, originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    if (addMethod) {
        
        class_replaceMethod(cls, newSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        
    }else {
        
        method_exchangeImplementations(newMethod, originMethod);
    }
}

+ (void)load {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        AGExchangeMethod([self class], @selector(viewDidLoad), @selector(Logging));
    });
}

- (void)Logging{
    
    NSLog(@"%s",__func__);
    
    [self Logging];
}

@end
