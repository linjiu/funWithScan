//
//  RecommandMainVC.m
//  音乐项目
//
//  Created by apple on 15/11/2.
//  Copyright © 2015年 apple. All rights reserved.
//

#define kURL @"http://goapi.5sing.kugou.com/getSongListSquareRecommended?index=%ld&version=5.7.2"

#import "RecommandMainVC.h"
#import "RecommandMainModel.h"
#import "CollectionMainCell.h"
#import "NetHandler.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ListViewController.h"
@interface RecommandMainVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) NSMutableArray *mainArr;

@property (nonatomic, assign) NSInteger index;


@end

@implementation RecommandMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"searchMusic.jpg"]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:(CGRectMake(self.view.bounds.size.width / 3, 25, self.view.bounds.size.width / 2, 40))];
    label.text = @"favourite";
    label.font = [UIFont fontWithName:@"Zapfino" size:27];
    [self.view addSubview:label];
    
    /**
     layout设置
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kWidth - 6) / 2.05, (kWidth - 6) / 2.05);
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    self.collectionV = [[UICollectionView alloc]initWithFrame:(CGRectMake(2, 70, kWidth - 6, kHeight - 70)) collectionViewLayout:layout];
    self.collectionV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionV];
    
    [self.collectionV registerClass:[CollectionMainCell class]
       forCellWithReuseIdentifier:@"mainCell"];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.showsVerticalScrollIndicator = NO;
    self.index = 1;
    [self handle];


    self.collectionV.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mainArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];

    RecommandMainModel *model = self.mainArr[indexPath.item];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.P]];
    cell.label.text = model.T;
    return cell;
}

- (void)handle
{
    [self setLoading];
    self.mainArr = [NSMutableArray array];
    [NetHandler getDataWithUrl:[NSString stringWithFormat:kURL, self.index] completion:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSArray *arr = [dic objectForKey:@"data"];
            for (NSDictionary *DIC in arr) {
                RecommandMainModel *model = [[RecommandMainModel alloc]init];
                [model setValuesForKeysWithDictionary:DIC];
                [self.mainArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionV reloadData];
                [self.pendulum removeFromSuperview];
            });
        });
    }];
}
/**
 *  下拉刷新
 */
- (void)loadNewData
{
    self.index++;
    [NetHandler getDataWithUrl:[NSString stringWithFormat:kURL, self.index] completion:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSArray *arr = [dic objectForKey:@"data"];
            for (NSDictionary *DIC in arr) {
                RecommandMainModel *model = [[RecommandMainModel alloc]init];
                [model setValuesForKeysWithDictionary:DIC];
                [self.mainArr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionV reloadData];
            });
        });
    }];
}
#pragma mark - 点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewController *listVC = [[ListViewController alloc]init];
    listVC.model = self.mainArr[indexPath.item];

    [self.navigationController pushViewController:listVC animated:YES];
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
