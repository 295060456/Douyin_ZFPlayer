//
//  JobsPullListTBVCell.m
//  TabbarItemLottie
//
//  Created by Jobs on 2020/10/15.
//

#import "JobsPullListTBVCell.h"

@interface JobsPullListTBVCell ()

@end

@implementation JobsPullListTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    JobsPullListTBVCell *cell = (JobsPullListTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[JobsPullListTBVCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        NSArray *titleArr = dic[@"titleMutArr"];
        NSArray *imagesArr = dic[@"imagesMutArr"];
        if (titleArr.count) {
            self.textLabel.text = titleArr[self.indexRow];
        }
        if (imagesArr.count) {
            self.imageView.image = imagesArr[self.indexRow];
        }
    }
}

@end
