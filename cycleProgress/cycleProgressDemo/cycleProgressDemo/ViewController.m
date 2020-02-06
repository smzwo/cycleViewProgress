//
//  ViewController.m
//  cycleProgressDemo
//
//  Created by 孙明喆 on 2020/2/6.
//  Copyright © 2020 孙明喆. All rights reserved.
//

#import "ViewController.h"
#import "cycleViewProgress.h"

@interface ViewController ()
{
    cycleViewProgress *cycle;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 150 + PROGRESS_LINE_WIDTH, 150 + PROGRESS_LINE_WIDTH)];
    imageView.image = [UIImage imageNamed:@"MacHi"];
    [self.view addSubview:imageView];

    cycle = [[cycleViewProgress alloc]initWithFrame:CGRectMake(100, 100, 150 + PROGRESS_LINE_WIDTH, 150 + PROGRESS_LINE_WIDTH)];
    [self.view addSubview:cycle];


    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:but];
    but.frame = CGRectMake(100, 300, 100, 30);
    but.backgroundColor = [UIColor redColor];
    [but addTarget:self action:@selector(cycleChange:) forControlEvents:UIControlEventTouchUpInside];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(100 , 500, 150, 20)];
    slider.minimumValue = 0;// 设置最小值
    slider.maximumValue = 1;// 设置最大值
    slider.value = 0;// 设置初始值
    slider.continuous = YES;// 设置可连续变化
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [self.view addSubview:slider];

}

- (void)sliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"%.1f", slider.value);
    cycle.progress = slider.value;
}

-(void)cycleChange:(UIButton *)sender
{
    cycle.progress = 0.4;
//    cycle.start = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
