//
//  MusicPlayer.h
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicPlayerClass : NSObject
@property (nonatomic, retain) AVAudioPlayer *backgroundMusic;
@property (nonatomic,assign)float musicVolume;
+ (MusicPlayerClass *)publicMusicPlayer;
@end
