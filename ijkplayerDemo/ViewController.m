//
//  ViewController.m
//  ijkplayerDemo
//
//  Created by 吴书敏 on 16/9/14.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#import "ViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h> // 编译一下没有错，集成成功

@interface ViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController<IJKMediaPlayback> *ijkPlayer;
@property (nonatomic, strong) UIView *playerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ijkPlayer 的基本使用
    // 1. 创建 IJKFFMoviePlayerController
    // 2. 设置 相关属性
    // 3. 添加 IJKFFMoviePlayerController.view
    // 4. self 成为 通知观察者
    NSURL *url = [NSURL URLWithString:@"http://ws.acgvideo.com/e/56/1482982-1hd.mp4?wsTime=1473913401&wsSecret2=8fb51194dfa10e8ab493ea715ad23bf7&oi=1918279046"];
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:options];
    self.ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
//    self.ijkPlayer.shouldAutoplay = YES;
    
    UIView *ijkPlayerView = self.ijkPlayer.view;
    self.playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 375, 375 *14 / 25)];
    self.playerView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_playerView];
    
    ijkPlayerView.frame = self.playerView.bounds; // 必须设置么
    [self.playerView addSubview:ijkPlayerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ijkPlayBackStateDidChange:) name:IJKMediaPlaybackIsPreparedToPlayDidChangeNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    if (![self.ijkPlayer isPlaying]) {
        [self.ijkPlayer prepareToPlay];
    }
}

- (void)ijkPlayBackStateDidChange:(NSNotification *)notification {
    // 控制弹幕
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
