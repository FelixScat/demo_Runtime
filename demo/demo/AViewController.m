//
//  AViewController.m
//  demo
//
//  Created by FelixPlus on 2019/8/28.
//  Copyright © 2019 Felix. All rights reserved.
//

#import "AViewController.h"
#import "UIViewController+Log.h"
#import <objc/runtime.h>

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flag = @"active";
    
    [self performSelector:@selector(speak)];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(speak)) {
        
//        return [XXXX new];
    }
    
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(speak)) {
        
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation setSelector:@selector(otherMethod)];
    [anInvocation invokeWithTarget:self];
}

- (void)otherMethod{
    NSLog(@"%s",__func__);
}

@end
