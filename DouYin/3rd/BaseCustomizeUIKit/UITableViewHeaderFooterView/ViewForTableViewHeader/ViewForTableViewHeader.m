//
//  ViewForTableViewHeader.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "ViewForTableViewHeader.h"

@interface ViewForTableViewHeader ()

@end

@implementation ViewForTableViewHeader

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }return self;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.viewForTableViewHeaderBlock) {
        self.viewForTableViewHeaderBlock(@1);
    }
}

-(void)actionBlockViewForTableViewHeader:(MKDataBlock _Nullable)viewForTableViewHeaderBlock{
    self.viewForTableViewHeaderBlock = viewForTableViewHeaderBlock;
}


@end
