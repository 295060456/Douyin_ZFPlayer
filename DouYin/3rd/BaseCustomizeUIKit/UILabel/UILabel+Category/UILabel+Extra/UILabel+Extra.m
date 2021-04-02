//
//  UILabel+Extra.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/4.
//

#import "UILabel+Extra.h"

@implementation UILabel (Extra)
///iOS根据字体字号大小和字体label计算label宽度
+(CGSize)sizeWithText:(NSString *)text
                 font:(UIFont *)font
              maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};// 因为attributes，此处还可以拓展
    return [text boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}
// Size自适应【注意：外界不要把Size的宽高写死】
-(void)fontDecideSize{
    [self sizeToFit];
}
// 字体自适应
-(void)sizeDecideFont{
    self.adjustsFontSizeToFitWidth = YES;
}

@end
