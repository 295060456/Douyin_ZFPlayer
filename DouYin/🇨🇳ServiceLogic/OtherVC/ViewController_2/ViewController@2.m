//
//  ViewController@2.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@2.h"

#import "ZFCustomControlView.h"
#import "ZFDouYinControlView.h"
#import "ZFDouYinCellDelegate.h"

#import "ZFDouYinCell.h"

/// 播放器view的tag，列表中UI控件唯一tag值
#define kPlayerViewTag 100

@interface ViewController_2 ()
<
UITableViewDelegate,
UITableViewDataSource,
ZFDouYinCellDelegate
>
{
    
}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFDouYinControlView *controlView;
@property(nonatomic,strong)ZFCustomControlView *fullControlView;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;

@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ViewController_2

-(void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark —— Lifecycle
-(instancetype)init{
    if (self = [super init]) {
       
    }return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navBarAlpha = 0.3;
    self.tableView.alpha = 1;
    [self loadNewData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
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

//-(void)delayMethods{
//    self.tableView.mj_footer.state = MJRefreshStateIdle;
//    self.tableView.mj_footer.hidden = YES;
//    self.tableView.pagingEnabled = YES;
////    [self.mj_footer endRefreshingWithNoMoreData];
//}
///下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    [self.tableView.mj_header endRefreshing];
//
}
/////上拉加载更多
//- (void)loadMoreRefresh{
//    NSLog(@"上拉加载更多");
////    [self.tableView reloadData];
//    //特别说明：pagingEnabled = YES 在此会影响Cell的偏移量，原作者希望我们在这里临时关闭一下，刷新完成以后再打开
//    self.tableView.pagingEnabled = NO;
//    [self performSelector:@selector(delayMethods) withObject:nil afterDelay:2];
//}

-(void)loadNewData{
    [self.dataSource removeAllObjects];
    @zf_weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
        /// 下拉时候一定要停止当前播放，不然有新数据，播放位置会错位。
        [self.player stopCurrentPlayingCell];
        [self requestData];
        [self.tableView reloadData];
        /// 找到可以播放的视频并播放
        [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
            @zf_strongify(self)
            [self playTheVideoAtIndexPath:indexPath];
        }];
    });
}

-(void)requestData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
    
    NSArray *videoList = [rootDict objectForKey:@"list"];
    for (NSDictionary *dataDic in videoList) {
        ZFTableData *data = [[ZFTableData alloc] init];
        [data setValuesForKeysWithDictionary:dataDic];
        [self.dataSource addObject:data];
    }
    [self.tableView.mj_header endRefreshing];
}

-(void)playTheIndex:(NSInteger)index{
    @zf_weakify(self)
    /// 指定到某一行播放
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionNone
                                  animated:NO];
    [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @zf_strongify(self)
        [self playTheVideoAtIndexPath:indexPath];
    }];
    /// 如果是最后一行，去请求新数据
    if (index == self.dataSource.count - 1) {
        /// 加载下一页数据
        [self requestData];
        [self.tableView reloadData];
    }
}

-(void)backItemClick:(id)sender{
    NSLog(@"返回按钮点击事件");
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}
/// play the video
-(void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath{
    ZFTableData *data = self.dataSource[indexPath.row];
    [self.player playTheIndexPath:indexPath
                         assetURL:[NSURL URLWithString:data.video_url]];
//    [self.player playTheIndexPath:indexPath assetURL:[VIResourceLoaderManager assetURLWithURL:[NSURL URLWithString:data.video_url]]];
    [self.controlView resetControlView];
    [self.controlView showCoverViewWithUrl:data.thumbnail_url];
    [self.fullControlView showTitle:@"custom landscape controlView"
                     coverURLString:data.thumbnail_url
                     fullScreenMode:ZFFullScreenModeLandscape];
}
#pragma mark - ZFTableViewCellDelegate
-(void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath{
    [self playTheVideoAtIndexPath:indexPath];
}
#pragma mark - ZFDouYinCellDelegate
-(void)zf_douyinRotation{
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    if(self.player.isFullScreen){
        orientation = UIInterfaceOrientationPortrait;
    }else{
        orientation = UIInterfaceOrientationLandscapeRight;
    }
    [self.player rotateToOrientation:orientation
                            animated:YES
                          completion:nil];
}
#pragma mark —— UIScrollViewDelegate 列表播放必须实现
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewDidEndDecelerating];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewDidScrollToTop];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewDidScroll];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [scrollView zf_scrollViewWillBeginDragging];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ZFDouYinCell cellHeightWithModel:nil];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZFDouYinCell *cell = [ZFDouYinCell cellWith:tableView];
    cell.delegate = self;
    cell.index = indexPath.row;
    [cell richElementsInCellWithModel:@{
        @"index":@(indexPath.row),
        @"res":self.dataSource[indexPath.row]//ZFTableData
    }];return cell;
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark —— lazyLoad
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            self.automaticallyAdjustsScrollViewInsets = NO;
#pragma clang diagnostic pop
        }
        
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_header.automaticallyChangeAlpha = YES;
        
//        _tableView.mj_footer = self.mjRefreshAutoGifFooter;
//        // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
////        _tableView.mj_footer.triggerAutomaticallyRefreshPercent = 0.5;
//        _tableView.mj_footer.hidden = NO;
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (self.gk_navigationBar) {
                make.top.equalTo(self.view.mas_top);
            }else{
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }
            
            if ([SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden) {
                make.bottom.equalTo(self.view.mas_bottom);
            }else{
                extern CGFloat LZB_TABBAR_HEIGHT;
                make.bottom.equalTo(self.view.mas_bottom).offset(-LZB_TABBAR_HEIGHT);
            }
        }];
    }return _tableView;
}

-(ZFPlayerController *)player{
    if (!_player) {
        /// player,tag值必须在cell里设置
        _player = [ZFPlayerController playerWithScrollView:self.tableView
                                             playerManager:self.playerManager
                                          containerViewTag:kPlayerViewTag];
        _player.disableGestureTypes = ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
        _player.controlView = self.controlView;

        _player.allowOrentitaionRotation = NO;
        _player.WWANAutoPlay = YES;
        /// 1.0是完全消失时候
        _player.playerDisapperaPercent = 1.0;
        
        @zf_weakify(self)
        _player.playerDidToEnd = ^(id  _Nonnull asset) {
            @zf_strongify(self)
            [self->_player.currentPlayerManager replay];
        };

        _player.orientationWillChange = ^(ZFPlayerController * _Nonnull player,
                                          BOOL isFullScreen) {
            AppDelegate.sharedInstance.allowOrentitaionRotation = isFullScreen;
            @zf_strongify(self)
            self->_player.controlView.hidden = YES;
        };
        
        _player.orientationDidChanged = ^(ZFPlayerController * _Nonnull player,
                                          BOOL isFullScreen) {
            @zf_strongify(self)
            self->_player.controlView.hidden = NO;
            if (isFullScreen) {
                self->_player.controlView = self.fullControlView;
            } else {
                self->_player.controlView = self.controlView;
            }
        };
        
        /// 更新另一个控制层的时间
        _player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset,
                                          NSTimeInterval currentTime,
                                          NSTimeInterval duration) {
            @zf_strongify(self)
            if ([self->_player.controlView isEqual:self.fullControlView]) {
                [self.controlView videoPlayer:self->_player
                                  currentTime:currentTime
                                    totalTime:duration];
            } else if ([self->_player.controlView isEqual:self.controlView]) {
                [self.fullControlView videoPlayer:self->_player
                                      currentTime:currentTime
                                        totalTime:duration];
            }
        };
        
        /// 更新另一个控制层的缓冲时间
        _player.playerBufferTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset,
                                            NSTimeInterval bufferTime) {
            @zf_strongify(self)
            if ([_player.controlView isEqual:self.fullControlView]) {
                [self.controlView videoPlayer:self->_player
                                   bufferTime:bufferTime];
            } else if ([self->_player.controlView isEqual:self.controlView]) {
                [self.fullControlView videoPlayer:self->_player
                                       bufferTime:bufferTime];
            }
        };
        
        /// 停止的时候找出最合适的播放
        _player.zf_scrollViewDidEndScrollingCallback = ^(NSIndexPath * _Nonnull indexPath) {
            @zf_strongify(self)
            if (self->_player.playingIndexPath) return;
            if (indexPath.row == self.dataSource.count - 1) {
                /// 加载下一页数据
                [self requestData];
                [self.tableView reloadData];
            }
            [self playTheVideoAtIndexPath:indexPath];
        };
    }return _player;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
    }return _playerManager;
}

-(ZFDouYinControlView *)controlView{
    if (!_controlView){
        _controlView = ZFDouYinControlView.new;
    }return _controlView;
}

- (ZFCustomControlView *)fullControlView {
    if (!_fullControlView) {
        _fullControlView = ZFCustomControlView.new;
    }return _fullControlView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = NSMutableArray.array;
    }return _dataSource;
}

@end
