//
//  DemoOneViewController.m
//  13-3D变换
//
//  Created by 穆康 on 16/7/26.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "DemoOneViewController.h"

@interface DemoOneViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation DemoOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"bird.png"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
    
    [self test03];
}

- (void)test01 {
    // rotate the layer 45 degrees along the Y axis
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
}

- (void)test02 {
    // create a new transform
    CATransform3D transform = CATransform3DIdentity;
    // apply perspective
    transform.m34 = - 1.0 / 500.0;
    // rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    // apply to layer
    self.layerView.layer.transform = transform;
}

- (void)test03 {
    // rotate the layer 45 degrees along the Y axis
    CATransform3D transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    self.layerView.layer.transform = transform;
//    self.layerView.layer.doubleSided = NO;
}

/**
 
 *  CG的前缀告诉我们，CGAffineTransform类型属于Core Graphics框架，Core Graphics实际上是一个严格意义上的2D绘图API，并且CGAffineTransform仅仅对2D变换有效。
 
 *  zPosition属性，可以用来让图层靠近或者远离相机（用户视角），transform属性（CATransform3D类型）可以真正做到这点，即让图层在3D空间内移动或者旋转。
 
 *  和CGAffineTransform类似，CATransform3D也是一个矩阵，但是和2x3的矩阵不同，CATransform3D是一个可以在3维空间内做变换的4x4的矩阵。
 
 *  和CGAffineTransform矩阵类似，Core Animation提供了一系列的方法用来创建和组合CATransform3D类型的矩阵，和Core Graphics的函数类似，但是3D的平移和旋转多处了一个z参数，并且旋转函数除了angle之外多出了x,y,z三个参数，分别决定了每个坐标轴方向上的旋转：
    --------------------------------------------------------------------------
    CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
    --------------------------------------------------------------------------
    CATransform3DMakeScale(CGFloat sx, CGFloat sy, CGFloat sz)
    --------------------------------------------------------------------------
    CATransform3DMakeTranslation(Gloat tx, CGFloat ty, CGFloat tz)
    --------------------------------------------------------------------------
 
 *  你应该对X轴和Y轴比较熟悉了，分别以右和下为正方向（这是iOS上的标准结构，在Mac OS，Y轴朝上为正方向），Z轴和这两个轴分别垂直，指向视角外为正方向。
 
 *  绕Z轴的旋转等同于之前二维空间的仿射旋转，但是绕X轴和Y轴的旋转就突破了屏幕的二维空间，并且在用户视角看来发生了倾斜。
 
 *  在-test01中，看起来图层并没有被旋转，而是仅仅在水平方向上的一个压缩，是哪里出了问题呢？其实完全没错，视图看起来更窄实际上是因为我们在用一个斜向的视角看它，而不是透视。
 
 ******************************************************************************
 
 *  在真实世界中，当物体远离我们的时候，由于视角的原因看起来会变小，理论上说远离我们的视图的边要比靠近视角的边跟短，但实际上并没有发生，而我们当前的视角是等距离的，也就是在3D变换中任然保持平行，和之前提到的仿射变换类似。
 
 *  为了做一些修正，我们需要引入投影变换（又称作z变换）来对除了旋转之外的变换矩阵做一些修改，Core Animation并没有给我们提供设置透视变换的函数，因此我们需要手动修改矩阵值，幸运的是，很简单：CATransform3D的透视效果通过一个矩阵中一个很简单的元素来控制：m34。m34用于按比例缩放X和Y的值来计算到底要离视角多远。
 
 *  m34的默认值是0，我们可以通过设置m34为-1.0 / d来应用透视效果，d代表了想象中视角相机和屏幕之间的距离，以像素为单位，那应该如何计算这个距离呢？实际上并不需要，大概估算一个就好了。
 
 *  因为视角相机实际上并不存在，所以可以根据屏幕上的显示效果自由决定它的防止的位置。通常500-1000就已经很好了，但对于特定的图层有时候更小后者更大的值会看起来更舒服，减少距离的值会增强透视效果，所以一个非常微小的值会让它看起来更加失真，然而一个非常大的值会让它基本失去透视效果。
 
 ******************************************************************************
 
 * 背面
 
 * 我们既然可以在3D场景下旋转图层，那么也可以从背面去观察它。如果我们在-test03中把角度修改为M_PI（180度）而不是当前的M_PI_4（45度），那么将会把图层完全旋转一个半圈，于是完全背对了相机视角。
 
 *  如你所见，图层是双面绘制的，反面显示的是正面的一个镜像图片。
 
 *  但这并不是一个很好的特性，因为如果图层包含文本或者其他控件，那用户看到这些内容的镜像图片当然会感到困惑。另外也有可能造成资源的浪费：想象用这些图层形成一个不透明的固态立方体，既然永远都看不见这些图层的背面，那为什么浪费GPU来绘制它们呢？
 
 *  CALayer有一个叫做doubleSided的属性来控制图层的背面是否要被绘制。这是一个BOOL类型，默认为YES，如果设置为NO，那么当图层正面从相机视角消失的时候，它将不会被绘制。
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
