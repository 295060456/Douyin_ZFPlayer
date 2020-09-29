//
//  ZYTextField.m
//  gt
//
//  Created by Administrator on 09/05/2019.
//  Copyright © 2019 GT. All rights reserved.
//

#import "ZYTextField_01.h"

@interface ZYTextField_01 (){
}

@property(nonatomic,copy)NSString *documentName;//数据文件名
@property(nonatomic,strong)NSMutableSet *mutSet;

@end

@implementation ZYTextField_01

//通过代码创建
- (instancetype)initWithFrame:(CGRect)frame
                 documentName:(NSString *)docName
           isStoreHistoryInfo:(isStoreHistoryInfo)isStoreHistoryInfo{
    
    if (self = [super initWithFrame:frame]) {
        self.documentName = docName;
        [self setUpUI];
        if (isStoreHistoryInfo) {
            [self setUpData];
        }
    }return self;
}

-(void)setUpData{
    self.dataMutArr = [[NSMutableArray alloc]initWithContentsOfFile:[self getPlistPath]];//开始读取plist文件
}

- (void)setUpUI{
    self.font = [UIFont systemFontOfSize:15];//字体大小
    self.textColor = RGBCOLOR(77,
                              150,
                              132);//字体颜色
    self.tintColor = self.textColor;//光标颜色
    
    UILabel *placeholderLabel = object_getIvar(self, class_getInstanceVariable([UITextField class], "_placeholderLabel"));
    placeholderLabel.textColor = RGBCOLOR(167,
                                          167,
                                          167);
    placeholderLabel.font = [UIFont boldSystemFontOfSize:15];
    
    [self resignFirstResponder];// 不成为第一响应者
}
/**
 * 当前文本框聚焦时就会调用
 */
- (BOOL)becomeFirstResponder{
    // 修改占位文字颜色
    UILabel *placeholderLabel = object_getIvar(self, class_getInstanceVariable([UITextField class], "_placeholderLabel"));
    placeholderLabel.textColor = self.textColor;
    if (self.dataMutArr.count > 0) {
        //添加到父视图上
        [self.superview addSubview:self.historyDataListTBV];
        self.historyDataListTBV.frame = CGRectMake(self.mj_x,
                                                   self.mj_y + self.mj_h,
                                                   self.mj_w,
                                                   [HistoryDataListTBVCell cellHeightWithModel:Nil] * self.dataMutArr.count);
        [self.historyDataListTBV reloadData];
    }return [super becomeFirstResponder];
}
/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder{
    UILabel *placeholderLabel = object_getIvar(self, class_getInstanceVariable([UITextField class], "_placeholderLabel"));
    placeholderLabel.textColor = [UIColor grayColor];// 修改占位文字颜色
    if (_historyDataListTBV) {//关闭
        [self.historyDataListTBV removeFromSuperview];
        _historyDataListTBV = Nil;
    }return [super resignFirstResponder];
}
//控制placeHolder的位置
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 15,
                              bounds.origin.y,
                              bounds.size.width - 15,
                              bounds.size.height);
    
    return inset;
}
//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 15,
                              bounds.origin.y,
                              bounds.size.width - 15,
                              bounds.size.height);
    
    return inset;
}
//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x + 15,
                              bounds.origin.y,
                              bounds.size.width - 15,
                              bounds.size.height);
    return inset;
}
//存取路径
-(NSString *)getPlistPath{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,
                                                             YES);
    NSString *path = [pathArray objectAtIndex:0];
    return [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",self.documentName]];
}
//存方法
-(void)store:(NSString *)str{
    //为空不存
    if (![NSString isNullString:str]) {
        if (self.dataMutArr.count != 0) {//本地有数据
            [self.mutSet addObjectsFromArray:self.dataMutArr];
        }
        [self.mutSet addObject:str];
        [[self.mutSet allObjects] writeToFile:[self getPlistPath]
                                   atomically:YES];
        [self.dataMutArr removeAllObjects];
        self.dataMutArr = [NSMutableArray arrayWithArray:[self.mutSet allObjects]];
    }else return;
}
#pragma mark —— 子类需要覆写
// 下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
}
//上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
}
#pragma mark —— lazyLoad
-(HistoryDataListTBV *)historyDataListTBV{
    if (!_historyDataListTBV) {
        _historyDataListTBV = [HistoryDataListTBV initWithRequestParams:self.dataMutArr
                                                              triggerBy:self];
//        @weakify(self)
//        [_historyDataListTBV dele];
        
//        [_historyDataListTBV deleteData:^(id  _Nullable data) {
//            @strongify(self)
//            NSLog(@"%@",data);
//            [self.dataMutArr removeObject:data];
//            [self->_historyDataListTBV reloadData];
//        }];
//        [_historyDataListTBV showSelectedData:^(id data) {
//            @strongify(self)
//            self.text = data;
//        }];
        _historyDataListTBV.tableFooterView = UIView.new;
    }return _historyDataListTBV;
}

-(MJRefreshGifHeader *)tableViewHeader{
    if (!_tableViewHeader) {
        _tableViewHeader =  [MJRefreshGifHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(pullToRefresh)];
        // 设置普通状态的动画图片
        [_tableViewHeader setImages:@[KIMG(@"猫粮")]
                           forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [_tableViewHeader setImages:@[KIMG(@"猫咪")]
                           forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [_tableViewHeader setImages:@[KIMG(@"猫爪")]
                           forState:MJRefreshStateRefreshing];
        // 设置文字
        [_tableViewHeader setTitle:@"Click or drag down to refresh" forState:MJRefreshStateIdle];
        [_tableViewHeader setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
        [_tableViewHeader setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
        // 设置字体
        _tableViewHeader.stateLabel.font = [UIFont systemFontOfSize:17];
        // 设置颜色
        _tableViewHeader.stateLabel.textColor = KLightGrayColor;
    }return _tableViewHeader;
}

-(MJRefreshAutoGifFooter *)tableViewFooter{
    if (!_tableViewFooter) {
        _tableViewFooter = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadMoreRefresh)];
        // 设置普通状态的动画图片
        [_tableViewFooter setImages:@[KIMG(@"猫粮")]
                           forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [_tableViewFooter setImages:@[KIMG(@"猫咪")]
                           forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [_tableViewFooter setImages:@[KIMG(@"猫爪")]
                           forState:MJRefreshStateRefreshing];
        // 设置文字
        [_tableViewFooter setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
        [_tableViewFooter setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
        [_tableViewFooter setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
        // 设置字体
        _tableViewFooter.stateLabel.font = [UIFont systemFontOfSize:17];
        // 设置颜色
        _tableViewFooter.stateLabel.textColor = KLightGrayColor;
        _tableViewFooter.hidden = YES;
    }return _tableViewFooter;
}

-(NSMutableSet *)mutSet{
    if (!_mutSet) {
        _mutSet = NSMutableSet.set;
    }return _mutSet;
}

@end
