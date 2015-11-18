//
//  ListViewController.m
//  音乐项目
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#define kURL @"http://mobileapi.5sing.kugou.com/song/getsonglistsong?id=%@&songfields=ID%%2CSN%%2CFN%%2CSK%%2CSW%%2CSS%%2CST%%2CSI%%2CCT%%2CM%%2CS%%2CZQ%%2CWO%%2CZC%%2CHY%%2CYG%%2CCK%%2CD%%2CRQ%%2CDD%%2CE%%2CR%%2CRC%%2CSG%%2CC%%2CCS%%2CLV%%2CLG%%2CSY%%2CUID%%2CPT%%2CSCSR%%2CSC&userfields=ID%%2CNN%%2CI%%2CB%%2CP%%2CC%%2CSX%%2CE%%2CM%%2CVT%%2CCT%%2CTYC%%2CTFC%%2CTBZ%%2CTFD%%2CTFS%%2CSC%%2CYCRQ%%2CFCRQ%%2CCC%%2CBG%%2CDJ%%2CRC%%2CMC%%2CAU%%2CSR%%2CSG%%2CVG%%2CISC&version=5.7.2"

#import "ListViewController.h"
#import "NetHandler.h"
#import "RecommandMainModel.h"
#import "playModel.h"
#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>
#import "LORequestManger.h"

#import "ListCell.h"
#import "UIColor+AddColor.h"

@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate,NSURLConnectionDataDelegate, myTabVdelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) NSMutableData *receiveData;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;

@property (nonatomic, strong) UIScrollView *backV;
@property (nonatomic, strong) NSTimer *timer;


@end
@implementation ListViewController

- (void)zoomScale:(NSTimer *)timer{
    //放大动画
    [UIView animateWithDuration:4 animations:^{
        self.backV.zoomScale = 1.28;
    }];
    //因为我们的动画 做了4秒
    [self performSelector:@selector(small) withObject:timer afterDelay:4];
}

#pragma mark 缩小的动画
- (void)small{
    //缩小动画
    [UIView animateWithDuration:4 animations:^{
        self.backV.zoomScale = 1.1;
    }];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageV;
}

-(void)dealloc{
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"searchMusic.jpg"]];
    
    
    self.backV = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 20, kWidth, 230))];
    self.imageV = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 20, kWidth, 230))];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:self.model.P]];
    
    //动画
    self.backV.showsHorizontalScrollIndicator = NO;
    self.backV.showsVerticalScrollIndicator = NO;
    //超出边界隐藏
    self.imageV.clipsToBounds = YES;
    [self.backV addSubview:self.imageV];
    self.backV.delegate = self;
    //设置一个放大倍数 最大值和最小值
    self.backV.maximumZoomScale = 2.0;
    self.backV.minimumZoomScale = 1;
    //self.backV.userInteractionEnabled = NO;

    [self.view addSubview:self.backV];

    
    //初始化NSTimer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(zoomScale:) userInfo:nil repeats:YES];
    //因为timer要等待8s时间，所以我们先手动调用一次
    [self zoomScale:nil];
    
    
    self.tableV = [[UITableView alloc]initWithFrame:(CGRectMake(0, self.imageV.frame.origin.y + self.imageV.bounds.size.height + 5, kWidth, kHeight - (self.imageV.frame.origin.y + self.imageV.bounds.size.height + 5))) style:(UITableViewStylePlain)];
    
    UIView *view = [[UIView alloc]initWithFrame:(CGRectZero)];
    self.tableV.tableFooterView = view;
    view.backgroundColor = [UIColor clearColor];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableV];
    self.tableV.backgroundColor = [UIColor clearColor];
    [self handle];

    [self.view bringSubviewToFront:self.customBar];
}
-(void)leftBtnClick:(UIButton *)button
{
    [self.player pause];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setModel:(RecommandMainModel *)model
{
    _model = model;
    
}


- (void)handle
{
    self.arr = [NSMutableArray array];
    NSString *str = [NSString stringWithFormat:kURL, self.model.ID];
    [self setLoading];
    [LORequestManger GET:str success:^(id response) {
        NSDictionary *dic = (NSDictionary *)response;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSArray *arr = [dic objectForKey:@"data"];
            for (NSDictionary *DIC in arr) {
                playModel *model = [[playModel alloc]init];
                [model setValuesForKeysWithDictionary:DIC];
                [self.arr addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableV reloadData];
                [self.pendulum removeFromSuperview];
            });
        });
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // NSLog(@"%@",error);
    }];
    
    
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell1";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[ListCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:reuseIdentifier];
    }
    playModel *model = self.arr[indexPath.row];
    cell.url = model.FN;
    cell.authorLabel.text = model.S;
    cell.songLabel.text = model.SN;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.isPlay == NO) {
        
        for (int i = 0; i < self.arr.count; i++) {
            ListCell *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.isPlay = NO;
            [cell.button setImage:[UIImage imageNamed:@"player_play"] forState:(UIControlStateNormal)];
        }

        [self.pendulum removeFromSuperview];
        [self setLoading];
        [cell.button setImage:[UIImage imageNamed:@"player_pause"] forState:(UIControlStateNormal)];
        self.player = [[AVPlayer alloc]init];
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:cell.url]];
        
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.player play];
        cell.isPlay = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pendulum removeFromSuperview];
        });
        
        
    }else{
        [cell.button setImage:[UIImage imageNamed:@"player_play"] forState:(UIControlStateNormal)];
        cell.isPlay = NO;
        [self.player pause];
    }
    
}




-(void)myTabVClick:(ListCell *)cell
{
    if (cell.isPlay == NO) {
        [self.pendulum removeFromSuperview];
        [self setLoading];
        
        for (int i = 0; i < self.arr.count; i++) {
            ListCell *cell = [self.tableV cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell.isPlay = NO;
            [cell.button setImage:[UIImage imageNamed:@"player_play"] forState:(UIControlStateNormal)];
        }
        [cell.button setImage:[UIImage imageNamed:@"player_pause"] forState:(UIControlStateNormal)];
        self.player = [[AVPlayer alloc]init];
        self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:cell.url]];
        
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.player play];
        cell.isPlay = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pendulum removeFromSuperview];
        });
        
        
        
    }else{
        [self.pendulum removeFromSuperview];
        [cell.button setImage:[UIImage imageNamed:@"player_play"] forState:(UIControlStateNormal)];
        cell.isPlay = NO;
        [self.player pause];
    }
}



/*
- (void)buttonAction
{
    [[LouMusicPlayer shareMusicPlayer]playSongWithUrl:self.playModel.SN];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSongInfo) name:@"reload" object:nil];
    [[LouMusicPlayer shareMusicPlayer] starPlaySong];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starPlay) name:@"readyToPlay" object:nil];
}

- (void)starPlay
{
    //开始播放
    [[LouMusicPlayer shareMusicPlayer] starPlaySong];
    //判断我们是否缓冲成功
    if ([[LouMusicPlayer shareMusicPlayer] readyToPlay] == YES) {
        //如果缓冲成功，给button重新设置一张图片
        //当我们的歌曲正在播放当中，我们的button默认图片应该为‘暂停’的图片
        //当我们的歌曲没有在播放，我们的button默认图片应该为'播放'的图片
        [self.playButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
    }
}
- (void)playSong
{
    self.playButton.tag += 1;
    int tag = (self.musicControlV.playButton.tag - 1000) % 2;
    if (tag == 0) {
        NSLog(@"暂停播放");
        [[LouMusicPlayer shareMusicPlayer] stopPlaySong];
        [self.musicControlV.playButton setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }else
    {
        [[LouMusicPlayer shareMusicPlayer] starPlaySong];
        [self.musicControlV.playButton setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        NSLog(@"开始播放");
    }
}
*/

@end
