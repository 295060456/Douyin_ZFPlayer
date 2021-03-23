//
//  BaseTableViewCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/20.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@end

@implementation BaseTableViewCell

@synthesize idxPath = _idxPath;

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:ReuseIdentifier];
//        [UIView cornerCutToCircleWithView:cell andCornerRadius:6];
    }return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self richElementsInCellWithModel:nil];
        self.selectionStyle = UITableViewCellSelectionStyleNone;// 取消点击效果 【不能在cellWithTableView里面写】
    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 0;
}
/*
    用于以此为基类的BaseTableViewCell的具体子类所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseTableViewCell:(MKDataBlock)baseTableViewCellBlock{
    self.baseTableViewCellBlock = baseTableViewCellBlock;
}
#pragma mark —— 功能方法
/// iOS UITableViewCell 第一行和最后一行圆角设置
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param radius 切角弧度
/// @param dx 内有介绍
/// @param dy 内有介绍
/// @param indexPath indexPath
+(void)tableView:(UITableView *)tableView
makeFirstAndLastCell:(nonnull UITableViewCell *)cell
     roundCorner:(CGFloat)radius
              dx:(CGFloat)dx
              dy:(CGFloat)dy
     atIndexPath:(nonnull NSIndexPath *)indexPath{
    // 圆角角度
    if (radius == 0) {
        radius = 10.f;
    }
    
    if (dx == 0) {
        dx = 15;
    }
    
    // 设置cell 背景色为透明
    cell.backgroundColor = UIColor.clearColor;
    // 创建两个layer
    CAShapeLayer *normalLayer = CAShapeLayer.new;
    CAShapeLayer *selectLayer = CAShapeLayer.new;
    // 获取显示区域大小
#warning CGRectInset会进行平移和缩放两个操作;CGRectOffset做的只是平移
    /**
     
     CGRectInset(CGRect rect, CGFloat dx, CGFloat dy),
     三个参数:
     rect：待操作的CGRect；
     dx：为正数时，向右平移dx，宽度缩小2dx。为负数时，向左平移dx，宽度增大2dx；
     dy：为正数是，向下平移dy，高度缩小2dy。为负数是，向上平移dy，高度增大2dy。
     
     **/
    
    CGRect bounds = CGRectInset(cell.bounds,
                                dx,
                                0);
    // 获取每组行数
    NSInteger rowNum = [tableView numberOfRowsInSection:indexPath.section];
    // 贝塞尔曲线
    UIBezierPath *bezierPath = nil;
    if (rowNum == 1) {
       bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                          byRoundingCorners:UIRectCornerAllCorners
                                                cornerRadii:CGSizeMake(radius, radius)];
    }else{
        if (indexPath.row == 0) {
            // 每组第一行（添加左上和右上的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(radius, radius)];
        }else if (indexPath.row == rowNum - 1){
            // 每组最后一行（添加左下和右下的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(radius, radius)];
        }else{
            // 每组不是首位的行不设置圆角
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
   }
    
    /*
     
     同 ：指定圆切角
    +(void)appointCornerCutToCircleWithTargetView:(UIView *__nonnull)targetView
                                byRoundingCorners:(UIRectCorner)corners
                                      cornerRadii:(CGSize)cornerRadii；
     **/
    
    // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
    normalLayer.path = bezierPath.CGPath;
    selectLayer.path = bezierPath.CGPath;
       
    UIView *nomarBgView = [[UIView alloc] initWithFrame:bounds];
    // 设置填充颜色
    // normalLayer.fillColor = [UIColor colorWithWhite:0.95 alpha:1.0].CGColor;
    normalLayer.fillColor = UIColor.whiteColor.CGColor;
    // 添加图层到nomarBgView中
    [nomarBgView.layer insertSublayer:normalLayer atIndex:0];
    nomarBgView.backgroundColor = UIColor.clearColor;
    // nomarBgView.backgroundColor = UIColor.whiteColor;
    cell.backgroundView = nomarBgView;
    //此时圆角显示就完成了，但是如果没有取消cell的点击效果，还是会出现一个灰色的长方形的形状，再用上面创建的selectLayer给cell添加一个selectedBackgroundView
    UIView *selectBgView = [[UIView alloc] initWithFrame:bounds];
    selectLayer.fillColor = UIColor.whiteColor.CGColor;
    [selectBgView.layer insertSublayer:selectLayer atIndex:0];
    selectBgView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectBgView;
}
#pragma mark —— 协议属性合成set & get方法
-(void)setIdxPath:(NSIndexPath *)idxPath{
    _idxPath = idxPath;
}

-(NSIndexPath *)idxPath{
    return _idxPath;
}

@end
