//
//  FanfankanMainMenuViewController.m
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "FanfankanMainMenuViewController.h"
#import "FanfankanGameingViewController.h"
#import "FanfankanSettingViewController.h"
#import "MusicPlayerClass.h"
#import "CXC_Image_Resize.h"
@implementation FanfankanMainMenuViewController
- (void)dealloc {
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    NSLog(@"内存警告！！");
    [super didReceiveMemoryWarning];
}
#pragma mark - 主要
- (void)viewDidLoad
{
    self.title = @"翻翻看"; //标题
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"back" ofType:@"jpg"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgPath];
    //创建一个UIImageView作背景图（防止平铺）
    img = [img transformWidth:kScreenWIDTH height:kScreenHEIGHT]; //拉伸图片
    UIImageView *backgroundimg = [[UIImageView alloc] initWithImage:img];
    [self.view addSubview:backgroundimg];
    [backgroundimg release];
    //开始游戏按钮
    UIButton *startGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startGameButton.frame = CGRectMake(400, 200, 300, 100);
    [startGameButton setTintColor:[UIColor redColor]];
    [startGameButton setHighlighted:YES];
    [startGameButton setTitle:@"开始游戏" forState:UIControlStateNormal];
    [startGameButton addTarget:self action:@selector(startgame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startGameButton];
    //设置按钮
    UIButton *gotoSettingViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gotoSettingViewButton.frame = CGRectMake(400, 360, 300, 100);
    [gotoSettingViewButton setHighlighted:YES];
    [gotoSettingViewButton setTitle:@"设置" forState:UIControlStateNormal];
    [gotoSettingViewButton addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotoSettingViewButton];
    //音乐开关
    [[MusicPlayerClass publicMusicPlayer].backgroundMusic play];
    UIButton *isMuteMusicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    isMuteMusicButton.frame = CGRectMake(20, 20, 150, 150);
    if ([[MusicPlayerClass publicMusicPlayer].backgroundMusic play]) {
        imgPath = [[NSBundle mainBundle] pathForResource:@"musicOpen" ofType:@"png"];
        UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:imgPath];
        [isMuteMusicButton setBackgroundImage:img2 forState:UIControlStateNormal];
        [img2 release];
    } else {
        imgPath = [[NSBundle mainBundle] pathForResource:@"musicClose" ofType:@"png"];
        UIImage *img3 = [[UIImage alloc] initWithContentsOfFile:imgPath];
        [isMuteMusicButton setBackgroundImage:img3 forState:UIControlStateNormal];
        [img3 release];
    }
    [isMuteMusicButton addTarget:self action:@selector(openOrCloseMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:isMuteMusicButton];
    //开始播放音乐
    [[MusicPlayerClass publicMusicPlayer].backgroundMusic play];
}
#pragma mark - 导航栏样式
-(void)viewWillAppear:(BOOL)animated
{   //进入
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
}
-(void)viewWillDisappear:(BOOL)animated
{   //离开
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
}
#pragma mark - 进入设置画面
- (void)setting:(id)sender
{
    FanfankanSettingViewController *gamesetting = [[FanfankanSettingViewController alloc] init];
    //设置模态
    [gamesetting setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentModalViewController:gamesetting animated:YES]; //打开模态
    [gamesetting release];
}
#pragma mark 静音开关
- (void)openOrCloseMusic:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //如果正在播放
    if ([[MusicPlayerClass publicMusicPlayer].backgroundMusic isPlaying]) {
        //停止播放
        [[MusicPlayerClass publicMusicPlayer].backgroundMusic stop];
        //修改按钮图片
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"musicClose" ofType:@"png"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgPath];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [img release];
    } else { //如果没有播放
        //开始播放
        [[MusicPlayerClass publicMusicPlayer].backgroundMusic play];
        //修改按钮图片
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"musicOpen" ofType:@"png"];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgPath];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [img release];
    }
}
#pragma mark 开始游戏
- (void)startgame:(id)sender
{
    FanfankanGameingViewController *startGameViewController = [[FanfankanGameingViewController alloc] init];
    startGameViewController.Title = self.title; //将下一页面标题设为按钮标题
    [self.navigationController pushViewController:startGameViewController animated:YES];
    [startGameViewController release];
    // -> FanfankanGameingViewController.h
}
#pragma mark -
- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
