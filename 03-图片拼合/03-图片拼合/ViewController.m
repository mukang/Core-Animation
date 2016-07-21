//
//  ViewController.m
//  03-图片拼合
//
//  Created by 穆康 on 16/7/21.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIView *fourView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"bird.png"];
    
    [self addSpriteImage:image withContentsRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.oneView.layer];
    [self addSpriteImage:image withContentsRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.twoView.layer];
    [self addSpriteImage:image withContentsRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.threeView.layer];
    [self addSpriteImage:image withContentsRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.fourView.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentsRect:(CGRect)rect toLayer:(CALayer *)layer {
    
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    
    layer.contentsRect = rect;
}

/*
 点 —— 在iOS和Mac OS中最常见的坐标体系。点就像是虚拟的像素，也被称作逻辑像素。在标准设备上，一个点就是一个像素，但是在Retina设备上，一个点等于2*2个像素。iOS用点作为屏幕的坐标测算体系就是为了在Retina设备和普通设备上能有一致的视觉效果。
 像素 —— 物理像素坐标并不会用来屏幕布局，但是仍然与图片有相对关系。UIImage是一个屏幕分辨率解决方案，所以指定点来度量大小。但是一些底层的图片表示如CGImage就会使用像素，所以你要清楚在Retina设备和普通设备上，他们表现出来了不同的大小。
 单位 —— 对于与图片大小或是图层边界相关的显示，单位坐标是一个方便的度量方式， 当大小改变的时候，也不需要再次调整。单位坐标在OpenGL这种纹理坐标系统中用得很多，Core Animation中也用到了单位坐标。
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
