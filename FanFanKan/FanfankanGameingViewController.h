//
//  FanfankanGameingViewController.h
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FanfankanGameingViewController : UIViewController
{
    BOOL isTouchFirst;
    BOOL isTouchSecond;
    NSInteger tag1;
    NSInteger tag2;
    NSInteger fractionNum;
}
//自身的标题
@property (nonatomic, retain) NSString *selfViewTitle;
//存储随机数
@property (nonatomic, assign) NSInteger randomNumber;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *bImageArray;
@property (nonatomic, retain) UIImageView *imgaeView;
@property (nonatomic, assign) CGRect gRect;
@property (nonatomic, assign) NSInteger numOff;
@property (nonatomic, assign) NSInteger numStep;
@property (nonatomic, retain) UIImage *fimg1;
@property (nonatomic, retain) UIImage *fimg2;
//    开始动画效果
- (void)beginAnimation;
//反面->>>正面 翻转图片动画效果方法
- (void)flipVersoTooFront;
// 比较两张图片 看是否相等
- (void)compareTwoPicture;
//检测图片不相等，把两张图片同时翻转为背面
- (void)flipTooVerso:(NSInteger)tag;
//判断游戏是否结束，胜利或失败
-(void)winClick;
//如果判断两张图片相等，则产生的效果方法是
-(void)isEqualPhoto:(NSInteger)tag;
@end
