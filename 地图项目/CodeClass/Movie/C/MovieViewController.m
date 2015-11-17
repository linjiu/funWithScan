//
//  HotReleasedViewController.m
//  地图项目
//
//  Created by 09 on 15/11/9.
//  Copyright © 2015年 yifan. All rights reserved.
//


#import "MovieViewController.h"
#import "iCarousel.h"
#import "MovieModel.h"
#import "DetailsView.h"
#import "DetailMovieViewController.h"


@interface MovieViewController ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong) iCarousel *iCa;
@property (nonatomic, strong) BlurImageView *backV;
@property (nonatomic, strong) DetailsView *detailsView;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSMutableArray *mBrray;//图片
@property (nonatomic, strong) UIButton *button;//头像


@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Hot Showing";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Zapfino" size:17 * kFitHeight]};
    [self setUpView];

}

- (void)setUpView {
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    /**
     *  加载中
     */
    [self setLoading];
    [LORequestManger GET:kHotUrl success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        for (NSDictionary *pic in dic[@"subjects"]) {
            MovieModel *model = [MovieModel shareJsonWithDictionary:pic];
            [self.mArray addObject:model];
            [self.mBrray addObject:model.images];
        }
        [self setUp];
        [self.view bringSubviewToFront:self.customBar];
        [self.pendulum removeFromSuperview];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD dismiss];
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络错误" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *freshAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"重新加载" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self setUpView];
            [self.pendulum removeFromSuperview];
        }];
        [alertC addAction:freshAction];
        [alertC addAction:cancelAction];
        [self presentViewController:alertC animated:YES completion:nil];
        
    }];
    
}


//转动图片
- (void)setUp {
    /**
     *  设置背景图片
     */
    NSDictionary *dicImages = self.mBrray[0];
    self.backV = [[BlurImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.backV sd_setImageWithURL:[NSURL URLWithString:dicImages[@"large"]]];
    
    
    UIView *hotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 400 * kFitHeight)];
    [hotView addSubview:self.backV];
    [self.view addSubview:hotView];
    /**
     iCarousel初始设置
    */
    self.iCa = [[iCarousel alloc] initWithFrame:hotView.bounds];
    self.iCa.type = 6;
    self.iCa.delegate = self;
    self.iCa.dataSource = self;
    self.iCa.pagingEnabled = YES;
    self.iCa.scrollOffset = 0;
    [hotView addSubview:self.iCa];
    /**
     detail
    */
    self.detailsView = [[DetailsView alloc] initWithFrame:CGRectMake(0, 450 * kFitHeight, kWidth, kHeight - 400 * kFitHeight)];
    [self setDetails:0];
}

#pragma mark - 设置简介
- (void)setDetails:(NSInteger)count {

    MovieModel *hotModel = self.mArray[count];
    self.detailsView.title.text = hotModel.title;
    NSDictionary *directors = [hotModel.directors firstObject];
    self.detailsView.directors.text = [@"导演:" stringByAppendingString:directors[@"name"]];
    
    NSString *casts = @"领衔主演:";
    for (NSDictionary *pic in hotModel.casts) {
        casts = [casts stringByAppendingString:pic[@"name"]];
        casts = [casts stringByAppendingString:@" "];
    }
    self.detailsView.casts.text = casts;
    
    NSString *genres = @"类型:\n";
    for (NSString *str in hotModel.genres) {
        genres = [genres stringByAppendingString:str];
        genres = [genres stringByAppendingString:@"\n"];
    }
    self.detailsView.genres.text = genres;
    
    self.detailsView.pubdates.text = [hotModel.pubdates firstObject];
    
    self.detailsView.rating.text = [NSString stringWithFormat:@"评分:\n%.1f",[hotModel.rating[@"average"] floatValue]];
    [self.view addSubview:self.detailsView];
}
- (NSMutableArray *)mArray {
    if (!_mArray) {
        _mArray = [NSMutableArray array];
    }
    return _mArray;
}
- (NSMutableArray *)mBrray {
    if (!_mBrray) {
        _mBrray = [NSMutableArray array];
    }
    return _mBrray;
}
#pragma mark - iCarousel代理方法
- (NSInteger)numberOfItemsInCarousel:(iCarousel * __nonnull)carousel {
    return self.mArray.count;
}
- (UIView *)carousel:(iCarousel * __nonnull)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    NSDictionary *dicImages = self.mBrray[index];
    
    if (view == nil) {
        view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 50 * kFitHeight, 220 * kFitWidth,  300 * kFitHeight)];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50 * kFitHeight, 220 * kFitWidth, 300 * kFitHeight)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:dicImages[@"large"]]];
    [view addSubview:imageView];
    return view;
}
//转动触发方法
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {

    if (self.iCa.scrollOffset == self.mArray.count) {
        self.iCa.scrollOffset = self.mArray.count - 1;
    }
    NSDictionary *dic = self.mBrray[(NSInteger)self.iCa.scrollOffset];
    
    [self.backV sd_setImageWithURL:[NSURL URLWithString:dic[@"large"]]];
    [self setDetails:self.iCa.scrollOffset];
    
}
#pragma mark - 跳转界面
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    _button.hidden = YES;
    
    MovieModel *hotModel = self.mArray[index];
    DetailMovieViewController *vc = [[DetailMovieViewController alloc] init];
    /**
     传值  放在这进去在进入下一界面时会稍卡
     */
    vc.detailViewModel = [[MovieDetailModel alloc] init];
    vc.detailViewModel.ID = hotModel.ID;
    vc.detailViewModel.title = hotModel.title;
    vc.detailViewModel.collection = hotModel.collect_count;
    vc.detailViewModel.pubdate = hotModel.mainland_pubdate;
    vc.detailViewModel.original_title = hotModel.original_title;
    vc.detailViewModel.images = [NSDictionary dictionaryWithDictionary:hotModel.images];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    _button.hidden = NO;
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
