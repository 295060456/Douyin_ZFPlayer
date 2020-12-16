//
//  ViewForTableViewFooter.h
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewForTableViewFooter : UITableViewHeaderFooterView

@property(nonatomic,copy)MKDataBlock _Nullable viewForTableViewFooterBlock;

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockViewForTableViewFooter:(MKDataBlock _Nullable)viewForTableViewFooterBlock;

@end

NS_ASSUME_NONNULL_END
