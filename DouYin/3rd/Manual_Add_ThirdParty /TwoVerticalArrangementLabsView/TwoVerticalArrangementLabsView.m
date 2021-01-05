//
//  TwoVerticalArrangementLabsView.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import "TwoVerticalArrangementLabsView.h"

@implementation LabsModel

#pragma mark —— lazyLoad
-(UIColor *)topLabTextCor{
    if (!_topLabTextCor) {
        _topLabTextCor = kBlackColor;
    }return _topLabTextCor;
}

-(UIFont *)topLabFont{
    if (!_topLabFont) {
        _topLabFont = [UIFont systemFontOfSize:15
                                        weight:UIFontWeightMedium];
    }return _topLabFont;
}

-(UIColor *)bottomLabTextCor{
    if (!_bottomLabTextCor) {
        _bottomLabTextCor = kBlackColor;
    }return _bottomLabTextCor;
}

-(UIFont *)bottomLabFont{
    if (!_bottomLabFont) {
        _bottomLabFont = [UIFont systemFontOfSize:10
                                           weight:UIFontWeightRegular];
    }return _bottomLabFont;
}

@end

@interface TwoVerticalArrangementLabsView ()
// UI
@property(nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong)UILabel *bottomLab;
// Data
@property(nonatomic,copy)MKDataBlock twoVerticalArrangementLabsViewBlock;
@property(nonatomic,strong)LabsModel *labsModel;

@end

@implementation TwoVerticalArrangementLabsView

-(void)richElementsInCellWithModel:(LabsModel *_Nullable)model{
    self.labsModel = (LabsModel *)model;
    if (self.labsModel) {
        self.topLab.alpha = 1;
        self.bottomLab.alpha = 1;
    }
}

-(void)actionBlockTwoVerticalArrangementLabsView:(MKDataBlock)twoVerticalArrangementLabsViewBlock{
    self.twoVerticalArrangementLabsViewBlock = twoVerticalArrangementLabsViewBlock;
}
#pragma mark —— lazyLoad
-(UILabel *)topLab{
    if (!_topLab) {
        _topLab = UILabel.new;
        _topLab.text = self.labsModel.topLabTitleStr;
        _topLab.textColor = self.labsModel.topLabTextCor;
        _topLab.font = self.labsModel.topLabFont;
        _topLab.textAlignment = NSTextAlignmentCenter;
        [_topLab sizeToFit];
        [self addSubview:_topLab];
        [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
        }];
    }return _topLab;
}

-(UILabel *)bottomLab{
    if (!_bottomLab) {
        _bottomLab = UILabel.new;
        _bottomLab.text = self.labsModel.bottomLabTitleStr;
        _bottomLab.textColor = self.labsModel.bottomLabTextCor;
        _bottomLab.font = self.labsModel.bottomLabFont;
        _bottomLab.textAlignment = NSTextAlignmentCenter;
        [_bottomLab sizeToFit];
        [self addSubview:_bottomLab];
        [_bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self.topLab.mas_bottom);
        }];
    }return _bottomLab;
}

@end


