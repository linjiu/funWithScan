//
//  DetailMovieViewController.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//


#import "DetailMovieViewController.h"
#import "MoviePlayerController.h"
#import "AppDelegate.h"
@interface DetailMovieViewController ()

@property (nonatomic, strong) NSMutableArray *saveArray;

@end

@implementation DetailMovieViewController

- (NSMutableArray *)saveArray {
    if (!_saveArray) {
        _saveArray = [NSMutableArray array];
    }
    return _saveArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"558c5305c8ac2.jpeg"]];
    
    [self setLoading];
    [self setUpDetailMovieWithJson];
    UIVisualEffectView *backVisual = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    backVisual.frame = self.view.bounds;
    backVisual.alpha = 1.0;
    [self.view addSubview:backVisual];
}

- (void)setUpDetailMovieWithJson {
    NSString *urlStr = [kDetailMovieUrl stringByReplacingOccurrencesOfString:@"电影ID" withString:self.detailViewModel.ID];
    [LORequestManger GET:urlStr success:^(id response) {
        NSDictionary *dictionary = (NSDictionary *)response;
        self.model = [DetailModel setJsonWithDictionary:dictionary];
        
        [self setDetailMovieScrollView];
        [self.view bringSubviewToFront:self.customBar];
        [self.pendulum removeFromSuperview];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        /**
         *  alertC
         */
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络错误" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertC addAction:cancelAction];
        [self presentViewController:alertC animated:YES completion:nil];
        /**
         *  控制结束时间
         */
        [self performSelector:@selector(dismiss:) withObject:alertC afterDelay:0.8f];
    }];
}
-(void)leftBtnClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setDetailMovieScrollView {
    self.detailSView = [[DetailMovieScrollView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64)];
    [self.detailSView setDetailViewWithDetailModel:self.model];
    [self.detailSView addTapLabelWithTarget:self action:@selector(actionTapMovieSummary:)];
    [self.view addSubview:self.detailSView];
    /**
     *  动画
     */
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(bored) userInfo:nil repeats:NO];
    for (int i = 0; i < self.model.trailer_urls.count; i++) {
        UIButton *button = (UIButton *)[self.detailSView viewWithTag:1000 + i];
        [button addTarget:self action:@selector(button:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)bored {
    [self.detailSView addSubview:self.detailSView.moviePic];
    [UIView animateWithDuration:1.0 animations:^{
        self.detailSView.moviePic.frame = CGRectMake(10 * kFitWidth, 10 * kFitHeight, 120 * kFitWidth, 160 * kFitHeight);
    }];
}
- (void)button:(UIButton *)bt {

    //视频文件路径
    NSString *path = self.model.trailer_urls[bt.tag-1000];
    
    MoviePlayerController *playVC = [[MoviePlayerController alloc] init];
    playVC.url = path;
    //拿到appDelegate
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    //设置属性，仅支持横屏切换
    appdelegate.isRotation = YES;
    //在跳转以前，给appdelegate的属性赋值
    [self presentViewController:playVC animated:YES completion:nil];

}

// 简介的点击事件
- (void)actionTapMovieSummary:(id)sender {
    // 每次点击简介都改变frame（收缩简介）
    NSString *replaceStr = [self.model.summary stringByReplacingOccurrencesOfString:@"©豆瓣" withString:@""];
    if (self.detailSView.movieSummary.tag % 2 == 0) {
        self.detailSView.movieSummary.text = replaceStr;
    }else {
        self.detailSView.movieSummary.text = [replaceStr substringToIndex:60];
    }
    
    CGRect frame = [self.detailSView.movieSummary.text boundingRectWithSize:CGSizeMake(kWidth - (20 * kFitWidth), 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:13.0 * kFitHeight] forKey:NSFontAttributeName] context:nil];
    self.detailSView.movieSummary.frame = CGRectMake(10 * kFitWidth, 180 * kFitHeight, kWidth - (20 * kFitWidth), frame.size.height);
    self.detailSView.movieSummary.tag += 1;
    
    // 重新设置导演和演员的scrollView的位置
    self.detailSView.castsScrollView.frame = CGRectMake(0, self.detailSView.movieSummary.frame.origin.y + self.detailSView.movieSummary.frame.size.height + 20 * kFitHeight, kWidth, 160 * kFitHeight);
    // 重新设置所有控件的位置
    self.detailSView.allView.frame = CGRectMake(0, self.detailSView.castsScrollView.frame.origin.y + self.detailSView.castsScrollView.frame.size.height + 20 * kFitHeight, kWidth, self.detailSView.movieTrailerTitle.frame.origin.y + self.detailSView.movieTrailerTitle.frame.size.height);
    // 重新设置详情界面scrollView的偏移范围
    self.detailSView.contentSize = CGSizeMake(kWidth, self.detailSView.allView.frame.origin.y + self.detailSView.allView.frame.size.height);

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
