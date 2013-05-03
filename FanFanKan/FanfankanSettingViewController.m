//
//  FanfankanSettingViewController.m
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "FanfankanSettingViewController.h"
#import "MusicPlayerClass.h"
@implementation FanfankanSettingViewController
@synthesize soundNumLab = _soundNumLab;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)loadView
{
    UIView *aView = [[UIView alloc] init];
    [aView setBackgroundColor:[UIColor brownColor]];
    self.view = aView;
    [aView release];
    
    
    //设置标签
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(80, 26, 161, 73)];
    lab.text = @"音量设置";
    lab.font = [UIFont systemFontOfSize:36];
    lab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lab];
    [lab release];
    
    //声音标签
    UILabel *soundLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 164, 42, 21)];
    soundLab.text = @"声音";
    soundLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:soundLab];
    [soundLab release];
    
    //音量数字标签
    self.soundNumLab = [[[UILabel alloc] initWithFrame:CGRectMake(248, 194, 50, 21)] autorelease];
    self.soundNumLab.text = [NSString stringWithFormat:@"%.0f",[MusicPlayerClass publicMusicPlayer].backgroundMusic.volume * 100];
    self.soundNumLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.soundNumLab];
    
    //音量滑动条 slider
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(68, 164, 209, 23)];
    //slider.minimumValue = 0; //最小值
    //slider.maximumValue = 1; //最大值
    slider.value = [MusicPlayerClass publicMusicPlayer].backgroundMusic.volume;//0.5; //当前值
    [slider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider release];
    
    //完成按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(228, 372, 72, 37);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
#pragma mark - 声音滑动条
- (void)changeValue:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    //改变音量数字标签值
    self.soundNumLab.text = [NSString stringWithFormat:@"%.0f",slider.value*100];
    //改变音量大小
    [MusicPlayerClass publicMusicPlayer].backgroundMusic.volume = slider.value;
}
#pragma mark - 完成按钮
- (void)onButton:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)dealloc
{
    [_soundNumLab release];
    [super dealloc];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
