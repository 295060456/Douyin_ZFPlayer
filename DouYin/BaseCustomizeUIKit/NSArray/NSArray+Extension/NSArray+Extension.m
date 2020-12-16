//
//  NSArray+Extension.m
//  Clipyeu ++
//
//  Created by Josee on 22/03/2019.
//  Copyright © 2019 Josee. All rights reserved.
//

#import "NSArray+Extension.h"
#import <objc/runtime.h>

@implementation NSArray (Extension)

+ (void)load{
    [super load];
    // 替换不可变数组中的方法 objectAtIndex
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    // 替换不可变数组中的方法 []调用的方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndexedSubscript:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
    
    // 替换可变数组中的方法 objectAtIndex
    Method oldMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndex:));
    method_exchangeImplementations(oldMObjectAtIndex, newMObjectAtIndex);
    // 替换可变数组中的方法  []调用的方法
    Method oldMMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method newMMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndexedSubscript:));
    method_exchangeImplementations(oldMMutableObjectAtIndex, newMMutableObjectAtIndex);
}

- (id)newObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组越界了");
            return nil;
        } @finally {
            
        }
    }else return [self newObjectAtIndex:index];
}

- (id)newObjectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组越界了");
            return nil;
        } @finally {
        }
    }else return [self newObjectAtIndexedSubscript:index];
}

- (id)newMutableObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newMutableObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"可变数组越界了");
            return nil;
        } @finally {
            
        }
    } else return [self newMutableObjectAtIndex:index];
}

- (id)newMutableObjectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newMutableObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"可变数组越界了");
            return nil;
        } @finally {
        }
    }else return [self newMutableObjectAtIndexedSubscript:index];
}

@end
