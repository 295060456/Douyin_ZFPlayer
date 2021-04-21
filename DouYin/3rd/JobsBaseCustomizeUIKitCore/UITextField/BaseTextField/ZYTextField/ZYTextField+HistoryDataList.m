//
//  ZYTextField+HistoryDataList.m
//  TFRememberHistoryInputContentWithDropList
//
//  Created by Jobs on 2020/9/17.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ZYTextField+HistoryDataList.h"
#import "TableViewAnimationKitHeaders.h"

@interface HistoryDataListTBVCell : UITableViewCell

@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton *delBtn;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)CGFloat cellWidth;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)MKDataBlock historyDataListTBVCellBlock;

@end

@implementation HistoryDataListTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    HistoryDataListTBVCell *cell = (HistoryDataListTBVCell *)[tableView dequeueReusableCellWithIdentifier:@"InfoTBVCell"];
    if (!cell) {
        cell = [[HistoryDataListTBVCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                            reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = HEXCOLOR(0x242A37);
    }return cell;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.delBtn.alpha = 1;
    self.contentLabel.alpha = 1;
    if ([model isKindOfClass:NSString.class]) {
        self.contentLabel.text = (NSString *)model;
    }
}
///删除按钮 点击事件回调
-(void)actionBlockHistoryDataListTBVCell:(MKDataBlock _Nullable)historyDataListTBVCellBlock{
    _historyDataListTBVCellBlock = historyDataListTBVCellBlock;
}
#pragma mark —— lazyLoad
-(UIButton *)delBtn{
    if (!_delBtn) {
        _delBtn = UIButton.new;
        [_delBtn setImage:KBuddleIMG(nil,
                                     @"ZYTextField",
                                     nil,
                                     @"登录注册关闭")
                 forState:UIControlStateNormal];
        [_delBtn setImage:KBuddleIMG(nil,
                                     @"ZYTextField",
                                     nil,
                                     @"登录注册关闭")
                 forState:UIControlStateSelected];
        @weakify(self)
        [[_delBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            //点击删除
            if (self.historyDataListTBVCellBlock) {
                self.historyDataListTBVCellBlock(@(self.index));
            }
        }];
        [self.contentView addSubview:_delBtn];
        [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.cellWidth * 0.3, self.cellHeight));
            make.centerY.right.equalTo(self.contentView);
        }];
    }return _delBtn;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = UILabel.new;
        _contentLabel.backgroundColor = kClearColor;
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(self);
            make.right.equalTo(self.delBtn.mas_left);
        }];
    }return _contentLabel;
}

@end

@implementation ZYTextField (HistoryDataList)

static char *ZYTextField_HistoryDataList_tableview = "ZYTextField_HistoryDataList_tableview";
static char *ZYTextField_HistoryDataList_isSelected = "ZYTextField_HistoryDataList_isSelected";
static char *ZYTextField_HistoryDataList_tableviewCellHeight = "ZYTextField_HistoryDataList_tableviewCellHeight";
static char *ZYTextField_HistoryDataList_isShowHistoryDataList = "ZYTextField_HistoryDataList_isShowHistoryDataList";
static char *ZYTextField_HistoryDataList_ZYTextFieldTapGR = "ZYTextField_HistoryDataList_ZYTextFieldTapGR";
static char *ZYTextField_HistoryDataList_dataMutArr = "ZYTextField_HistoryDataList_dataMutArr";

@dynamic tableview;
@dynamic isSelected;
@dynamic tableviewCellHeight;
@dynamic isShowHistoryDataList;
@dynamic ZYTextFieldTapGR;
@dynamic dataMutArr;

-(void)closeList{
    [self endEditing:YES];
    self.isSelected = NO;
}

-(void)ZYTextFieldTap:(UITapGestureRecognizer *)tapGR{
    self.isSelected = !self.isSelected;
    self.isShowHistoryDataList = self.isSelected;
    [self.tableview removeFromSuperview];
    self.tableview = nil;
    self.tableview.alpha = self.isShowHistoryDataList;
    [self.tableview reloadData];
    [TableViewAnimationKit showWithAnimationType:2
                                       tableView:self.tableview];
}
#pragma mark —— UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return true;//不遵守此协议，输入框无法输入
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableviewCellHeight;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" 你点击了我");
    self.text = self.dataMutArr[indexPath.row];
    [self closeList];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;//
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDataListTBVCell *cell = [HistoryDataListTBVCell cellWithTableView:tableView];
    cell.cellHeight = self.tableviewCellHeight;
    cell.cellWidth = self.width;
    cell.index = indexPath.row;
    cell.contentView.backgroundColor = RandomColor;
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    @weakify(self)
    [cell actionBlockHistoryDataListTBVCell:^(NSNumber *data) {
        @strongify(self)
        //点击按钮删除数据：1、刷新内存的数据并且刷新界面；2、删除本地化的数据
        [self.dataMutArr removeObjectAtIndex:data.intValue];
        
        UserDefaultModel *userDefaultModel = UserDefaultModel.new;
        userDefaultModel.key = @"dataMutArr";
        userDefaultModel.obj = self.dataMutArr;
        
        [UserDefaultManager storedData:userDefaultModel];
        
        [self.tableview removeFromSuperview];
        self.tableview = nil;
        [self.tableview reloadData];
    }];return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray *dataMutArr;
-(NSMutableArray *)dataMutArr{
    NSMutableArray *DataMutArr = objc_getAssociatedObject(self, ZYTextField_HistoryDataList_dataMutArr);
    if (!DataMutArr) {
        DataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_dataMutArr,
                                 DataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return DataMutArr;
}

-(void)setDataMutArr:(NSMutableArray *)dataMutArr{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_dataMutArr,
                             dataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UITapGestureRecognizer *ZYTextFieldTapGR;
-(UITapGestureRecognizer *)ZYTextFieldTapGR{
    UITapGestureRecognizer *textFieldTapGR = objc_getAssociatedObject(self, ZYTextField_HistoryDataList_ZYTextFieldTapGR);
    if (!textFieldTapGR) {
        textFieldTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(ZYTextFieldTap:)];
        textFieldTapGR.delegate = self;
        textFieldTapGR.numberOfTapsRequired = 1;//tap次数
        textFieldTapGR.numberOfTouchesRequired = 1;//手指数
        [self addGestureRecognizer:textFieldTapGR];
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_ZYTextFieldTapGR,
                                 textFieldTapGR,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return textFieldTapGR;
}

-(void)setZYTextFieldTapGR:(UITapGestureRecognizer *)ZYTextFieldTapGR{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_ZYTextFieldTapGR,
                             ZYTextFieldTapGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark —— @property(nonatomic,strong)UITableView *tableview;
-(UITableView *)tableview{
    UITableView *Tableview = objc_getAssociatedObject(self, ZYTextField_HistoryDataList_tableview);
    if (!Tableview) {
        Tableview = UITableView.new;
        Tableview.backgroundColor = kClearColor;
        Tableview.delegate = self;
        Tableview.dataSource = self;
        [self.superview addSubview:Tableview];
        [Tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(self.dataMutArr.count * self.tableviewCellHeight);
        }];
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_tableview,
                                 Tableview,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Tableview;
}

-(void)setTableview:(UITableView *)tableview{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_tableview,
                             tableview,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BOOL isSelected;
-(void)setIsSelected:(BOOL)isSelected{
    self.isShowHistoryDataList = !isSelected;
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_isSelected,
                             [NSNumber numberWithBool:isSelected],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)isSelected{
    return [objc_getAssociatedObject(self, ZYTextField_HistoryDataList_isSelected) boolValue];
}
#pragma mark —— @property(nonatomic,assign)CGFloat tableviewCellHeight;
-(CGFloat)tableviewCellHeight{
    CGFloat TableviewCellHeight = [objc_getAssociatedObject(self, ZYTextField_HistoryDataList_tableviewCellHeight) floatValue];
    if (TableviewCellHeight == 0) {
        TableviewCellHeight = 50;
        objc_setAssociatedObject(self,
                                 ZYTextField_HistoryDataList_tableviewCellHeight,
                                 [NSNumber numberWithFloat:TableviewCellHeight],
                                 OBJC_ASSOCIATION_ASSIGN);
    }return TableviewCellHeight;
}

-(void)setTableviewCellHeight:(CGFloat)tableviewCellHeight{
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_tableviewCellHeight,
                             [NSNumber numberWithFloat:tableviewCellHeight],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)BOOL isShowHistoryDataList;//是否显示下拉历史数据列表
-(BOOL)isShowHistoryDataList{
    return [objc_getAssociatedObject(self, ZYTextField_HistoryDataList_isShowHistoryDataList) boolValue];
}

-(void)setIsShowHistoryDataList:(BOOL)isShowHistoryDataList{
    self.tableview.alpha = !isShowHistoryDataList;
    objc_setAssociatedObject(self,
                             ZYTextField_HistoryDataList_isShowHistoryDataList,
                             [NSNumber numberWithBool:isShowHistoryDataList],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
