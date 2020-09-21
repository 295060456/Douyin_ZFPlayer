//
//  BWItemCollectionViewCell.m
//  BWShareView
//
//  Created by syt on 2019/12/23.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWItemCollectionViewCell.h"
#import "BWItemModel.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface BWItemCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BWItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBColor(245, 245, 245);
        [self loadSubViews];
    }return self;
}

- (void)loadSubViews{
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)updateContent:(BWItemModel *)model{
    self.imgView.image = [UIImage imageNamed:model.img];
    self.titleLabel.text = [NSString stringWithFormat:@"%@", model.text];
}

#pragma mark - LazyLoad
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15,
                                                                 5,
                                                                 50,
                                                                 50)];
//        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetMaxY(self.imgView.frame) + 5,
                                                                self.contentView.frame.size.width,
                                                                15)];
        _titleLabel.text = @"";
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }return _titleLabel;
}






@end
