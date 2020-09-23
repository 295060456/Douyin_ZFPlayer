//
//  ViewController@1.m
//  My_BaseProj
//
//  Created by Administrator on 04/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "ViewController@1.h"
#import "PlayerCell.h"

@interface ViewController_1 ()
<
UITableViewDelegate,
UITableViewDataSource
>{

}

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController_1

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = KBrownColor;
    self.tableView.alpha = 1;
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayerCell *cell = [PlayerCell cellWith:tableView];
    [cell richElementsInCellWithModel:@{
        @"index":@(indexPath.row)
    }];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = kRedColor;
        _tableView.pagingEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = 0;
        _tableView.mj_header = self.tableViewHeader;
        @weakify(self)
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
//            [self loadMore];
        }];
        [footer setTitle:@"没有更多视频" forState:MJRefreshStateNoMoreData];
        footer.stateLabel.textColor = KGreenColor;
        _tableView.mj_footer = footer;
        _tableView.mj_footer.hidden = NO;
        _tableView.tableFooterView = UIView.new;

        [self.view addSubview:_tableView];
        extern CGFloat LZB_TABBAR_HEIGHT;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _tableView;
}

@end
