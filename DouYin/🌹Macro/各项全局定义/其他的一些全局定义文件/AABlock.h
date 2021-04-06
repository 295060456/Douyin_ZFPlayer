
#pragma mark —— 确定参数Block
/// 没有返回值的Block
typedef void(^NoResultBlock)(void);
typedef void(^MKDataBlock)(id data);
/// 没有返回值的Block——单形参
typedef void(^MKIntegerBlock)(NSInteger data);//整数
typedef void(^MKFloatBlock)(CGFloat data);//浮点数
/// 没有返回值的Block——多形参
typedef void(^TwoDataBlock)(id data,id data2);
typedef void(^ThreeDataBlock)(id data,id data2,id data3);
typedef void(^FourDataBlock)(id data,id data2,id data3,id data4);
typedef void(^FiveDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef void(^SixDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef void(^SevenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef void(^EightDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef void(^NineDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef void(^TenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);
/// 有返回值的Block
typedef id(^noResultBlock)(void);
typedef id(^mkDataBlock)(id data);
/// 有返回值的Block——单形参
typedef void(^MKIntegerBlock)(NSInteger data);//整数
typedef void(^MKFloatBlock)(CGFloat data);//浮点数
/// 有返回值的Block——多形参
typedef id(^twoDataBlock)(id data,id data2);
typedef id(^threeDataBlock)(id data,id data2,id data3);
typedef id(^fourDataBlock)(id data,id data2,id data3,id data4);
typedef id(^fiveDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef id(^sixDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef id(^sevenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef id(^eightDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef id(^nineDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef id(^tenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);
#pragma mark —— 不定参数Block
typedef void(^MMDataBlock)(id firstArg,...);//第一个参数写：有多少个实际参数 用NSNumber表示 @1
typedef id(^mmDataBlock)(id firstArg,...);//第一个参数写：有多少个实际参数 用NSNumber表示 @1

/*

    不定参数Block【 使用示例】
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
    //                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:UIImage.class]) {
                        NSLog(@"");
                    }else if ([arg isKindOfClass:PHAsset.class]){
                        NSLog(@"");
                    }else if ([arg isKindOfClass:NSString.class]){
                        NSLog(@"");
                    }else if ([arg isKindOfClass:NSArray.class]){
                        NSLog(@"");
                    }else{
                        NSLog(@"");
                    }
                }
            }else{
                NSLog(@"");
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];

*/
