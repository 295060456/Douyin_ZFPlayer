
#import "ZYTextField.h"

@interface ZYTextField ()

@property(nonatomic,assign)BOOL isOk;

@end

@implementation ZYTextField

-(instancetype)init{
    if (self = [super init]) {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self modifyClearButtonWithImage:KBuddleIMG(@"⚽️PicResource",@"ZYTextField", nil, @"closeCircle")];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.isOk) {
        [self setUpUI];
    }
}

- (void)setUpUI{
    //字体大小
    self.font = self.ZYtextFont;
    //字体颜色
    self.textColor = self.ZYtextColor;
    //光标颜色
    self.tintColor = self.ZYtintColor;
    //占位符的颜色和大小
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable(UITextField.class,
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.ZYplaceholderLabelTextColor_1;
    placeholderLabel.font = self.ZYplaceholderLabelFont_1;
    // 不成为第一响应者
    [self resignFirstResponder];
    self.isOk = YES;
}
/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable(UITextField.class,
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.ZYplaceholderLabelTextColor_2;
    placeholderLabel.font = self.ZYplaceholderLabelFont_2;
    return [super becomeFirstResponder];
}
/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self,
                                               class_getInstanceVariable(UITextField.class,
                                                                         "_placeholderLabel"));
    placeholderLabel.textColor = self.ZYplaceholderLabelTextColor_1;
    placeholderLabel.font = self.ZYplaceholderLabelFont_1;
    return [super resignFirstResponder];
}
#pragma mark —— 重写父类方法
-(void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes: @{NSFontAttributeName : self.font}];
    [self.placeholder drawInRect:CGRectMake(0,
                                            (rect.size.height - placeholderSize.height) / 2,
                                            rect.size.width,
                                            rect.size.height)
                  withAttributes:@{NSForegroundColorAttributeName : self.ZYplaceholderLabelTextColor_1,
                                   NSFontAttributeName : self.font}];
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += self.leftViewOffsetX;
    return iconRect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super rightViewRectForBounds:bounds];
    iconRect.origin.x -= self.rightViewOffsetX;
    return iconRect;
}
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + self.offset,
                              bounds.origin.y,
                              bounds.size.width - self.offset,
                              bounds.size.height);
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + self.offset,
                              bounds.origin.y,
                              bounds.size.width - self.offset,
                              bounds.size.height);
    return inset;
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + self.offset,
                              bounds.origin.y,
                              bounds.size.width - self.offset,
                              bounds.size.height);
    return inset;
}
//必须在self有具体frame的时候才管用
-(void)setZYTextFieldMasksToBounds:(BOOL)ZYTextFieldMasksToBounds{
    _ZYTextFieldMasksToBounds = ZYTextFieldMasksToBounds;
    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        NSLog(@"self.frame 为空，绘制失败");
    }else{
        if (_ZYTextFieldMasksToBounds) {
            self.layer.cornerRadius = self.ZYTextFieldCornerRadius;
            self.layer.borderColor = self.ZYTextFieldBorderColor.CGColor;
            self.layer.borderWidth = self.ZYTextFieldBorderWidth;
            self.layer.masksToBounds = ZYTextFieldMasksToBounds;//必须写在最后，否则绘制无效
        }
    }
}
#pragma mark —— lazyLoad
-(UIFont *)ZYtextFont{
    if (!_ZYtextFont) {
        _ZYtextFont = [UIFont systemFontOfSize:17
                                        weight:UIFontWeightRegular];
    }return _ZYtextFont;
}

-(UIColor *)ZYtextColor{
    if (!_ZYtextColor) {
        _ZYtextColor = RGBCOLOR(77,
                                150,
                                132);
    }return _ZYtextColor;
}

-(UIColor *)ZYtintColor{
    if (!_ZYtintColor) {
        _ZYtintColor = self.textColor;
    }return _ZYtintColor;
}

-(UIColor *)ZYplaceholderLabelTextColor_1{
    if (!_ZYplaceholderLabelTextColor_1) {
        _ZYplaceholderLabelTextColor_1 = self.textColor;
    }return _ZYplaceholderLabelTextColor_1;
}

-(UIColor *)ZYplaceholderLabelTextColor_2{
    if (!_ZYplaceholderLabelTextColor_2) {
        _ZYplaceholderLabelTextColor_2 = self.textColor;
    }return _ZYplaceholderLabelTextColor_2;
}

-(UIFont *)ZYplaceholderLabelFont_1{
    if (!_ZYplaceholderLabelFont_1) {
        _ZYplaceholderLabelFont_1 = self.font;
    }return _ZYplaceholderLabelFont_1;
}

-(UIFont *)ZYplaceholderLabelFont_2{
    if (!_ZYplaceholderLabelFont_2) {
        _ZYplaceholderLabelFont_2 = self.font;
    }return _ZYplaceholderLabelFont_2;
}

-(CGFloat)offset{
    if (_offset == 0) {
        _offset = 30;
    }return _offset;
}

-(CGFloat)leftViewOffsetX{
    if (_leftViewOffsetX == 0) {
        _leftViewOffsetX = 5;
    }return _leftViewOffsetX;
}

-(CGFloat)rightViewOffsetX{
    if (_rightViewOffsetX == 0) {
        _rightViewOffsetX = 5;
    }return _rightViewOffsetX;
}

-(CGFloat)ZYTextFieldBorderWidth{
    if (_ZYTextFieldBorderWidth == 0) {
        _ZYTextFieldBorderWidth = 1;
    }return _ZYTextFieldBorderWidth;
}

-(UIColor *)ZYTextFieldBorderColor{
    if (!_ZYTextFieldBorderColor) {
        _ZYTextFieldBorderColor = kBlackColor;
    }return _ZYTextFieldBorderColor;
}

@end
