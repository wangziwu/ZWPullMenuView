//
//  ZWPullMenuModel.h
//  ZWPullMenuDemo
//
//  Created by 王子武 on 2017/8/28.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, ZWPullMenuStyle) {
    PullMenuDarkStyle = 0,  //类微信、黑底白字
    PullMenuLightStyle      //类支付宝、白底黑字
};
@interface ZWPullMenuModel : NSObject
/** 
 * 文字
 */
@property (nonatomic, copy) NSString *title;
/** 
 * 图片
 */
@property (nonatomic, copy) NSString *imageName;
@end
