//
//  MainTitleStyleVC.h
//  GPClottery
//
//  Created by ___hxs___ on 2017/4/17.
//  Copyright © 2017年 IMAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol titleStyleClickDelegate<NSObject>
@optional
/** 监听顶部按钮点击,滚动结束也会调用 */
-(void)clickBtn:(NSInteger)index;
/** 横屏状态返回按钮点击 */
-(void)backBtnClick;
@end;

@interface MainTitleStyleVC : UIViewController

@property(nonatomic,assign) id<titleStyleClickDelegate>delegate;
/** 设置内容titleView的Y值 默认为0 */
@property (nonatomic, assign) NSInteger titleViewY;
/** 设置内容ScrollView向下偏移量 默认为0 */
@property (nonatomic, assign) NSInteger offsetY;
/** 是否需要预加载 默认为NO 一次性加载所有页面*/
@property (nonatomic, assign) BOOL isPreloading;
/** 是否显示横屏返回按钮*/
@property (nonatomic, assign) BOOL isShowBackBtn;

//当前所在的目录
- (NSInteger)getCurrentIndex;

- (void)setup;

/** 是否需要向右的箭头 默认为NO*/
@property (nonatomic, assign) BOOL isHaveArrow;
/** 设置字体   默认14*/
@property (nonatomic, strong) UIFont *titleFont;
/** 标签栏颜色 默认白色*/
@property (nonatomic, strong) UIColor *titleScrollViewColor;
/** 底部指示器颜色 默认 kMainThemeColor*/
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** 默认字体颜色 默认 kNGDBlackFontColor*/
@property (nonatomic, strong) UIColor *titleColorDefaul;
/** 选中字体颜色 默认 kNGDBlackFontColor*/
@property (nonatomic, strong) UIColor *titleColorSelect;

@end
