//
//  ZWPullMenuView.m
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/28.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ZWPullMenuView.h"
#import "ZWPullMenuCell.h"
#import "ZWPullMenuModel.h"

#define MenuContentMargin   15
#define MenuImageWidth      30
#define MenuBorderMinMargin    10
@interface ZWPullMenuView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UIView *contentView;
/** list*/
@property (nonatomic, strong) UITableView *mTable;
/** rect*/
@property (nonatomic, assign) CGRect anchorRect;

@end
@implementation ZWPullMenuView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - config
- (void)configUI{
    [self configDefault];
    [self configTable];
}
- (void)configDefault{
    self.triangleHeight = 8;
    self.menuCellHeight = 50;
    self.menuMaxHeight = 5 * self.menuCellHeight;
    self.zwPullMenuStyle = PullMenuDarkStyle;
}
- (void)configTable{
    [self addSubview:self.contentView];
    [self.mTable registerNib:[UINib nibWithNibName:@"ZWPullMenuCell" bundle:nil]
      forCellReuseIdentifier:@"ZWPullMenuCell"];
}
#pragma mark - lifeCycle
#pragma mark - delegate
//tableviewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menuArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.menuCellHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWPullMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZWPullMenuCell"
                                                            forIndexPath:indexPath];
    ZWPullMenuModel *cellModel = self.menuArray[indexPath.row];
    cell.menuModel = cellModel;
    cell.zwPullMenuStyle = self.zwPullMenuStyle;
    cell.isFinalCell = (indexPath.row == self.menuArray.count-1);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消点击效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.blockSelectedMenu) {
        self.blockSelectedMenu(indexPath.row);
    }
    [self animateRemoveView];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self animateRemoveView];
}
#pragma mark - actionFunction
- (void)refreshUI{
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    [self addSubview:self.contentView];
    [self drawmTableFrame];
    [self.mTable reloadData];
}
#pragma mark - function
- (void)animateRemoveView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.f;
        self.contentView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        self.contentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (CGFloat)cacuateCellWidth{
    __block CGFloat maxTitleWidth = 0;
    [self.menuArray enumerateObjectsUsingBlock:^(ZWPullMenuModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = [obj.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}].width;
        if (obj.imageName.length) {
            width = width + MenuContentMargin + MenuImageWidth;
        }
        if (width>maxTitleWidth) {
            maxTitleWidth = width;
        }
    }];
    return maxTitleWidth + MenuContentMargin * 3;
}
- (void)handleMenuModelArray:(NSArray *)array{
    NSMutableArray *tempArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZWPullMenuModel *model  = [[ZWPullMenuModel alloc] init];
        model.title             = self.titleArray[idx];
        model.imageName         = self.imageArray[idx];
        [tempArray addObject:model];
    }];
    self.menuArray = tempArray;
}
#pragma mark - Private
- (void)drawmTableFrame{
    CGPoint layerAnchor = CGPointZero;
    CGPoint layerPosition = CGPointZero;
    CGFloat x = CGRectGetMidX(self.anchorRect);
    CGFloat y = 0;
    CGFloat h = self.menuArray.count * self.menuCellHeight;
    CGFloat w = [self cacuateCellWidth];
    //最大高度围栏限制
    if (h > self.menuMaxHeight) {
        h = self.menuMaxHeight;
    }
    //X中点位置：
    //居左：table右偏
    //居右：table左偏
    if (x>CGRectGetMidX(self.bounds)) {
        x = x - 3*w/4.f;
        layerAnchor.x = 1;
        layerPosition.x = x+w;
    }else{
        x = x - w/4.f;
        layerAnchor.x = 0;
        layerPosition.x = x;
    }
    //围栏
    if (x<MenuBorderMinMargin) {
        x = MenuBorderMinMargin;
        layerPosition.x = x;
    }
    if (x+w>self.bounds.size.width) {
        x = self.bounds.size.width - w - MenuBorderMinMargin;
        layerPosition.x = x+w;
    }
    //Y中心位置
    //居上：下拉
    //居下：上拉
    if (CGRectGetMidY(self.anchorRect)<CGRectGetMidY(self.bounds)) {
        y = CGRectGetMaxY(self.anchorRect);
        self.mTable.frame = CGRectMake(0, self.triangleHeight, w, h);
        layerAnchor.y = 0;
        layerPosition.y = y;
    }else{
        y = CGRectGetMinY(self.anchorRect) - self.triangleHeight - h;
        self.mTable.frame = CGRectMake(0, 0, w, h);
        layerAnchor.y = 1;
        layerPosition.y = y + h;
    }
    self.contentView.frame = CGRectMake(x, y, w, h + self.triangleHeight);
    [self drawTriangle];
    //动画锚点
    self.contentView.layer.position = layerPosition;
    self.contentView.layer.anchorPoint = layerAnchor;
}
//三角形
- (void)drawTriangle{
    CGFloat x = CGRectGetMidX(self.anchorRect) - CGRectGetMinX(self.contentView.frame);
    CGFloat y = 0;
    CGPoint p = CGPointZero;
    CGPoint q = CGPointZero;
    //围栏
    if (x < 2 * self.triangleHeight) {
        x = 2 * self.triangleHeight;
    }
    if (x > CGRectGetWidth(self.contentView.bounds) - 2 * self.triangleHeight) {
        x = CGRectGetWidth(self.contentView.bounds) - 2 * self.triangleHeight;
    }
    //Y中心位置
    //居上：下拉
    //居下：上拉
    if (CGRectGetMidY(self.anchorRect)<CGRectGetMidY(self.bounds)) {
        y = 0;
        p = CGPointMake(x+self.triangleHeight, y+self.triangleHeight);
        q = CGPointMake(x-self.triangleHeight, y+self.triangleHeight);
    }else{
        y = CGRectGetHeight(self.contentView.frame);
        p = CGPointMake(x+self.triangleHeight, y-self.triangleHeight);
        q = CGPointMake(x-self.triangleHeight, y-self.triangleHeight);
    }
    CAShapeLayer *triangleLayer = [CAShapeLayer new];
    triangleLayer.frame = self.contentView.bounds;
    triangleLayer.fillColor = self.menuBgColor.CGColor;
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(x, y)];
    [bezier addLineToPoint:p];
    [bezier addLineToPoint:q];
    bezier.lineJoinStyle = kCGLineJoinRound;
    triangleLayer.path = bezier.CGPath;
    [self.contentView.layer addSublayer:triangleLayer];
}
#pragma mark - Public
/**
 *  anchorView：下拉依赖视图[推荐初始化]
 *  箭头指向依赖视图
 *  titleArray:文字
 *  imageArray:icon
 *  menuArray:图文Model
 */
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView{
    return [self pullMenuAnchorView:anchorView titleArray:nil];
}
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView
                        titleArray:(NSArray *)titleArray{
    return [self pullMenuAnchorView:anchorView
                         titleArray:titleArray
                         imageArray:nil];
}
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView
                        titleArray:(NSArray *)titleArray
                        imageArray:(NSArray *)imageArray{
    ZWPullMenuView *menuView = [self pullMenuAnchorView:anchorView menuArray:nil];
    menuView.titleArray = titleArray;
    menuView.imageArray = imageArray;
    return menuView;
}
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView
                         menuArray:(NSArray<ZWPullMenuModel *> *)menuArray{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    ZWPullMenuView *menuView = [[ZWPullMenuView alloc] init];
    menuView.frame = [UIScreen mainScreen].bounds;
    [window addSubview:menuView];
    menuView.anchorRect = [anchorView convertRect:anchorView.bounds
                                           toView:window];
    menuView.menuArray = menuArray;
    return menuView;
}
/**
 *  anchorView：下拉依赖点
 *  箭头指向点
 *  titleArray:文字
 *  imageArray:icon
 *  menuArray:图文Model
 */
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint{
    return [self pullMenuAnchorPoint:anchorPoint titleArray:nil];
}
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint titleArray:(NSArray *)titleArray{
    return [self pullMenuAnchorPoint:anchorPoint titleArray:titleArray imageArray:nil];
}
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint
                         titleArray:(NSArray *)titleArray
                         imageArray:(NSArray *)imageArray{
    ZWPullMenuView *menuView = [self pullMenuAnchorPoint:anchorPoint menuArray:nil];
    menuView.titleArray = titleArray;
    menuView.imageArray = imageArray;
    return menuView;
}
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint
                          menuArray:(NSArray<ZWPullMenuModel *> *)menuArray{
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    ZWPullMenuView *menuView = [[ZWPullMenuView alloc] init];
    menuView.frame = [UIScreen mainScreen].bounds;
    [window addSubview:menuView];
    menuView.anchorRect = CGRectMake(anchorPoint.x, anchorPoint.y, 0, 0);
    menuView.menuArray = menuArray;
    return menuView;
}

#pragma mark - layzing
- (UITableView *)mTable{
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero
                                               style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.layer.cornerRadius = 5;
        _mTable.backgroundColor = self.menuBgColor;
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mTable;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [_contentView addSubview:self.mTable];
    }
    return _contentView;
}
-(void)setMenuArray:(NSArray<ZWPullMenuModel *> *)menuArray{
    _menuArray = menuArray;
    [self refreshUI];
}
-(void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    if (!titleArray.count) return;
    if (self.menuArray.count&&
        self.menuArray.count != titleArray.count) {
        NSLog( @"文字图片数量不匹配！");
        return;
    }
    [self handleMenuModelArray:titleArray];
}
-(void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    if (!imageArray.count) return;
    if (self.menuArray.count&&
        self.menuArray.count != imageArray.count) {
        NSLog( @"文字图片数量不匹配！");
        return;
    }
    [self handleMenuModelArray:imageArray];
}
-(void)setZwPullMenuStyle:(ZWPullMenuStyle)zwPullMenuStyle{
    _zwPullMenuStyle = zwPullMenuStyle;
    switch (zwPullMenuStyle) {
        case PullMenuDarkStyle:
        {
            self.coverBgColor = [UIColor clearColor];
            self.menuBgColor  = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        }
            break;
        case PullMenuLightStyle:
        {
            self.coverBgColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
            self.menuBgColor  = [UIColor whiteColor];
        }
            break;
        default:
            break;
    }
}
- (void)setCoverBgColor:(UIColor *)coverBgColor{
    _coverBgColor = coverBgColor;
    self.backgroundColor = self.coverBgColor;
}
- (void)setMenuBgColor:(UIColor *)menuBgColor{
    _menuBgColor = menuBgColor;
    self.mTable.backgroundColor = self.menuBgColor;
    [self refreshUI];
}
-(void)setAnchorRect:(CGRect)anchorRect{
    _anchorRect = anchorRect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
