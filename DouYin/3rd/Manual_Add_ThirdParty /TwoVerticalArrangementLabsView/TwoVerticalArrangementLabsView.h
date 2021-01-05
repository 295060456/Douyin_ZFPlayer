//
//  TwoVerticalArrangementLabsView.h
//  DouDong-II
//
//  Created by Jobs on 2021/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
// 封装的垂直排列的两个Label
@interface LabsModel : NSObject

#pragma mark —— topLab
@property(nonatomic,strong)NSString *topLabTitleStr;
@property(nonatomic,strong)UIColor *topLabTextCor;
@property(nonatomic,strong)UIFont *topLabFont;
#pragma mark —— bottomLab
@property(nonatomic,strong)NSString *bottomLabTitleStr;
@property(nonatomic,strong)UIColor *bottomLabTextCor;
@property(nonatomic,strong)UIFont *bottomLabFont;

@end

@interface TwoVerticalArrangementLabsView : UIView

-(void)richElementsInCellWithModel:(LabsModel *_Nullable)model;
-(void)actionBlockTwoVerticalArrangementLabsView:(MKDataBlock)twoVerticalArrangementLabsViewBlock;

@end

NS_ASSUME_NONNULL_END
