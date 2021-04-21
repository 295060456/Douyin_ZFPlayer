//
//  UIViewController+BRPickerView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BRPickerView.h"
#import <objc/runtime.h>

@implementation UIViewController (BRPickerView)

static char *BaseVC_BRStringPickerView_stringPickerView = "BaseVC_BRStringPickerView_stringPickerView";
static char *BaseVC_BRStringPickerView_brStringPickerMode = "BaseVC_BRStringPickerView_brStringPickerMode";
static char *BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr = "BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr";
static char *BaseVC_BRStringPickerView_brStringPickerViewBlock = "BaseVC_BRStringPickerView_brStringPickerViewBlock";
static char *BaseVC_BRStringPickerView_datePickerView = "BaseVC_BRStringPickerView_datePickerView";
static char *BaseVC_BRStringPickerView_customStyle = "BaseVC_BRStringPickerView_customStyle";
static char *BaseVC_BRStringPickerView_addressPickerView = "BaseVC_BRStringPickerView_addressPickerView";

@dynamic stringPickerView;
@dynamic brStringPickerMode;
@dynamic BRStringPickerViewDataMutArr;
@dynamic brStringPickerViewBlock;
@dynamic datePickerView;//时间选择器
@dynamic customStyle;
@dynamic addressPickerView;//地址选择器

-(void)BRStringPickerViewBlock:(MKDataBlock)block{
    self.brStringPickerViewBlock = block;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)BRStringPickerView *stringPickerView;
-(BRStringPickerView *)stringPickerView{
    BRStringPickerView *StringPickerView = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_stringPickerView);
    if (!StringPickerView) {
        StringPickerView = [[BRStringPickerView alloc] initWithPickerMode:self.brStringPickerMode];
        if (self.BRStringPickerViewDataMutArr.count > 2) {
            StringPickerView.title = self.BRStringPickerViewDataMutArr[0];
            NSMutableArray *temp = NSMutableArray.array;
            temp = self.BRStringPickerViewDataMutArr.copy;
            [temp removeObjectAtIndex:0];
            StringPickerView.dataSourceArr = temp;
        }
        @weakify(self)
        StringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
//            NSLog(@"选择的值：%@", resultModel.selectValue);
            @strongify(self)
            if (self.brStringPickerViewBlock) {
                self.brStringPickerViewBlock(resultModel);
            }
        };
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_stringPickerView,
                                 StringPickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return StringPickerView;
}

-(void)setStringPickerView:(BRStringPickerView *)stringPickerView{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_stringPickerView,
                             stringPickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BRStringPickerMode brStringPickerMode;
-(BRStringPickerMode)brStringPickerMode{
    return [objc_getAssociatedObject(self, BaseVC_BRStringPickerView_brStringPickerMode) integerValue];
}

-(void)setBrStringPickerMode:(BRStringPickerMode)brStringPickerMode{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_brStringPickerMode,
                             [NSNumber numberWithInteger:brStringPickerMode],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock brStringPickerViewBlock;
-(MKDataBlock)brStringPickerViewBlock{
    return objc_getAssociatedObject(self, BaseVC_BRStringPickerView_brStringPickerViewBlock);
}

-(void)setBrStringPickerViewBlock:(MKDataBlock)brStringPickerViewBlock{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_brStringPickerViewBlock,
                             brStringPickerViewBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSArray *BRStringPickerViewDataMutArr;
-(NSArray *)BRStringPickerViewDataMutArr{
    NSArray *brStringPickerViewDataMutArr = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr);
    if (!brStringPickerViewDataMutArr) {
        brStringPickerViewDataMutArr = NSArray.array;
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr,
                                 brStringPickerViewDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return brStringPickerViewDataMutArr;
}

-(void)setBRStringPickerViewDataMutArr:(NSArray *)BRStringPickerViewDataMutArr{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_BRStringPickerViewDataMutArr,
                             BRStringPickerViewDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)BRDatePickerView *datePickerView;//时间选择器
-(BRDatePickerView *)datePickerView{
    BRDatePickerView *DatePickerView = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_datePickerView);
    if (!DatePickerView) {
        DatePickerView = BRDatePickerView.new;
        DatePickerView.pickerMode = BRDatePickerModeYMD;
        DatePickerView.title = @"选择年月日";
        // datePickerView.selectValue = @"2019-10-30";
        DatePickerView.selectDate = [NSDate br_setYear:2019
                                                  month:10
                                                    day:30];
        DatePickerView.minDate = [NSDate br_setYear:1949
                                               month:3
                                                 day:12];
        DatePickerView.maxDate = [NSDate date];
        DatePickerView.isAutoSelect = YES;
        DatePickerView.pickerStyle = self.customStyle;
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_datePickerView,
                                 DatePickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return DatePickerView;
}

-(void)setDatePickerView:(BRDatePickerView *)datePickerView{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_datePickerView,
                             datePickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)BRPickerStyle *customStyle;
-(BRPickerStyle *)customStyle{
    BRPickerStyle *pickerStyle = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_customStyle);
    if (!pickerStyle) {
        pickerStyle = BRPickerStyle.new;
        pickerStyle.pickerColor = BR_RGB_HEX(0xd9dbdf, 1.0f);
        pickerStyle.pickerTextColor = kRedColor;
        pickerStyle.separatorColor = kRedColor;
        pickerStyle.cancelBtnTitle = @"取消";
        pickerStyle.doneBtnTitle = @"确定";
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_customStyle,
                                 pickerStyle,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return pickerStyle;
}

-(void)setCustomStyle:(BRPickerStyle *)customStyle{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_customStyle,
                             customStyle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)BRAddressPickerView *addressPickerView;//地址选择器
-(BRAddressPickerView *)addressPickerView{
    BRAddressPickerView *AddressPickerView = objc_getAssociatedObject(self, BaseVC_BRStringPickerView_addressPickerView);
    if (!AddressPickerView) {
        AddressPickerView = BRAddressPickerView.new;
        AddressPickerView.pickerMode = BRAddressPickerModeArea;
        AddressPickerView.title = @"请选择地区";
        //AddressPickerView.selectValues = @[@"浙江省", @"杭州市", @"西湖区"];
        AddressPickerView.selectIndexs = @[@10, @0, @4];
        AddressPickerView.isAutoSelect = YES;
        // 设置自定义样式
        AddressPickerView.pickerStyle = self.customStyle;
        objc_setAssociatedObject(self,
                                 BaseVC_BRStringPickerView_addressPickerView,
                                 AddressPickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return AddressPickerView;
}

-(void)setAddressPickerView:(BRAddressPickerView *)addressPickerView{
    objc_setAssociatedObject(self,
                             BaseVC_BRStringPickerView_addressPickerView,
                             addressPickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
