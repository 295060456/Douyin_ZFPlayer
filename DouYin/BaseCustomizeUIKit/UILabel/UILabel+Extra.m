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
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}

@end
