//
//  JXCategoryTitleBackgroundView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleBackgroundView.h"

@interface JXCategoryTitleBackgroundView ()

@property(nonatomic,strong)NSMutableArray <JXCategoryTitleBackgroundCellModel *>*tempMutArray;

@end

@implementation JXCategoryTitleBackgroundView

- (void)initializeData {
    [super initializeData];

    self.cellWidthIncrement = 20;
    self.normalBackgroundColor = COLOR_RGB(237, 236, 242);
    self.normalBorderColor = kClearColor;
    self.selectedBackgroundColor = [COLOR_RGB(255, 232, 236) colorWithAlphaComponent:0.3];
    self.selectedBorderColor = kClearColor;
    self.borderLineWidth = 1;
    self.backgroundCornerRadius = 13;
    self.backgroundWidth = JXCategoryViewAutomaticDimension;
    self.backgroundHeight = 27;
}
//返回自定义的cell class
- (Class)preferredCellClass {
    return JXCategoryTitleBackgroundCell.class;
}

- (void)refreshDataSource {
    self.dataSource = self.tempMutArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel
                   index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleBackgroundCellModel *myModel = (JXCategoryTitleBackgroundCellModel *)cellModel;
    myModel.normalBackgroundColor = self.normalBackgroundColor;
    myModel.normalBorderColor = self.normalBorderColor;
    myModel.selectedBackgroundColor = self.selectedBackgroundColor;
    myModel.selectedBorderColor = self.selectedBorderColor;
    myModel.borderLineWidth = self.borderLineWidth;
    myModel.backgroundCornerRadius = self.backgroundCornerRadius;
    myModel.backgroundWidth = self.backgroundWidth;
    myModel.backgroundHeight = self.backgroundHeight;
}
#pragma mark —— LazyLoad
-(NSMutableArray<JXCategoryTitleBackgroundCellModel *> *)tempMutArray{
    if (!_tempMutArray) {
        _tempMutArray = NSMutableArray.array;
        for (int i = 0; i < self.titles.count; i++) {
            [_tempMutArray addObject:JXCategoryTitleBackgroundCellModel.new];
        }
    }return _tempMutArray;
}

@end
