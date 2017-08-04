//
//  UIView+Frame.h
//  GPCLottery
//
//  Created by ___hxs___ on 2017/4/12.
//  Copyright © 2017年 小四. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
- (UIView *)getParsentView:(UIView *)view;
- (NSMutableAttributedString *)addLineSpacing:(NSString *)title lineSize:(CGFloat)lineSize;
- (NSMutableAttributedString *)addContent:(NSString *)title changeTitle:(NSString *)changeTitle changeTitleColor:(UIColor *)changeTitleColor;
- (void)addAttribute:(NSMutableAttributedString*)attStr ContentColor:(NSString *)title changeTitle:(NSString *)changeTitle changeTitleColor:(UIColor *)changeTitleColor;
- (void)addTopLine:(UIColor *)color lineHeight:(CGFloat)lineHeight;
- (void)addRightLine:(UIColor *)color lineHeight:(CGFloat)lineHeight;
- (void)addBottomLine:(UIColor *)color lineHeight:(CGFloat)lineHeight;
- (void)addLine:(CGFloat)y color:(UIColor *)color lineHeight:(CGFloat)lineHeight;
- (void)addLineView:(CGFloat)y height:(CGFloat)height;
@end
