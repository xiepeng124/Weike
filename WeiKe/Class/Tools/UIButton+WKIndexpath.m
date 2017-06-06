//
//  UIButton+WKIndexpath.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/31.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "UIButton+WKIndexpath.h"
#import <objc/runtime.h>
@implementation UIButton (WKIndexpath)
static  NSIndexPath *_indexpath;

- (void)setIndexpath:(NSIndexPath *)indexpath{
    // void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
    objc_setAssociatedObject(self, &_indexpath, indexpath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)indexpath {
    // id objc_getAssociatedObject(id object, const void *key)
    return objc_getAssociatedObject(self, &_indexpath);
}

@end
