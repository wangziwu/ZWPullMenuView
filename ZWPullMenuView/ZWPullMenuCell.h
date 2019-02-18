//
//  ZWPullMenuCell.h
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/30.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWPullMenuModel.h"
#import "ZWPullMenuConfig.h"
NS_ASSUME_NONNULL_BEGIN
@interface ZWPullMenuCell : UITableViewCell
@property (strong, nonatomic) UIImageView *menuImageView;
@property (strong, nonatomic) UILabel *menuTitleLab;
/** 
 *  model
 */
@property (nonatomic, strong) ZWPullMenuModel *menuModel;
/**
 *  相关配置
 */
@property (nonatomic, strong) ZWPullMenuConfig *zw_menuConfg;
/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;
/** 
 * 最后一栏cell
 */
@property (nonatomic, assign) BOOL isFinalCell;
/**
 *  pullMenu样式
 */
@property (nonatomic, assign) ZWPullMenuStyle zwPullMenuStyle;

@end
NS_ASSUME_NONNULL_END
