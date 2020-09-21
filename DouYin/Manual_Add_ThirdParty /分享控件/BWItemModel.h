//
//  BWItemModel.h
//  BWShareView
//
//  Created by syt on 2019/12/23.
//  Copyright © 2019 syt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BWItemModel : NSObject

@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *text;

- (instancetype)initWithImg:(NSString *)img
                       text:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
