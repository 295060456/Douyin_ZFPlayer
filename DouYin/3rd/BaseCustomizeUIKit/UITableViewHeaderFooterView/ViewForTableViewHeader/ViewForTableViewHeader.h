//
//  ViewForTableViewHeader.h
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import <UIKit/UIKit.h>
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewForTableViewHeader : UITableViewHeaderFooterView

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)actionBlockViewForTableViewHeader:(MKDataBlock _Nullable)viewForTableViewHeaderBlock;
+(CGFloat)heightWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
