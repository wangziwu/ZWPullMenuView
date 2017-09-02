//
//  ZWPullMenuCell.h
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/30.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWPullMenuModel.h"
@interface ZWPullMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLab;
/** 
 *  model
 */
@property (nonatomic, strong) ZWPullMenuModel *menuModel;
/** 
 * 最后一栏cell
 */
@property (nonatomic, assign) BOOL isFinalCell;
/**
 *  pullMenu样式
 */
@property (nonatomic, assign) ZWPullMenuStyle zwPullMenuStyle;

@end
