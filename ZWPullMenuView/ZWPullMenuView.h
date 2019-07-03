//
//  ZWPullMenuView.h
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/28.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWPullMenuModel.h"
#import "ZWPullMenuConfig.h"
NS_ASSUME_NONNULL_BEGIN
//selected
typedef void(^BlockSelectedMenu)(NSInteger menuRow);
@interface ZWPullMenuView : UIView
/**
 *  文字
 */
@property (nonatomic, copy) NSArray *titleArray;
/**
 *  图片
 */
@property (nonatomic, copy) NSArray *imageArray;
/** 
 *  图文Model
 */
@property (nonatomic, copy) NSArray<ZWPullMenuModel *> *menuArray;
/**
 *  相关配置
 */
@property (nonatomic, strong) ZWPullMenuConfig *zw_menuConfg;
/**
 *  蒙层背景color
 */
@property (nonatomic, strong) UIColor *coverBgColor;
/**
 *  主样式color
 */
@property (nonatomic, strong) UIColor *menuBgColor;
/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 *  cel高度
 */
@property (nonatomic, assign) CGFloat menuCellHeight;
/**
 *  table最大高度限制
 *  默认：5 * cellHeight
 */
@property (nonatomic, assign) CGFloat menuMaxHeight;
/** 
 *  小三角高度
 *  45°等腰三角形
 */
@property (nonatomic, assign) CGFloat triangleHeight;
/**
 *  调整使下拉优先 当向下偏转屏幕距离足够，优先向下偏转
 */
@property (nonatomic, assign) BOOL zw_adjustPullDown;
/** 
 *  pullMenu样式
 */
@property (nonatomic, assign) ZWPullMenuStyle zwPullMenuStyle;
/**
 *  click
 */
@property (nonatomic, copy) BlockSelectedMenu blockSelectedMenu;
/**
 *  anchorView：下拉依赖视图[推荐初始化]
 *  箭头指向依赖视图
 *  titleArray:文字
 *  imageArray:icon
 *  menuArray:图文Model
 */
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView;
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView titleArray:(nullable NSArray *)titleArray;
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView titleArray:(nullable NSArray *)titleArray imageArray:(nullable NSArray *)imageArray;
+ (instancetype)pullMenuAnchorView:(UIView *)anchorView menuArray:(nullable NSArray<ZWPullMenuModel *> *)menuArray;

/**
 *  anchorView：下拉依赖绝对坐标
 *  指定坐标下拉
 *  箭头指向点
 *  titleArray:文字
 *  imageArray:icon
 *  menuArray:图文Model
 */
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint;
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint titleArray:(nullable NSArray *)titleArray;
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint titleArray:(nullable NSArray *)titleArray imageArray:(nullable NSArray *)imageArray;
+ (instancetype)pullMenuAnchorPoint:(CGPoint)anchorPoint menuArray:(nullable NSArray<ZWPullMenuModel *> *)menuArray;
@end
NS_ASSUME_NONNULL_END
