//
//  LZBTabBarItem.m
//  My_BaseProj
//
//  Created by Jobs on 2020/8/9.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LZBTabBarItem.h"

@interface LZBTabBarItem()<UIGestureRecognizerDelegate>

@property(nonatomic,copy)TwoDataBlock LZBTabBarItemGestureRecognizerBlock;

@end

@implementation LZBTabBarItem

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupInit];
        //添加手势
        self.tagGR.enabled = YES;
        self.longPressGR.enabled = YES;
//        self.backgroundColor = kWhiteColor;
    }return self;
}

- (void)setupInit{
    self.backgroundColor = [UIColor clearColor];
    //初始化参数
    _title = @"";
    _titleOffest = UIOffsetZero;
    _unselectTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName: kWhiteColor,};

    _selectTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0xf78361"],};
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGSize frameSize = self.frame.size;
    CGSize imageSize = CGSizeZero;
    CGSize titleSize = CGSizeZero;
    NSDictionary *titleAttributes = nil;
    UIImage *backgroundImage = nil;
    UIImage *image = nil;
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    {
        //判断是否选中
        if(self.isSelected){
            image = self.selectImage;
            backgroundImage = self.selectBackgroundImage;
            titleAttributes = self.selectTitleAttributes;
        }else{
            image = self.unSelectImage;
            backgroundImage = self.unselectBackgroundImage;
            titleAttributes = self.unselectTitleAttributes;
        }
        imageSize = (image== nil) ? CGSizeZero : image.size;
    }

    {
        if(backgroundImage) [backgroundImage drawInRect:self.bounds];
        if(self.title.length == 0){//只有图片
            [image drawInRect:CGRectMake((frameSize.width - imageSize.width) * 0.5 + self.imageOffest.horizontal,
                                         (frameSize.height - imageSize.height) * 0.5 + self.imageOffest.vertical,
                                         imageSize.width,
                                         imageSize.height)];
        }else{//图文
            titleSize = [self.title sizeWithAttributes:titleAttributes];
            CGFloat imageTopMaigin = (frameSize.height - imageSize.height - titleSize.height) * 0.5;
            [image drawInRect:CGRectMake((frameSize.width - imageSize.width) * 0.5 + self.imageOffest.horizontal,
                                         imageTopMaigin,
                                         imageSize.width,
                                         imageSize.height)];
            //必须先设置颜色
            CGContextSetFillColorWithColor(context, [titleAttributes[NSForegroundColorAttributeName] CGColor]);
            [self.title drawInRect:CGRectMake((frameSize.width - titleSize.width) * 0.5 + self.titleOffest.horizontal,
                                              imageTopMaigin+imageSize.height+self.titleOffest.vertical,
                                              titleSize.width,
                                              titleSize.height)
                    withAttributes:titleAttributes];
        }
    }
    CGContextRestoreGState(context);
}
#pragma mark —— 手势的响应事件
-(void)LZBTabBarItemTap:(UITapGestureRecognizer *)tapGR{
    //点按手势
    if (self.LZBTabBarItemGestureRecognizerBlock) {
        self.LZBTabBarItemGestureRecognizerBlock(self,tapGR);
    }
}

-(void)LZBTabBarItemLongPress:(UILongPressGestureRecognizer *)longPressGR {
    switch (longPressGR.state) {
        case UIGestureRecognizerStatePossible:{
//            NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
        }break;
        case UIGestureRecognizerStateBegan:{
            //长按手势
            NSLog(@"一个手势已经开始  但尚未改变或者完成时");
            if (self.LZBTabBarItemGestureRecognizerBlock) {
                self.LZBTabBarItemGestureRecognizerBlock(self,longPressGR);
            }
        }break;
        case UIGestureRecognizerStateChanged:{
//            NSLog(@"手势状态改变");
        }break;
        case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
//            NSLog(@"手势完成");
        }break;
        case UIGestureRecognizerStateCancelled:{
//            NSLog(@"手势取消，恢复至Possible状态");
        }break;
        case UIGestureRecognizerStateFailed:{
//            NSLog(@"手势失败，恢复至Possible状态");
        }break;
        default:
            break;
    }
}

-(void)gestureRecognizerLZBTabBarItemBlock:(TwoDataBlock)LZBTabBarItemGestureRecognizerBlock{
    self.LZBTabBarItemGestureRecognizerBlock = LZBTabBarItemGestureRecognizerBlock;
}

-(void)setTagger:(NSInteger)tagger{
    _tagger = tagger;
}
#pragma mark —— lazyLoad
-(UITapGestureRecognizer *)tagGR{
    if (!_tagGR) {
        _tagGR = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                        action:@selector(LZBTabBarItemTap:)];
        _tagGR.delegate = self;
        
        _tagGR.numberOfTapsRequired = 1;//tap次数
        _tagGR.numberOfTouchesRequired = 1;//手指数
        
        [self addGestureRecognizer:_tagGR];
    }return _tagGR;
}

-(UILongPressGestureRecognizer *)longPressGR{

    /*
     * 长按手势是连续的。
     当在指定的时间段（minimumPressDuration）
     按下允许的手指的数量（numberOfTouchesRequired）
     并且触摸不超过允许的移动范围（allowableMovement）时，
     手势开始（UIGestureRecognizerStateBegan）。
     手指移动时，手势识别器转换到“更改”状态，
     并且当任何手指抬起时手势识别器结束（UIGestureRecognizerStateEnded）。
     *
     */
    
    if (!_longPressGR) {
        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(LZBTabBarItemLongPress:)];
        _longPressGR.delegate = self;
        
        _longPressGR.numberOfTouchesRequired = 1;//手指数
        _longPressGR.minimumPressDuration = 1;
//        _longPressGR.allowableMovement;

        [self addGestureRecognizer:_longPressGR];
    }return _longPressGR;
}
#pragma mark - config
- (void)setSelectImage:(UIImage *)selectImage
         unselectImage:(UIImage *)unSelectImage{
  if(self.selectImage != selectImage)
      self.selectImage = selectImage;
  if(self.unSelectImage != unSelectImage)
      self.unSelectImage = unSelectImage;
}

- (void)setUnSelectImage:(UIImage *)unSelectImage{
   if((_unSelectImage != unSelectImage) && unSelectImage)
       _unSelectImage = unSelectImage;
}

- (void)setSelectImage:(UIImage *)selectImage{
    if((_selectImage != selectImage) && selectImage)
        _selectImage = selectImage;
}

- (void)setBackgroundSelectedImage:(UIImage *)selectedImage
                   unselectedImage:(UIImage *)unselectedImage{
    if(self.selectBackgroundImage != selectedImage)
        self.selectBackgroundImage = selectedImage;
    if(self.unselectBackgroundImage != unselectedImage)
        self.unselectBackgroundImage = unselectedImage;
}

- (void)setUnselectBackgroundImage:(UIImage *)unselectBackgroundImage{
    if((_unselectBackgroundImage != unselectBackgroundImage) && unselectBackgroundImage)
        _unselectBackgroundImage = unselectBackgroundImage;
}

-(void)setSelectBackgroundImage:(UIImage *)selectBackgroundImage{
    if((_selectBackgroundImage != selectBackgroundImage) && selectBackgroundImage)
        _selectBackgroundImage = selectBackgroundImage;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsDisplay];
}

-(void)setAnimationView:(LOTAnimationView *)animationView{
    _animationView = animationView;
}

@end
