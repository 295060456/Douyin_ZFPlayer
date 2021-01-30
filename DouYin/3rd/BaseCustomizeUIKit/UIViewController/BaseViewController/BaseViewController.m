//
//  BaseViewController.m
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#ifdef DEBUG
    [self ifEmptyData];
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.targetView.mj_footer.y = self.view.targetView.contentSize.height;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)keyboard{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrameNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrameNotification:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;// 正则抬起 ，负值下降
    NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
 
    if (KeyboardOffsetY > 0) {
        NSLog(@"键盘抬起");
    }else if(KeyboardOffsetY < 0){
        NSLog(@"键盘收回");
    }else{
        NSLog(@"键盘");
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{

}
#pragma mark —— lazyLoad
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = UIImageView.new;
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.frame = self.view.bounds;
        self.view = _bgImageView;
    }return _bgImageView;
}

@end
