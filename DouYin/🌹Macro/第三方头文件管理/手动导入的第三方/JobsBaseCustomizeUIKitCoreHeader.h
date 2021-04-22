//
//  JobsBaseCustomizeUIKitCoreHeader.h
//  JobsBaseCustomizeUIKit
//
//  Created by Jobs on 2021/4/19.
//

#ifndef JobsBaseCustomizeUIKitCoreHeader_h
#define JobsBaseCustomizeUIKitCoreHeader_h

#pragma mark —— BaseProtocol
#import "BaseViewControllerProtocol.h"
#import "BaseCellProtocol.h"
#import "BaseViewProtocol.h"

#pragma mark —— CALayer
/// CALayer+Transition
#import "CALayer+Transition.h"
/// CALayer+Anim
#import "CALayer+Anim.h"

#pragma mark —— DebugLogDescription
#import "DebugLogDescription.h"

#pragma mark —— NSArray
#import "NSArray+Extend.h"
#import "NSArray+Extension.h"

#pragma mark —— NSObject
/// NSObject+Alert
#import "NSObject+SPAlertController.h"
#import "NSObject+SYSAlertController.h"
/// NSObject+Others
#import "NSObject+AFNReachability.h"
#import "NSObject+Extras.h"
#import "NSObject+Measure.h"
#import "NSObject+OpenURL.h"
#import "NSObject+Random.h"
#import "NSObject+RichText.h"
#import "NSObject+Shake.h"
#import "NSObject+Sound.h"
///【对FileFolderHandleTool的二次封装】 存数据，储存成功返回地址
#import "NSObject+DataSave.h"
/// 时间相关方法
#import "NSObject+Time.h"
/// 时间相关模型
#import "TimeModel.h"
/// 线程定义
#import "NSObject+DefConfig.h"
/// 万物回调
#import "NSObject+CallBackInfoByBlock.h"
/// 万物数据绑定
#import "NSObject+DataBinding.h"

#pragma mark —— NSString
#import "NSString+Extras.h"

#pragma mark —— RedefineSys
#import "DeleteSystemUITabBarButton.h"

#pragma mark —— UIButton
/// 高度自定义的按钮
#import "UIButton+ImageTitleSpacing.h"
/// 高仿抖音点赞动画
#import "RBCLikeButton.h"
/// 计时按钮
#import "UIButton+Timer.h"
/// 按键音按钮
#import "SoundBtn.h"
/// 高仿iOS长按删除+抖动
#import "LGiOSBtn.h"

#pragma mark —— UICollectionReusableView 用作基类
#import "BaseCollectionReusableView.h"

#pragma mark —— UICollectionView
#import "BaseCollectionView.h"
#import "UICollectionView+RegisterClass.h"

#pragma mark —— UICollectionViewCell
/// UICollectionViewCell+Category
#import "UICollectionViewCell+ShakeAnimation.h"
#import "UICollectionViewCell+Default.h"
/// BaseCollectionViewCell
#import "BaseCollectionViewCell.h"

#pragma mark —— UICollectionViewFlowLayout
/// BaseCollectionViewFlowLayout
#import "LMHWaterFallLayout.h"
#import "KFZShopCatoryFlowLayput.h"// 给UICollectionView每个section加背景
#import "HQCollectionViewFlowLayout.h"// UICollectionView 实现类似于UITableView的悬停效果

#pragma mark —— UIColor
/// UIColor+Category
#import "UIColor+Gradient.h"
#import "UIColor+Hex.h"

#pragma mark —— UIControl
/// UIControl+Category
#import "UIControl+XY.h"

#pragma mark —— UIDevice
/// UIDevice+Category
#import "UIDevice+XMUtils.h"

#pragma mark —— UIFont
/// UIFont+Category
#import "UIFont+Extras.h"

#pragma mark —— UIImage
#import "LoadingImage.h"
/// UIImage+Category
#import "UIImage+Extras.h"
#import "UIImage+Overlay.h"
#import "UIImage+ScreenShot.h"
#import "UIImage+SYS.h"
#import "UIImage+Tailor.h"
#import "UIImage+YBGIF.h"

#pragma mark —— UIImageView
/// BaseImageView
#import "BaseImageView.h"
///UIImageView+Category
#import "UIImageView+GIF.h"

#pragma mark —— UILabel
/// UILabel+Category
#import "UILabel+Extra.h"
#import "UILabel+Gesture.h"

#pragma mark —— UINavigationBar
#import "BaseNavigationBar.h"

#pragma mark —— UINavigationController
#import "BaseNavigationVC.h"

#pragma mark —— UITableView
/// BaseTableView
#import "BaseTableView.h"
/// UITableView+Category
#import "UITableView+Expand.h"
// TableViewAnimationKit
#import "TableViewAnimationKit.h"
#import "TableViewAnimationKitConfig.h"
#import "TableViewAnimationKitHeaders.h"
#import "UITableView+XSAnimationKit.h"
// UITableView 折叠功能
#import "UITableView+WWFoldableTableView.h"

#pragma mark —— UITableViewCell
/// UITableViewCell+Category
// 重设边距
#import "UITableViewCell+Margin.h"
// 自定义右侧小箭头图标
#import "UITableViewCell+WhiteArrows.h"
/// BaseTableViewCell
#import "BaseTableViewCell.h"

#pragma mark —— UITableViewHeaderFooterView
/// BaseTableViewHeaderFooterView
#import "TableViewFooterView.h"
#import "TableViewHeaderView.h"

#pragma mark —— UITextField
/// BaseTextField
#import "CJTextField.h"
#import "HQTextField.h"
#import "JobsMagicTextField.h"
#import "ZYTextField.h"
#import "ZYTextField+HistoryDataList.h"
/// UITextField+Category
#import "UITextField+Extend.h"

#pragma mark —— UITextView
/// UITextView+Category
#import "UITextView+Extend.h"
#import "UITextView+IndicateWordLimit.h"

#pragma mark —— UIView
/// BaseView
#import "BaseView.h"
/// UIView+Category
#import "UIView+Animation.h"
#import "UIView+AOP.h"
#import "UIView+BackgroundImage.h"
#import "UIView+Chain.h"
#import "UIView+EmptyData.h"
#import "UIView+Extras.h"
#import "UIView+Gesture.h"
#import "UIView+Gradient.h"
#import "UIView+JHGestureBlock.h"
#import "UIView+Measure.h"
#import "UIView+MJRefresh.h"
#import "UIView+SuspendView.h"
#import "UIView+ViewController.h"
#import "UIView+ZFPlayer.h"

#pragma mark —— UIViewController
/// BaseViewController
#import "BaseViewController.h"
/// UIViewController+Category
// UIViewController+JXCategory
#import "UIViewController+JXCategoryListContentViewDelegate.h"
#import "UIViewController+JXPagerViewListViewDelegate.h"
// UIViewController+XLBubbleTransition
#import "UIViewController+XLBubbleTransition.h"
#import "XLBubbleTransition.h"
// UIViewController+MJRefresh
#import "UIViewController+MJRefresh.h"
#import "MJRefreshConfigModel.h"
#import "LOTAnimationMJRefreshFooter.h"
#import "LOTAnimationMJRefreshHeader.h"
// UIViewController+Others
#import "UIViewController+BWShareView.h"
#import "UIViewController+JPImageresizerView.h"
#import "UIViewController+BackBtn.h"
#import "UIViewController+EmptyData.h"
#import "UIViewController+Shake.h"
#import "UIViewController+BaseVC.h"
#import "UIViewController+GifImageView.h"
#import "UIViewController+BaseNavigationBar.h"
#import "UIViewController+BRPickerView.h"

#endif /* JobsBaseCustomizeUIKitCoreHeader_h */
