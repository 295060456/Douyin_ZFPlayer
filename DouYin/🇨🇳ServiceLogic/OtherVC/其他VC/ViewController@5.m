//
//  ViewController@5.m
//  My_BaseProj
//
//  Created by Jobs on 2020/7/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController@5.h"

@interface ViewController_5 ()

@end

@implementation ViewController_5

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
       
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
}


@end
