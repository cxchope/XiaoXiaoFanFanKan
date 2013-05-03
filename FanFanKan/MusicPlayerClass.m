//
//  MusicPlayer.m
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "MusicPlayerClass.h"

@implementation MusicPlayerClass
@synthesize backgroundMusic;
@synthesize musicVolume;
- (void)dealloc
{
    [backgroundMusic release];
    [super dealloc];
}
+ (MusicPlayerClass *)publicMusicPlayer
{
    static MusicPlayerClass *musicPlayer=nil;
    @synchronized(self) {
        if(!musicPlayer) {
            musicPlayer = [[MusicPlayerClass alloc] init];
            NSString *path=[[NSBundle mainBundle] pathForResource:@"海贼王背景音" ofType:@"mp3"];
            NSURL *url=[NSURL fileURLWithPath:path];
            musicPlayer.backgroundMusic = [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil] autorelease];
            //音乐音量
            musicPlayer.backgroundMusic.volume = 1;
            //音乐循环次数 -1 无限循环
            musicPlayer.backgroundMusic.numberOfLoops = -1;
        }
    }
    return musicPlayer;
    return musicPlayer;
}
@end
