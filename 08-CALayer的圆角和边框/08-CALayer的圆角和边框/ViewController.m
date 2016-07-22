//
//  ViewController.m
//  08-CALayer的圆角和边框
//
//  Created by 穆康 on 16/7/22.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView1;
@property (weak, nonatomic) IBOutlet UIView *layerView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test02];
}


/**
 *  CALayer有一个叫做conrnerRadius的属性控制着图层角的曲率。
 *  它是一个浮点数，默认为0（为0的时候就是直角），但是你可以把它设置成任意值。
 *  默认情况下，这个曲率值只影响背景颜色而不影响背景图片或是子图层。
 *  不过，如果把masksToBounds设置成YES的话，图层里面的所有东西都会被截取。
 */
- (void)test01 {
    
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    self.layerView2.layer.masksToBounds = YES;
}

/**
 *  borderWidth是以点为单位的定义边框粗细的浮点数，默认为0。borderColor定义了边框的颜色，默认为黑色。
 *  边框是绘制在图层边界里面的，而且在所有子内容之前，也在子图层之前。
 *  边框是跟随图层的边界变化的，而不是图层里面的内容。
 */
- (void)test02 {
    
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView2.layer.cornerRadius = 20.0f;
    
    self.layerView1.layer.borderWidth = 2.0f;
    self.layerView2.layer.borderWidth = 2.0f;
    
    self.layerView2.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
