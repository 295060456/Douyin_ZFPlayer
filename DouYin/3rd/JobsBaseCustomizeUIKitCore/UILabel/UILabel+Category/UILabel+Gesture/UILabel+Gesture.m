//
//  UILabel+Gesture.m
//  SelectorBlock
//
//  Created by Jobs on 2021/4/3.
//

#import "UILabel+Gesture.h"

@implementation UILabel (Gesture)

-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"给UILabel的子类加手势");
    
//    {// B
//        self.userInteractionEnabled = YES;
//        self.target = self;
//        self.numberOfTouchesRequired = 1;
//        self.minimumPressDuration = 1;
//        self.longPressGR.enabled = YES;
//    }
    
    
    
    {
        self.userInteractionEnabled = YES;
        self.target = self;
        self.numberOfTouchesRequired = 1;
        self.minimumPressDuration = 1;
        
        
        self.longPressGR.enabled = YES;
        {
            self.tapGR.enabled = YES;
            self.numberOfTapsRequired = 1;
        }
        
        @weakify(self)
        self.callbackBlock = ^(id weakSelf,
                               id arg,
                               UIGestureRecognizer *data3) {
            @strongify(self)
            if ([data3 isKindOfClass:UITapGestureRecognizer.class]) {
                NSLog(@"UILabel 的 Tap 手势");
                [self clickLink];
            }else if ([data3 isKindOfClass:UILongPressGestureRecognizer.class]){
                NSLog(@"UILabel 的 长按 手势");
            }else{}
        };
    };
}
// 点击文本处理链接跳转
-(void)clickLink{
    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:nil];
    //通过检测字符串最后几位是否是.com .cn...来进行判定
    NSArray *checkArr = [detector matchesInString:self.text
                                          options:0
                                            range:NSMakeRange(0, self.text.length)];
    //判断有没有链接
    if(checkArr.count > 0) {
        if (checkArr.count > 1) { //网址多于1个时让用户选择跳哪个链接
            [WHToast toastMsg:@"多于1个链接"];
        }else {//一个链接直接打开
            [WHToast toastMsg:@"只有1个链接"];
        }
    }else{
        [WHToast toastMsg:@"没有链接"];
    }
}


@end


