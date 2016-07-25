//
//  ViewController.m
//  10-图层蒙版
//
//  Created by 穆康 on 16/7/25.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"bird.png"];
    self.imageView.layer.contents = (__bridge id)image.CGImage;
    
    CALayer *maskLayer = [[CALayer alloc] init];
    maskLayer.frame = self.imageView.layer.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"black-star.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    // apply mask to image layer￼
    self.imageView.layer.mask = maskLayer;
}

/**
 
 *  CALayer有一个属性叫做mask。这个属性本身就是个CALayer类型，有和其他图层一样的绘制和布局属性。它类似于一个子图层，相对于父图层（即拥有该属性的图层）布局，但是它却不是一个普通的子图层。不同于那些绘制在父图层中的子图层，mask图层定义了父图层的部分可见区域。
 
 *  mask图层的Color属性是无关紧要的，真正重要的是图层的轮廓。mask属性就像是一个饼干切割机，mask图层实心的部分会被保留下来，其他的则会被抛弃。
 
 *  如果mask图层比父图层要小，只有在mask图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。
 
 *  CALayer蒙板图层真正厉害的地方在于蒙板图不局限于静态图。任何有图层构成的都可以作为mask属性，这意味着你的蒙板可以通过代码甚至是动画实时生成。
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
