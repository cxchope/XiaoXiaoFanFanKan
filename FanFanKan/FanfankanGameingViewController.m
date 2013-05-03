//
//  FanfankanGameingViewController.m
//  FanFanKan
//
//  Created by Terence Chen on 12-9-13.
//  Copyright (c) 2012年 Terence Chen. All rights reserved.
//

#import "FanfankanGameingViewController.h"
#import "CXC_Image_Resize.h"

@implementation FanfankanGameingViewController
@synthesize selfViewTitle = _selfViewTitle, randomNumber = _randomNumber, imageArray = _imageArray, bImageArray = _bImageArray, imgaeView = _imgaeView, gRect = _gRect, numOff = _numOff, numStep = _numStep,fimg1 = _fimg1, fimg2 = _fimg2;
- (void)dealloc {
    [_fimg1 release];
    [_fimg2 release];
    [_imgaeView release];
    [_imageArray release];
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
    [super viewDidLoad];
    //设置标题
    self.title = self.selfViewTitle;
    //设置背景图片
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"back" ofType:@"jpg"];
    UIImage *img1 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    img1 = [img1 transformWidth:kScreenWIDTH height:kScreenHEIGHT];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img1];
    //    [img1 release];
    //设置导航栏按钮：自定义返回按钮
    UIButton *customViewLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 52, 25)];
    imgPath = [[NSBundle mainBundle] pathForResource:@"btn_back" ofType:@"png"];
    UIImage *img2 = [[UIImage alloc] initWithContentsOfFile:imgPath];
    [customViewLeftButton setImage:img2 forState:UIControlStateNormal];
    [img2 release];
    [customViewLeftButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:customViewLeftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    [customViewLeftButton release];
    //创建备选图片数组：存储16张图
    //    NSMutableArray *imgArray = [[NSMutableArray alloc] init];
    //    //循环 2 x 8 遍，数组中有 1-8 和 1-8 两组图 共16张
    //    for (int i = 0; i < 2; i++) {
    //        for (int j = 0; j < 16; j++) {
    //            imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"h%d",j+1] ofType:@"jpg"];
    //            UIImage *imga = [[UIImage alloc] initWithContentsOfFile:imgPath];
    //            [imgArray addObject:imga];
    //            [imga release];
    //        }
    //    }
    
    //创建备选图片数组：存储8张图
    NSMutableArray *imgArray = [[NSMutableArray alloc] init];
    for (int j = 0; j < 8; j++) {
        imgPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"h%d",j+1] ofType:@"jpg"];
        NSLog(@"%@",imgPath);
        UIImage *imga = [[UIImage alloc] initWithContentsOfFile:imgPath];
        [imgArray addObject:imga];
        [imga release];
    }
    
    //随机取8张图
    //从16张图里随机选择一张图存到UIImage *image
    self.randomNumber = arc4random()%8;
    UIImage *image = [imgArray objectAtIndex:self.randomNumber];
    //在属性图片数组中添加这张图
    self.imageArray = [[[NSMutableArray alloc] init] autorelease];
    [self.imageArray addObject:image];
    //从备选图片中移除这张图
    [imgArray removeObjectAtIndex:self.randomNumber];
    do { //第二环节：从8种牌中分配
        //检测备选图片数组还有多少张图
        int lengthArray = [imgArray count];
        //在剩余的图里产生随机图
        self.randomNumber = arc4random()%lengthArray;
        UIImage *image = [imgArray objectAtIndex:self.randomNumber];
        //在属性图片数组中添加这张图
        [self.imageArray addObject:image];
        //从备选图片中移除这张图
        [imgArray removeObjectAtIndex:self.randomNumber];
        
    } while ([self.imageArray count]<8); //从8种牌中分配
    //=
    NSLog(@"imgArray = %d",[imgArray count]);
    NSLog(@"self.imageArray = %d",[self.imageArray count]);
    //self.imageArray 前8 和 后8 都已经打乱
    //imageArray翻倍以补齐含对牌16张
    [self.imageArray addObjectsFromArray:self.imageArray]; //++++++++++++
    //初始化bImageArray
    
    self.bImageArray = [[[NSMutableArray alloc] init] autorelease];
    //解决翻倍后两组顺序一致问题，进行第二次筛
    for (int i=0; i<16; i++) { //16张循环
        //检测打乱的图片数组还有多少张图
        int lengthArray = [self.imageArray count]-1;
        if (lengthArray == 0) { //如果是空的（还没有分配）
            //添加第一张图
            [self.bImageArray addObject:[self.imageArray objectAtIndex:0]];
        } else { //如果非空
            //在剩余的图里产生随机图
            int index = arc4random()%lengthArray;
            //在属性图片2数组中添加这张图
            [self.bImageArray addObject:[self.imageArray objectAtIndex:index]];
            //从属性图片1中移除这张图
            [self.imageArray removeObjectAtIndex:index];
        }
    }
    //添加打乱后的16张图
    float y=20 ; //坐标 //, x=10
    int z=1; //计数器
    //双层for建立 4 x 4 牌阵
    for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++) {
            //添加牌背
            self.imgaeView = [[[UIImageView alloc] init] autorelease];
            self.imgaeView.frame = CGRectMake(37.6+(145+37.6)*i, 52.8+(185+52.8)*j, 145, 185);
            //            self.imgaeView.frame = CGRectMake(x, y, 50, 60);
            self.imgaeView.tag = 1000+z;
            NSLog(@"tagA = %d",self.imgaeView.tag);
            self.imgaeView.image = [self.bImageArray objectAtIndex:z-1];
            self.imgaeView.userInteractionEnabled = YES;
            [self.view addSubview:self.imgaeView];
            //            x += 80; //x坐标+
            z++;
        }
        //        x = 10;
        y += 100; //y坐标+
    }
    //各种变量初始化
    isTouchFirst = YES; //第一次
    isTouchSecond = NO; //第二次
    fractionNum = 0; //分数
    int static count = 1; //计数器
    count ++; //计数器自增
    self.numOff = count;
    self.numStep = 0;
    float static timeValue = 2.5; //设置显示时间
    timeValue = timeValue -0.5;
    if (timeValue < 0) {
        timeValue = 2;
    }
    //设置翻转动画。之前先给玩家显示timeValue秒答案
    [self performSelector:@selector(beginAnimation) withObject:nil afterDelay:timeValue];
}
#pragma mark 返回按钮
- (void)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 开始动画
- (void)beginAnimation
{
    for (int i=1; i<17; i++) {
        self.imgaeView = (UIImageView *)[self.view viewWithTag:1000+i];
        [UIView beginAnimations:@"Start" context:@"Start"];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgaeView cache:NO];
        self.imgaeView.image = [UIImage imageNamed:@"背面.jpg"];
        [UIView commitAnimations];
    }
}
#pragma mark 被点击时
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    self.imgaeView = (UIImageView *)touch.view;
    
    if (![touch.view isEqual:self.view]) {
        
        if ([self.imgaeView.image isEqual:[UIImage imageNamed:@"背面.jpg"]]) {
            if (isTouchFirst) {
                
                [self flipVersoTooFront];
                tag1 = self.imgaeView.tag;
                //                self.fimg1 = self.imgaeView.image;
                //                NSLog(@"写入self.fimg1");
                isTouchFirst = NO;
                isTouchSecond = YES;
                self.numStep++;
            }
            else if (isTouchSecond) {
                tag2 = self.imgaeView.tag;
                //                self.fimg2 = self.imgaeView.image;
                //                NSLog(@"写入self.fimg2");
                [self flipVersoTooFront];
                [self performSelector:@selector(compareTwoPicture) withObject:self afterDelay:0.5];
                isTouchSecond = NO;
                self.numStep++;
            }
        }
    }
}
#pragma mark 从反面到正面的效果
- (void)flipVersoTooFront
{
    [UIView beginAnimations:@"反面到正面" context:Nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    self.imgaeView.image = [self.bImageArray objectAtIndex:self.imgaeView.tag-1001];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgaeView cache:YES];
    [UIView commitAnimations];
}
#pragma mark 判断玩家是否选择正确(图相等)
- (void)compareTwoPicture
{
    NSLog(@"tag1 = %d, tag2 = %d, c = %d",tag1,tag2,tag1 - tag2);
    if (![[self.bImageArray objectAtIndex:tag1-1001] isEqual:[self.bImageArray objectAtIndex:tag2-1001]]) {
        //    if (![self.fimg1 isEqual:self.fimg2]) {
        NSLog(@"不一样1=%@,2=%@",self.fimg1,self.fimg2);
        //        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        //        UIImageView *iv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
        //        iv.image = self.fimg1;
        //        iv2.image = self.fimg2;
        //        [self.view addSubview:iv];[self.view addSubview:iv2];
        [self flipTooVerso:tag1];
        [self flipTooVerso:tag2];
    }else{
        NSLog(@"一样");
        [self isEqualPhoto:tag1];
        [self isEqualPhoto:tag2];
        fractionNum +=2;
        if (fractionNum == 16) {
            [self winClick];
        }
        
    }
    isTouchFirst = YES;
}
#pragma mark 图片相等的话执行一个特效
-(void)isEqualPhoto:(NSInteger)tag
{
    self.imgaeView = (UIImageView *)[self.view viewWithTag:tag];
    
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1.3);
    CATransform3D back = CATransform3DMakeScale(0.7, 0.7, 1);
    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1);
    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1);
    
    [bounce setValues:[NSArray arrayWithObjects:
                       [NSValue valueWithCATransform3D:CATransform3DIdentity],
                       [NSValue valueWithCATransform3D:forward],
                       [NSValue valueWithCATransform3D:back],
                       [NSValue valueWithCATransform3D:forward2],
                       [NSValue valueWithCATransform3D:back2],
                       [NSValue valueWithCATransform3D:CATransform3DIdentity],nil]];
    
    [bounce setDuration:0.5];
    
    [[self.imgaeView layer] addAnimation:bounce forKey:@"Right"];
    
}
#pragma mark 图片不相等的话执行翻回去的特效
- (void)flipTooVerso:(NSInteger)tag
{
    self.imgaeView = (UIImageView *)[self.view viewWithTag:tag];
    [UIView beginAnimations:@"End" context:Nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imgaeView cache:YES];
    self.imgaeView.image = [UIImage imageNamed:@"背面.jpg"];
    [UIView commitAnimations];
}
#pragma mark 是否胜利？
-(void)winClick
{
    NSString *btnStr = [NSString stringWithFormat:@"第 %d 关", self.numOff];
    NSString *stepStr = [NSString stringWithFormat:@"共 %d 步", self.numStep];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"恭喜:闯关成功" message:@"请继续游戏-Come On!" delegate:self cancelButtonTitle:btnStr otherButtonTitles:@"结束游戏", stepStr, nil];
    [alert show];
    [alert release];
}
//处理提示框返回的按钮，使用UIAlertView的代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        for (int i=1; i<17; i++) {
            self.imgaeView = (UIImageView *)[self.view viewWithTag:1000+i];
            [self.imgaeView removeFromSuperview];
        }
        [self.imageArray removeAllObjects];
        [self.bImageArray removeAllObjects];
        [self viewDidLoad];
    }
    if (buttonIndex == 1 || buttonIndex ==2) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark 动画的代理方法
//动画开始
- (void)animationWillStart:(NSString *)animationID context:(void *)context
{
    NSString *conText = (NSString *)animationID;
    
    if ([conText isEqualToString:@"Start"]) {
        for (int i=1; i<17; i++) {
            self.imgaeView = (UIImageView *)[self.view viewWithTag:1000+i];
            self.imgaeView.userInteractionEnabled = NO;
        }
    }
    
    
}
//动画结束
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    NSString *conText = (NSString *)context;
    
    if ([conText isEqualToString:@"Start"]) {
        for (int i=1; i<17; i++) {
            self.imgaeView = (UIImageView *)[self.view viewWithTag:1000+i];
            self.imgaeView.userInteractionEnabled = YES;
        }
    }
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