//
//  BWItemCollectionViewCell.h
//  BWShareView
//
//  Created by syt on 2019/12/23.
//  Copyright © 2019 syt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface BWItemCollectionViewCell : UICollectionViewCell

- (void)updateContent:(BWItemModel *)model;

@end

NS_ASSUME_NONNULL_END
