//
//  ViewController@1.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@1.h"

@interface ViewController_1 ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray <VideoModel_Core *>*__block dataMutArr;
@property(nonatomic,assign)long __block currentIndex;

@end

@implementation ViewController_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.currentIndex = 0;
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = KBrownColor;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],[ZBRequestManager networkReachability]);
//    [DataManager sharedInstance].tag = ReuseIdentifier;
//    /**
//     公共配置
//     插件机制
//     证书设置
//     */
//    [RequestTool setupPublicParameters];
//    @weakify(self)
//    [NetworkingAPI requestApi:NSObject.recommendVideosPOST.funcName
//                   parameters:@""
//                 successBlock:^(id data) {
//        @strongify(self)
//        NSLog(@"");
//        if ([data isKindOfClass:NSArray.class]) {
//            self.dataMutArr = (NSMutableArray *)data;
//        }
//        [self.tableView reloadData];
//    }];
//
//    self.tableView.alpha = 1;
//    [self monitorScrollView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.currentIndex = 0;//此时cell的第一次生命周期走完，置零
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti1" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)roll{
    if (self.currentIndex <= self.dataMutArr.count - 1 &&
        self.currentIndex >= 0) {
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
    }else{
        return;
    }
}
/*
 * 如果用户下拉,返回1;如果上拉快到底部时返回2
 * 并且在映射完成后用了distinctUntilChanged属性,当我的映射值不产生变化时是不会传递映射值的
 * 这样当用户拉倒需要刷新的位置,只会发一个信号给订阅者,只会执行一次刷新数据的方法
 */
-(void)monitorScrollView{
    [[[RACObserve(self.tableView, contentOffset) map:^id(id value) {
        if (self.tableView.contentOffset.y < - 50) {
            //下拉刷新方法
//            NSLog(@"1");
            return @"1";
        }
        
        if (self.tableView.contentOffset.y - self.tableView.contentSize.height < 80 &&
            self.tableView.contentSize.height > 80) {
            //上拉加载方法
            self.tableView.mj_footer.hidden = NO;
//            [self.tableView.mj_footer endRefreshingWithNoMoreData]; MJRefreshStateNoMoreData
            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            [self.tableView.mj_footer endRefreshing];
//            NSLog(@"2");
            return @"2";
        }else{
//            NSLog(@"0");
            return @"0";
        }
    }] distinctUntilChanged] subscribeNext:^(id x) {
        NSLog(@"%@",x);
        if ([x integerValue] == 1) {
//            NSLog(@"↓");
        }else if ([x integerValue] == 2){
//            NSLog(@"↑");
        }
    }];
}

-(void)delayMethods{
    self.tableView.mj_footer.state = MJRefreshStateIdle;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.pagingEnabled = YES;
//    [self.mj_footer endRefreshingWithNoMoreData];
}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    [self.tableView.mj_header endRefreshing];
//
}
///上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
//    [self.tableView reloadData];
    //特别说明：pagingEnabled = YES 在此会影响Cell的偏移量，原作者希望我们在这里临时关闭一下，刷新完成以后再打开
    self.tableView.pagingEnabled = NO;
    [self performSelector:@selector(delayMethods) withObject:nil afterDelay:2];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PlayerCell cellHeightWithModel:nil];
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerCell *cell = [PlayerCell cellWithTableView:tableView];
    cell.index = indexPath.row;
    [cell richElementsInCellWithModel:@{
        @"index":@(indexPath.row),
        @"res":self.dataMutArr[indexPath.row]
    }];
    
    self.currentIndex = indexPath.row;
    @weakify(self)
    [cell actionBlockPlayerCell:^(NSNumber *direction,
                                  NSNumber *index) {
        @strongify(self)
        self.currentIndex = index.intValue;
        if (direction.intValue) {//手势朝下
            self.currentIndex -= 1;
        }else{//手势朝上
            self.currentIndex += 1;
        }
        
        if (self.currentIndex < 0) {
            self.currentIndex = 0;
        }
        
        if (self.currentIndex > self.dataMutArr.count - 1) {
            self.currentIndex = self.dataMutArr.count - 1;
        }
        
        NSLog(@"MMM = %ld",self.currentIndex);
        [self roll];
    }];
    NSLog(@"DDD0 = %ld",self.currentIndex);
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell的生命周期
//将要出现的cell
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(PlayerCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"KKK %ld",(long)indexPath.row);

    [cell.player.currentPlayerManager play];
}
//已经消失的cell
- (void)tableView:(UITableView *)tableView
didEndDisplayingCell:(PlayerCell *)cell
forRowAtIndexPath:(NSIndexPath*)indexPath{
    NSLog(@"DDDD %ld",(long)indexPath.row);
    [cell.player.currentPlayerManager pause];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.pagingEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = UIView.new;
        
        _tableView.mj_header = self.lotAnimationMJRefreshHeader;
//        _tableView.mj_header.triggerAutomaticallyRefreshPercent = 0.5;
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        _tableView.mj_footer = self.mjRefreshAutoGifFooter;
        _tableView.mj_footer.hidden = NO;

        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@"暂无数据"
                                                         detailStr:@"骚等片刻"];
        
        if (self.dataMutArr.count) {
            [_tableView ly_hideEmptyView];
        }else{
            [_tableView ly_showEmptyView];
        }
             
        if(@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }

        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }

            if ([DouYinAppDelegate sharedInstance].tabBarVC.tabBar.isHidden) {
                make.bottom.equalTo(self.view.mas_bottom);
            }else{
                make.bottom.equalTo(self.view.mas_bottom).offset(-[DouYinAppDelegate sharedInstance].tabBarVC.tabBar.height);
            }
        }];
    }return _tableView;
}

-(NSMutableArray<VideoModel_Core *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
//        [_dataMutArr addObject:@"0"];
//        [_dataMutArr addObject:@"1"];
//        [_dataMutArr addObject:@"2"];
//        [_dataMutArr addObject:@"3"];
//        [_dataMutArr addObject:@"4"];
//        [_dataMutArr addObject:@"5"];
//        [_dataMutArr addObject:@"6"];
//        [_dataMutArr addObject:@"7"];
//        [_dataMutArr addObject:@"8"];
//        [_dataMutArr addObject:@"9"];
//        [_dataMutArr addObject:@"10"];
//        [_dataMutArr addObject:@"11"];
//        [_dataMutArr addObject:@"12"];
//        [_dataMutArr addObject:@"13"];
//        [_dataMutArr addObject:@"14"];
//        [_dataMutArr addObject:@"15"];
//        [_dataMutArr addObject:@"16"];
//        [_dataMutArr addObject:@"17"];
//        [_dataMutArr addObject:@"18"];
//        [_dataMutArr addObject:@"19"];
//        [_dataMutArr addObject:@"20"];
//        [_dataMutArr addObject:@"21"];
//        [_dataMutArr addObject:@"22"];
//        [_dataMutArr addObject:@"23"];
//        [_dataMutArr addObject:@"24"];
//        [_dataMutArr addObject:@"25"];
//        [_dataMutArr addObject:@"26"];
//        [_dataMutArr addObject:@"27"];
//        [_dataMutArr addObject:@"28"];
//        [_dataMutArr addObject:@"29"];
    }return _dataMutArr;
}

@end
