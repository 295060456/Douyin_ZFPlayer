//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@end

@implementation CollectionViewCell


-(void)shadowCell{
    self.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.shadowRadius = 8.0f;
    self.layer.shadowOpacity = 0.7f;
}

@end
