//
//  ViewForTableViewFooter.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "ViewForTableViewFooter.h"

@interface ViewForTableViewFooter ()

@property(nonatomic,copy)MKDataBlock _Nullable viewForTableViewFooterBlock;

@end

@implementation ViewForTableViewFooter

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }return self;
}

-(void)richElementsInViewWithModel:(id _Nullable)model{
    
}

+(CGFloat)heightWithModel:(id _Nullable)model{
    return 0.0f;
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
