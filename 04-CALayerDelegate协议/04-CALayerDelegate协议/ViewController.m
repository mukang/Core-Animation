//
//  ViewController.m
//  04-CALayerDelegate协议
//
//  Created by 穆康 on 16/7/21.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CALayer *blueLayer = [[CALayer alloc] init];
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    
    blueLayer.delegate = self;
    
    // ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    // add layer to our view
    [self.layerView.layer addSublayer:blueLayer];
    
    // force layer to redraw
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    
    // draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

/*
 我们在blueLayer上显式地调用了-display。不同于UIView，当图层显示在屏幕上时，CALayer不会自动重绘它的内容。它把重绘的决定权交给了开发者。
 尽管我们没有用masksToBounds属性，绘制的那个圆仍然沿边界被裁剪了。这是因为当你使用CALayerDelegate绘制寄宿图的时候，并没有对超出边界外的内容提供绘制支持。
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
