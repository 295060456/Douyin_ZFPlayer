//
//  BaseViewController.h
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import <UIKit/UIKit.h>

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#if __has_include(<TABAnimated/TABAnimated.h>)
#import <TABAnimated/TABAnimated.h>
#else
#import "TABAnimated.h"
#endif

#import "AABlock.h"
#import "BaseViewProtocol.h"
#import "UIView+EmptyData.h"
#import "UIView+MJRefresh.h"
#import "UIView+Measure.h"
#import "UIViewController+BaseNavigationBar.h"
#import "UIViewController+EmptyData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController<BaseViewProtocol>

#pragma mark —— RACSignal
@property(nonatomic,strong)RACSignal *reqSignal;
@property(nonatomic,assign)BOOL setupNavigationBarHidden;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,assign)NSInteger __block currentPage;
@property(nonatomic,copy)MKDataBlock viewControllerBlock;
/*
    用于以此为基类的控制器上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockViewController:(MKDataBlock)viewControllerBlock;

/***
 加入键盘监听者 和 停止MJ_Refresh刷新 移到了NSObject 分类层，定位于 @interface NSObject (Extras)。这么做是考虑到调用类可能不仅仅局限于UIViewController

 -(void)keyboard;//加入键盘通知的监听者
 -(void)endRefreshing:(UIScrollView *_Nonnull)targetScrollView; 停止刷新
 
 **/

@end

NS_ASSUME_NONNULL_END

/**
 *  要想隐藏系统的导航栏，这里有2个手段。一个是在UIViewController的基类，一个是在UIViewController的分类
 * 1、如果要在viewDidLoad实现隐藏系统的导航栏，则调用UIViewController基类的父类方法self.setupNavigationBarHidden = YES;
 * 2、如果要在viewWillAppear实现隐藏系统的导航栏，则调用UIViewController分类的方法self.isHiddenNavigationBar = YES;//禁用系统的导航栏
 */

/**
 *
     _collectionView.mj_header = self.mjRefreshGifHeader;
     _collectionView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
     self.view.mjRefreshTargetView = _collectionView;
     _collectionView.mj_footer = self.mjRefreshAutoNormalFooter;
     _collectionView.mj_footer.hidden = YES;

*/

/* TABAnimated 使用示范
-(UICollectionView *)collectionView{
 if (!_collectionView) {
     _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:self.layout];
     _collectionView.backgroundColor = self.bgCor;
     _collectionView.dataSource = self;
     _collectionView.delegate = self;
     _collectionView.showsVerticalScrollIndicator = NO;
     
     [_collectionView RegisterClass];

     [self.scrollView addSubview:_collectionView];
     [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.equalTo(self.view);
         make.top.equalTo(self.view).offset(153.5);
     }];
     
     {
         
         NSArray *classArray = @[
                                 DDCollectionViewCell_Style2.class,
                                 DDCollectionViewCell_Style3.class,
                                 DDCollectionViewCell_Style4.class,
                                 ];
         NSArray *sizeArray = @[
                                [NSValue valueWithCGSize:[DDCollectionViewCell_Style2 cellSizeWithModel:nil]],
                                [NSValue valueWithCGSize:[DDCollectionViewCell_Style3 cellSizeWithModel:nil]],
                                [NSValue valueWithCGSize:[DDCollectionViewCell_Style4 cellSizeWithModel:nil]]
                                ];
         
         _collectionView.tabAnimated = [TABCollectionAnimated animatedWithCellClassArray:classArray
                                                                           cellSizeArray:sizeArray
                                                                      animatedCountArray:@[@(1),@(1),@(1)]];
         
         [_collectionView.tabAnimated addHeaderViewClass:BaseCollectionReusableView_Style1.class
                                                viewSize:[BaseCollectionReusableView_Style1 collectionReusableViewSizeWithModel:nil]
                                               toSection:0];
         [_collectionView.tabAnimated addHeaderViewClass:BaseCollectionReusableView_Style1.class
                                                viewSize:[BaseCollectionReusableView_Style2 collectionReusableViewSizeWithModel:nil]
                                               toSection:2];
         
         _collectionView.tabAnimated.containNestAnimation = YES;
         _collectionView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
         _collectionView.tabAnimated.canLoadAgain = YES;
         [_collectionView tab_startAnimation];   // 开启动画
     }
 }return _collectionView;
}
 
 -(UITableView *)tableView{
 if (!_tableView) {
     _tableView = UITableView.new;
     _tableView.backgroundColor = HEXCOLOR(0xFAFAFA);
     _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     _tableView.showsVerticalScrollIndicator = NO;
     _tableView.delegate = self;
     _tableView.dataSource = self;
     _tableView.mj_header = self.mjRefreshGifHeader;
     _tableView.mj_header.automaticallyChangeAlpha = YES;//根据拖拽比例自动切换透明度
     _tableView.mj_footer = self.mjRefreshAutoGifFooter;
     self.view.mjRefreshTargetView = _tableView;
     [self.view addSubview:_tableView];
     [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.gk_navigationBar.mas_bottom);
         make.left.right.bottom.equalTo(self.view);
     }];
     {/// 设置tabAnimated相关属性
         // 可以不进行手动初始化，将使用默认属性
         _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[MKRankTBVCell class]
                                                               cellHeight:[MKRankTBVCell cellHeightWithModel:nil]];
         _tableView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
//            [_tableView.tabAnimated addHeaderViewClass:LineTableViewHeaderFooterView.class viewHeight:60 toSection:0];
         [_tableView tab_startAnimation];   // 开启动画
     }
 }return _tableView;
}
 
 */
