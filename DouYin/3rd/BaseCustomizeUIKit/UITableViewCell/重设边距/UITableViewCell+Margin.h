//
//  UITableViewCell+Margin.h
//  JobsIM
//
//  Created by Jobs on 2020/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Margin)

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)CGFloat marginX;
@property(nonatomic,assign)CGFloat marginY;

@end

NS_ASSUME_NONNULL_END
