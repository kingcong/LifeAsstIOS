//
//  CWNewfeatureViewController.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/6.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWNewfeatureViewController.h"
#import "LALoginController.h"
#define CWNewFeatureCount 4
@interface CWNewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak)UIScrollView * scrollView;

@property (nonatomic,weak)UIPageControl * pageControl;

@end

@implementation CWNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    [self addScrollView];
    
    [self addPageControl];
}

/**
 *  添加scrollView
 */
- (void)addScrollView
{
    
    // 1.初始化scrollView
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    
    scrollView.frame = self.view.bounds;
    
    scrollView.backgroundColor = [UIColor redColor];
    
    scrollView.contentSize = CGSizeMake(CWNewFeatureCount * self.view.width, 0);
    
    [self.view addSubview:scrollView];
    
    scrollView.delegate = self;
    
    self.scrollView = scrollView;
    
    
    // 2.设置scrollView的一些基本属性
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.bounces = NO;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    [self addImageToScrollView];
}

// 把图片添加到scrollView上
- (void)addImageToScrollView
{
    
    for (int i = 0; i < CWNewFeatureCount; i++)
    {
        // 添加imageView并设置Frame
        UIImageView * imageView = [[UIImageView alloc] init];
        
        CGFloat imageY = 0;
        CGFloat imageW = self.view.width;
        CGFloat imageH = self.view.height;
        CGFloat imageX = imageW * i;
        
        // 设置图片
        NSString * imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        [self.scrollView addSubview:imageView];
        
        if (i == CWNewFeatureCount - 1)
        {
            [self setupLastImageView:imageView];
        }
    }
}


// 设置最后一个image的内容
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self addStartButton:imageView];
    
    
    // 2.添加分享按钮
    [self addShareButton:imageView];
}


// 1.添加开始按钮
- (void)addStartButton:(UIImageView *)imageView
{
    // 1.创建Button
    UIButton * start = [[UIButton alloc] init];
    [imageView addSubview:start];
    
    // 2.设置背景
    [start setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [start setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置Frame
    start.size = start.currentBackgroundImage.size;
    start.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.8);
    
    // 4.设置文字
    [start setTitle:@"开始微博" forState:UIControlStateNormal];
    [start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startWeibo) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startWeibo
{
    CWLog(@"开始微博");
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    LALoginController * tabBar = [[LALoginController alloc] init];
    
    window.rootViewController = tabBar;
}

// 2.添加分享按钮
- (void)addShareButton:(UIImageView *)imageView
{
    // 1.初始化Button
    UIButton * shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置Frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.7);
    
    // 4.设置间距
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}

- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
}

#pragma mark -- 实现scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat doublePage = scrollView.contentOffset.x / self.view.width;
    
    int intPage = (int)(doublePage + 0.5);
    
    self.pageControl.currentPage = intPage;
    
}


/**
 *  添加pageControl
 */
- (void)addPageControl
{
    // 初始化pageControl
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height - 30);
    
    pageControl.numberOfPages = CWNewFeatureCount;
    
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
}

@end
