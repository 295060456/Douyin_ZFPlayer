//
//  GKPhotoBrowser+SaveBtn.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/7.
//

#import "GKPhotoBrowser+SaveBtn.h"

@implementation GKPhotoBrowser (SaveBtn)

-(void)makeCustomSaveBtn{
    UIButton *customSaveBtn = UIButton.new;
    [customSaveBtn setImage:KIMG(@"下载")
                   forState:UIControlStateNormal];
    @weakify(self)
    [[customSaveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [NSObject savePic:self];
    }];
    [self.view addSubview:customSaveBtn];
    [customSaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(self.view).offset(-30);
        make.centerX.equalTo(self.view);
    }];
}

@end
