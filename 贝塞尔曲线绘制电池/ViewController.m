//
//  ViewController.m
//  贝塞尔曲线绘制电池
//
//  Created by 陈孟迪 on 2018/1/26.
//  Copyright © 2018年 陈孟迪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIView *batteryView;
    UILabel *batteryLabel;
    CGFloat w;
    CGFloat lineW;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width-100)/2, 150, 100, 50);
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"点击" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(action:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    [self draw];
    
}
- (void)action:(UIButton*)sender{
    
    float value = arc4random()%+100;
    [self runProgress:value];
    
}

- (void)draw{
    //电池的宽度
    w = 40;
    //电池的x的坐标
    CGFloat x = (self.view.frame.size.width-w)/2;
    //电池的y的坐标
    CGFloat y = 64;
    //电池的线宽
    lineW = 1;
    //电池的高度
    CGFloat h = 15;
    
    //画电池
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h) cornerRadius:2];
    CAShapeLayer *batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = lineW;
    batteryLayer.strokeColor = [UIColor blackColor].CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [path1 CGPath];
    [self.view.layer addSublayer:batteryLayer];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(x+w+1, y+h/3)];
    [path2 addLineToPoint:CGPointMake(x+w+1, y+h*2/3)];
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 2;
    layer2.strokeColor = [UIColor blackColor].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [path2 CGPath];
    [self.view.layer addSublayer:layer2];
    
    //绘制进度
    batteryView = [[UIView alloc]initWithFrame:CGRectMake(x,y+lineW, 0, h-lineW*2)];
    batteryView.layer.cornerRadius = 2;
    batteryView.backgroundColor = [UIColor colorWithRed:0.324 green:0.941 blue:0.413 alpha:1.000];
    [self.view addSubview:batteryView];
    
    
    batteryLabel = [[UILabel alloc]initWithFrame:CGRectMake(x+w+5, y, 50, h)];
    batteryLabel.textColor = [UIColor blackColor];
    batteryLabel.textAlignment = NSTextAlignmentLeft;
    batteryLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:batteryLabel];
    
}

- (void)runProgress:(NSInteger)progressValue{
    
    [UIView animateWithDuration:1 animations:^{
        CGRect frame = batteryView.frame;
        frame.size.width = (progressValue*(w-lineW*2))/100;
        batteryView.frame  = frame;
        batteryLabel.text = [[NSString stringWithFormat:@"%ld",(long)progressValue] stringByAppendingString:@"%"];
        
        if (progressValue<10) {
            batteryView.backgroundColor = [UIColor redColor];
        }else{
          batteryView.backgroundColor = [UIColor colorWithRed:0.324 green:0.941 blue:0.413 alpha:1.000];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
