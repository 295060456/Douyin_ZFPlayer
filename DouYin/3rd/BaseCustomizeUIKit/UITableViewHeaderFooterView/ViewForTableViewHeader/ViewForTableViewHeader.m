//
//  ViewForTableViewHeader.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "ViewForTableViewHeader.h"

@interface ViewForTableViewHeader ()

@property(nonatomic,copy)MKDataBlock _Nullable viewForTableViewHeaderBlock;

@end

@implementation ViewForTableViewHeader

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
    if (self.viewForTableViewHeaderBlock) {
        self.viewForTableViewHeaderBlock(@1);
    }
}

-(void)actionBlockViewForTableViewHeader:(MKDataBlock _Nullable)viewForTableViewHeaderBlock{
    self.viewForTableViewHeaderBlock = viewForTableViewHeaderBlock;
}

@end
