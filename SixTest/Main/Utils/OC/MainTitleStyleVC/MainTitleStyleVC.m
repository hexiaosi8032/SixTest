//
//  MainTitleStyleVC.m
//  GPClottery
//
//  Created by ___hxs___ on 2017/4/17.
//  Copyright © 2017年 IMAC. All rights reserved.
//

#import "MainTitleStyleVC.h"
#import "UIView+Frame.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define SizeWidthScale ScreenWidth / 375
#define SizeHeightScale ScreenHeight / 667

#define scaleX(x) (x)*SizeWidthScale
#define scaleY(y) (y)*SizeHeightScale

#define adoptedFont(font) [UIFont systemFontOfSize:(font) * SizeWidthScale]

@interface MainTitleStyleVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *titleView;
/** 底部的所有内容 */
@property (nonatomic, strong) UIScrollView *contentView;
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/* 是否初始化 */
@property (nonatomic, assign) BOOL isInitial;
/** 记录是否点击 */
@property (nonatomic, assign) BOOL isClickTitle;
/** 记录是否在动画 */
@property (nonatomic, assign) BOOL isAniming;
/** 顶部的所有标签 */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/** 向右的箭头 */
@property (nonatomic, strong) UIImageView *rowImageView;
/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;
/** 记录是否加载了所有视图 */
@property (nonatomic, assign) BOOL isLoadingAllView;
/** 横屏返回的按钮 */
@property (nonatomic, strong) UIButton *backBtn;
@end

@implementation MainTitleStyleVC

- (void)setup{
    [self viewWillAppear:YES];
}

#pragma mark - 懒加载
- (UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc]init];
        _titleView.backgroundColor = self.titleScrollViewColor;
        [self.view addSubview:_titleView];
    }
    return _titleView;
    
}

- (UIScrollView *)titleScrollView{
    if(!_titleScrollView){
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.backgroundColor = self.titleScrollViewColor;
        [self.titleView addSubview:_titleScrollView];
    }
    return _titleScrollView;
    
}

- (UIScrollView *)contentView{
    if(!_contentView){
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.delegate = self;
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
    }
    return _contentView;
    
}

- (UIImageView *)rowImageView{
    if(!_rowImageView){
        _rowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"可滑动箭头"]];
        CGFloat y = (self.titleView.height - _rowImageView.image.size.height) / 2;
        _rowImageView.frame = CGRectMake(self.titleView.width - _rowImageView.image.size.width - scaleX(5), y,_rowImageView.image.size.width, _rowImageView.image.size.height);
        [self.titleView addSubview:_rowImageView];
    }
    return _rowImageView;
}

- (UIButton *)backBtn{
    if(!_backBtn){
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:0];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        _backBtn.frame = CGRectMake(10, 0, 40, self.titleView.height);
        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [self.titleView addSubview:_backBtn];
    }
    return _backBtn;
}


- (UIFont *)titleFont{
    if (_titleFont == nil) {
        _titleFont = adoptedFont(14);
    }
    return _titleFont;
}

- (UIColor *)titleScrollViewColor{
    if (!_titleScrollViewColor) {
        _titleScrollViewColor = [UIColor whiteColor];
    }
    return _titleScrollViewColor;
}

- (UIColor *)indicatorViewColor{
    if (!_indicatorViewColor) {
        _indicatorViewColor = [UIColor redColor];
    }
    return _indicatorViewColor;
}

- (UIColor *)titleColorDefaul{
    if (!_titleColorDefaul) {
        _titleColorDefaul = [UIColor darkGrayColor];
    }
    return _titleColorDefaul;
}

- (UIColor *)titleColorSelect{
    if (!_titleColorSelect) {
        _titleColorSelect = [UIColor darkGrayColor];
    }
    return _titleColorSelect;
}

#pragma mark - 初始化和生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.isInitial == NO) {
        
        // 没有子控制器，不需要设置标题
        if (self.childViewControllers.count == 0) return;
        
        self.titleView.frame = CGRectMake(0, self.titleViewY, self.view.width, 44);
        self.titleScrollView.frame = CGRectMake(0, 0, self.view.width, 44);
        CGFloat y = CGRectGetMaxY(self.titleView.frame);
        self.contentView.frame = CGRectMake(0, y + self.offsetY, self.view.width, self.view.height - y - self.offsetY);
        //1个控制器 隐藏顶部标签栏
        self.titleView.hidden = self.childViewControllers.count == 1;
        
        if (self.isShowBackBtn) {
            self.titleScrollView.frame = CGRectMake(0, 0, self.view.width - 40, 44);
        }
        // 设置顶部的标签栏
        [self setuptitleScrollView];
        // 添加第一个控制器的view
        [self scrollViewDidEndScrollingAnimation:self.contentView];
        
        [self.titleView bringSubviewToFront:self.backBtn];
        self.backBtn.hidden   = !self.isShowBackBtn;
        
        self.isInitial = YES;
    }
    
}

#pragma mark - 自定义方法
/** 设置顶部的标签栏 */
- (void)setuptitleScrollView{
    
    if (self.childViewControllers.count > 5 && self.isHaveArrow) {
        [self rowImageView];
    }
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = self.indicatorViewColor;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = self.titleScrollView.height - indicatorView.height - 4;
    self.indicatorView = indicatorView;
    
    CGFloat btnCount = self.childViewControllers.count;
    NSInteger count = self.childViewControllers.count > 6? 5 : self.childViewControllers.count;
    if (self.isShowBackBtn) count = self.childViewControllers.count + 1;
    
    // 内部的子标签
    CGFloat width = self.titleScrollView.width / count;
    CGFloat height = self.titleScrollView.height;
    
    for (NSInteger i = 0; i< btnCount; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:self.titleColorDefaul forState:UIControlStateNormal];
        [button setTitleColor:self.titleColorSelect forState:UIControlStateDisabled];
        button.titleLabel.font =  self.titleFont;
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleScrollView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            //            self.indicatorView.width = width - scaleX(20);
            self.indicatorView.width = button.titleLabel.width + scaleX(20);
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [self.titleScrollView addSubview:indicatorView];
    // 设置contentSize
    self.titleScrollView.contentSize = CGSizeMake(btnCount * width, 0);
    self.contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    
}

//添加子控制器
- (void)setupOneViewController:(UIScrollView *)scrollView{
    // 当前的索引
    NSInteger index = self.contentView.contentOffset.x / self.contentView.width;
    
    if (self.isPreloading) {
        // 取出子控制器
        UIViewController *vc = self.childViewControllers[index];
        //添加过了就不再添加
        if (!vc.view.superview) {
            vc.view.x = index * self.view.width;
            vc.view.y = 0;
            vc.view.height = scrollView.height;
            [scrollView addSubview:vc.view];
        }
        
    }else{
        if (!self.isLoadingAllView) {
            for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
                UIViewController *vc = self.childViewControllers[i];
                if (!vc.view.superview) {
                    vc.view.x = i * ScreenWidth;
                    vc.view.y = 0;
                    vc.view.height = scrollView.height;
                    [scrollView addSubview:vc.view];
                }
                
            }
            self.isLoadingAllView = YES;
        }
    }
    
    // 让对应的顶部标题居中显示
    CGFloat width = self.titleScrollView.width;
    UIButton *btn = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    titleOffset.x = btn.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) {
        if (self.childViewControllers.count > 5 && self.isHaveArrow) {
            self.rowImageView.hidden = YES;
        }
        titleOffset.x = maxTitleOffsetX;
    }else{
        if (self.childViewControllers.count > 5 && self.isHaveArrow) {
            self.rowImageView.hidden = NO;
        }
    }
    
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
}

#pragma mark - Target方法
- (void)titleClick:(UIButton *)button{
    
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    _lastOffsetX = button.tag * self.view.width;
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    //代理通知
    if ([self.delegate respondsToSelector:@selector(clickBtn:)]) {
        [self.delegate clickBtn:button.tag];
    }
    
    _isClickTitle = YES;
    
}

- (void)back{
    //代理通知
    if ([self.delegate respondsToSelector:@selector(backBtnClick)]) {
        [self.delegate backBtnClick];
    }
}

#pragma mark - 代理和协议
#pragma mark - <UIScrollViewDelegate>
//点击标题滚动完成
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self setupOneViewController:scrollView];
    // 监听点击标题滚动动画是否完成
    _isClickTitle = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self setupOneViewController:self.contentView];
    // 点击按钮
    NSInteger index = self.contentView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleScrollView.subviews[index]];
    
    _isClickTitle = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // 点击和动画的时候不需要设置
    if (_isClickTitle == YES) return;
    
    if (scrollView == self.contentView ) {
        // 获取偏移量
        CGFloat offsetX = self.contentView.contentOffset.x;
        
        CGFloat scale = offsetX / self.contentView.frame.size.width;
        if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
        
        // 获得需要操作的左边button
        NSInteger leftIndex = scale;
        UIButton *leftButton = self.titleScrollView.subviews[leftIndex];
        
        // 获得需要操作的右边button
        NSInteger rightIndex = leftIndex + 1;
        UIButton *rightButton = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
        // 获取两个标题中心点距离
        CGFloat centerDelta = rightButton.frame.origin.x - leftButton.frame.origin.x;
        
        // 获取移动距离
        CGFloat offsetDelta = offsetX - _lastOffsetX;
        
        // 计算当前下划线偏移量
        CGFloat underLineTransformX = offsetDelta * centerDelta / self.view.width;
        
        self.indicatorView.x += underLineTransformX;
        // 记录上一次的偏移量
        _lastOffsetX = offsetX;
    }
    
}

- (NSInteger)getCurrentIndex{
    return self.contentView.contentOffset.x / self.contentView.width;
}

@end
