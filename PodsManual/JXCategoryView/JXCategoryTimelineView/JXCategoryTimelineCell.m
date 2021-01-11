//
//  JXCategoryTimelineCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/23.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTimelineCell.h"
#import "JXCategoryTimelineCellModel.h"

@interface JXCategoryTimelineCell ()

@property(nonatomic,strong)UILabel *timeLabel;

@end

@implementation JXCategoryTimelineCell

- (void)initializeViews{
    [super initializeViews];
    self.timeLabel.alpha = 1;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];
    JXCategoryTimelineCellModel *myCellModel = (JXCategoryTimelineCellModel *)cellModel;
    self.timeLabel.text = myCellModel.timeTitle;
    if (myCellModel.isSelected) {
        self.timeLabel.textColor = myCellModel.timeTitleSelectedColor;
        self.timeLabel.font = myCellModel.timeTitleSelectedFont;
    }else {
        self.timeLabel.textColor = myCellModel.timeTitleNormalColor;
        self.timeLabel.font = myCellModel.timeTitleFont;
    }
}
#pragma mark —— lazyLoad
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = UILabel.new;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_timeLabel];
        NSLayoutConstraint *timeLabelCenterX = [NSLayoutConstraint constraintWithItem:_timeLabel
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.contentView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:0];
        NSLayoutConstraint *timeLabelCenterY = [NSLayoutConstraint constraintWithItem:_timeLabel
                                                                            attribute:NSLayoutAttributeCenterY
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.contentView
                                                                            attribute:NSLayoutAttributeTop
                                                                           multiplier:1
                                                                             constant:20];
        [NSLayoutConstraint activateConstraints:@[timeLabelCenterX, timeLabelCenterY]];
    }return _timeLabel;
}

@end
