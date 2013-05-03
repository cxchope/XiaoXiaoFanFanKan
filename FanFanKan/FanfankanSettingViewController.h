//
//  FanfankanSettingViewController.h
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanfankanSettingViewController : UIViewController
@property (nonatomic, retain) UILabel *soundNumLab;
- (void)changeValue:(id)sender;
- (void)onButton:(id)sender;
@end
