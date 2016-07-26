//
//  DemoTwoViewController.m
//  13-3D变换
//
//  Created by 穆康 on 16/7/26.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "DemoTwoViewController.h"

@interface DemoTwoViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *layerView01;
@property (weak, nonatomic) IBOutlet UIView *layerView02;


@end

@implementation DemoTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"bird.png"];
    self.layerView01.layer.contents = (__bridge id)image.CGImage;
    self.layerView01.layer.contentsGravity = kCAGravityResizeAspect;
    self.layerView02.layer.contents = (__bridge id)image.CGImage;
    self.layerView02.layer.contentsGravity = kCAGravityResizeAspect;
    
    // apply perspective transform to container
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.containerView.layer.sublayerTransform = perspective;
    // rotate layerView01 by 45 degrees along the Y axis
    CATransform3D transform01 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView01.layer.transform = transform01;
    // rotate layerView02 by -45 degrees along the Y axis
    CATransform3D transform02 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layerView02.layer.transform = transform02;
}

/**
 
 *  如果有多个视图或者图层，每个都做3D变换，那就需要分别设置相同的m34值，并且确保在变换之前都在屏幕中央共享同一个position，如果用一个函数封装这些操作的确会更加方便，但仍然有限制（例如，你不能在Interface Builder中摆放视图），这里有一个更好的方法。
 
 *  CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，但和对一个图层的变换不同，它影响到所有的子图层。这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法。
 
 *  相较而言，通过在一个地方设置透视变换会很方便，同时它会带来另一个显著的优势：灭点被设置在容器图层的中点，从而不需要再对子图层分别设置了。这意味着你可以随意使用position和frame来放置子图层，而不需要把它们放置在屏幕中点，然后为了保证统一的灭点用变换来做平移。
 
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
