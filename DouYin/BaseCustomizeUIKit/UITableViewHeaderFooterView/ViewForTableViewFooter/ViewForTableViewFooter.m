//
//  ViewForTableViewFooter.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "ViewForTableViewFooter.h"

@implementation ViewForTableViewFooter

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.viewForTableViewFooterBlock) {
        self.viewForTableViewFooterBlock(@1);
    }
}

-(void)actionBlockViewForTableViewFooter:(MKDataBlock _Nullable)viewForTableViewFooterBlock{
    self.viewForTableViewFooterBlock = viewForTableViewFooterBlock;
}


@end
