//
//  ViewForTableViewHeader.h
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewForTableViewHeader : UITableViewHeaderFooterView

@property(nonatomic,copy)MKDataBlock _Nullable viewForTableViewHeaderBlock;

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockViewForTableViewHeader:(MKDataBlock _Nullable)viewForTableViewHeaderBlock;

@end

NS_ASSUME_NONNULL_END
