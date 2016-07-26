//
//  ViewController.m
//  12-仿射变换
//
//  Created by 穆康 on 16/7/26.
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
    
    UIImage *image = [UIImage imageNamed:@"bird.png"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
    
    [self test2];
}

- (void)test1 {
    // rotate the layer 45 degrees
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerView.layer.affineTransform = transform;
}

- (void)test2 {
    // create a new transform
    CGAffineTransform transform = CGAffineTransformIdentity;
    // scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    // rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 6.0);
    // translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    // apply transform to layer
    self.layerView.layer.affineTransform = transform;
}

/**
 
 *  CGAffineTransform中的“仿射”的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行，CGAffineTransform可以做出任意符合上述标注的变换。
 
 *  Core Graphics提供了一系列函数，对完全没有数学基础的开发者也能够简单地做一些变换。如下几个函数都创建了一个CGAffineTransform实例：
    CGAffineTransformMakeRotation(CGFloat angle)
    CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)
    CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)
 
 *  UIView可以通过设置transform属性做变换，但实际上它只是封装了内部图层的变换。
 
 *  CALayer同样也有一个transform属性，但它的类型是CATransform3D，而不是CGAffineTransform。CALayer对应于UIView的transform属性叫做affineTransform。
 
 *  Core Graphics提供了一系列的函数可以在一个变换的基础上做更深层次的变换，如果做一个既要缩放又要旋转的变换，这就会非常有用了。例如下面几个函数：
    CGAffineTransformRotate(CGAffineTransform t, CGFloat angle)
    CGAffineTransformScale(CGAffineTransform t, CGFloat sx, CGFloat sy)
    CGAffineTransformTranslate(CGAffineTransform t, CGFloat tx, CGFloat ty)
 
 *  当操纵一个变换的时候，初始生成一个什么都不做的变换很重要--也就是创建一个CGAffineTransform类型的空值，矩阵论中称作单位矩阵，Core Graphics同样也提供了一个方便的常量：CGAffineTransformIdentity
 
 *  如果需要混合两个已经存在的变换矩阵，就可以使用如下方法，在两个变换的基础上创建一个新的变换：CGAffineTransformConcat(CGAffineTransform t1, CGAffineTransform t2)
 
 *  test2中有些需要注意的地方：图片向右边发生了平移，但并没有指定距离那么远（200像素），另外它还有点向下发生了平移。原因在于当你按顺序做了变换，上一个变换的结果将会影响之后的变换，所以200像素的向右平移同样也被旋转了30度，缩小了50%，所以它实际上是斜向移动了100像素。这意味着变换的顺序会影响最终的结果，也就是说旋转之后的平移和平移之后的旋转结果可能不同。
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
