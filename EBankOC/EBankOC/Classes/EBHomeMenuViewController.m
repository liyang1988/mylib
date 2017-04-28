//
//  EBHomeMenuViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/11.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBHomeMenuViewController.h"
#import "IconView.h"
#import "EBChangPwdViewController.h"
#import "EBWorkTypeTableViewController.h"
@interface EBHomeMenuViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong)NSArray *imgArry;
@property(nonatomic, strong)UIPageControl *pageC;
@property(nonatomic, strong)NSTimer *rotateTimer;
@property(nonatomic, strong)UIScrollView *scrTopView;
@end

@implementation EBHomeMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.imgArry = [NSArray arrayWithObjects:@"guanggao.png",@"xiaoxi.png",@"guanggao.png",@"xiaoxi.png", nil];
    self.navigationController.title = @"首页";
//    [[UIBarButtonItem alloc] initWithTitle:@"扫码" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)]
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"saoma.png"] forState:UIControlStateNormal];
    rightbtn.frame = CGRectMake(0, 0, 30, 30);
    [rightbtn addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 64, SCREENW, 260);
    [self.view addSubview:topView];
    self.scrTopView = [[UIScrollView alloc] init];
    self.scrTopView.frame = CGRectMake(0, 0, SCREENW, topView.height);
    self.scrTopView.contentSize = CGSizeMake(topView.width * _imgArry.count,0);
    
    self.scrTopView.pagingEnabled = YES;

    self.scrTopView.delegate = self;
    
    [self.imgArry enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(idx * topView.width, 0, topView.width, self.scrTopView.height)];
        imgview.image = [UIImage imageNamed:obj];
//        imgview.contentMode = UIViewContentModeScaleAspectFill;
        imgview.backgroundColor = [UIColor yellowColor];
        [self.scrTopView addSubview:imgview];
    }];
    self.pageC = [[UIPageControl alloc] init];
    self.pageC.centerX = topView.width/2;
    self.pageC.centerY = topView.height-20;
    self.pageC.numberOfPages = _imgArry.count;
    self.pageC.currentPage = 0;
    [topView addSubview:self.scrTopView];
    [topView addSubview:self.pageC];
    
    //启动定时器
    self.rotateTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
    [self.rotateTimer setFireDate:[NSDate date]];
    //为滚动视图指定代理
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(topView.frame), SCREENW, SCREENH-topView.frame.size.height-64);
    NSArray *titArry = [NSArray arrayWithObjects:@"新增",@"待办",@"已办",@"消息",@"贷款计算器",@"修改密码", nil];
    NSArray *iconArry = [NSArray arrayWithObjects:@"xinjian.png",@"needdo.png",@"hasdone.png",@"xiaoxi.png",@"jisuanqi.png",@"changepassword.png", nil];
    CGFloat w = 80;
    CGFloat h = 90;
    CGFloat bothSpace = 30;
    for (int i = 0; i < 6; i++) {
        IconView *icView = [[IconView alloc] init];
        icView.tag = i;
        icView.title = titArry[i];
        icView.iconImg = iconArry[i];
        CGFloat colum = (bottomView.width - 3 * w - 2 *bothSpace) / 2 ;  // 列间距
        CGFloat row = (bottomView.height - 2 * h) /3;  // 行间距
        CGFloat x = i%3 * (w + colum) + bothSpace;
        CGFloat y = i/3 * (h + row)+ row;
       
        icView.frame = CGRectMake(x, y, w,h);
        [icView setTarget:self withSel:@selector(btnClick:)];
        [bottomView addSubview: icView];
    }
    [self.view addSubview:bottomView];
    

}
- (void)btnClick:(UIButton*)iconV{
    if (0 == iconV.tag) {
        EBWorkTypeTableViewController *workType = [[EBWorkTypeTableViewController alloc] init];
        [self.navigationController pushViewController:workType animated:YES];
    }else if (5 == iconV.tag) {
        EBChangPwdViewController *changPwd = [[EBChangPwdViewController alloc] init];
        [self.navigationController pushViewController:changPwd animated:YES];
    }
}

- (void)dealloc{
    [self.rotateTimer invalidate];
    self.rotateTimer = nil;
}
- (void)rightItemClick:(UIButton*)sender{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageC.currentPage = (scrollView.contentOffset.x +0.5)/ SCREENW;
    
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [self.rotateTimer invalidate];
//    self.rotateTimer = nil;
     NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    [self.rotateTimer setFireDate:[NSDate distantFuture]];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.rotateTimer setFireDate:[NSDate dateWithTimeInterval:1.5 sinceDate:[NSDate date]]];
}


- (void)changeView{
    CGFloat offsetX = self.scrTopView.contentOffset.x;
    offsetX +=self.scrTopView.width;
    if (offsetX >= self.scrTopView.contentSize.width) {
        offsetX = 0;
        self.pageC.currentPage = 0;
    }else{
        self.pageC.currentPage = (self.scrTopView.contentOffset.x +0.5)/ SCREENW;
    }
    self.scrTopView.contentOffset = CGPointMake(offsetX, 0);
    
    
}
@end
