//
//  cycleViewProgress.h
//  cycleProgressDemo
//
//  Created by 孙明喆 on 2020/2/6.
//  Copyright © 2020 孙明喆. All rights reserved.
//


#import <UIKit/UIKit.h>

#define PROGRESS_LINE_WIDTH 4 //弧线的宽度
// 设置渐变色RGB从(46, 201, 144)渐变到(21, 203, 210)，如果不采用渐变色，将两个色彩设为一致即可
#define UIColorWithRGBStart [UIColor colorWithRed:46/255.0 green:201/255.0 blue:144/255.0 alpha:1]
#define UIColorWithRGBEnd [UIColor colorWithRed:21/255.0 green:203/255.0 blue:210/255.0 alpha:1]

@interface cycleViewProgress : UIView

@property(nonatomic,assign)float progress;
//@property(nonatomic,assign)float start;

NS_ASSUME_NONNULL_END
