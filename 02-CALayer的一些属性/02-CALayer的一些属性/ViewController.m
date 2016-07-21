//
//  ViewController.m
//  02-CALayer的一些属性
//
//  Created by 穆康 on 16/7/21.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test04];
}

- (void)test01 { // contents
    
    UIImage *image = [UIImage imageNamed:@"logo_login@3x.png"];
    
    /*
     CALayer 有一个属性叫做contents，这个属性的类型被定义为id，意味着它可以是任何类型的对象。在这种情况下，你可以给contents属性赋任何值，你的app仍然能够编译通过。但是，在实践中，如果你给contents赋的不是CGImage，那么你得到的图层将是空白的。
     contents这个奇怪的表现是由Mac OS的历史原因造成的。它之所以被定义为id类型，是因为在Mac OS系统上，这个属性对CGImage和NSImage类型的值都起作用。如果你试图在iOS平台上将UIImage的值赋给它，只能得到一个空白的图层。一些初识Core Animation的iOS开发者可能会对这个感到困惑。
    头疼的不仅仅是我们刚才提到的这个问题。事实上，你真正要赋值的类型应该是CGImageRef，它是一个指向CGImage结构的指针。UIImage有一个CGImage属性，它返回一个"CGImageRef",如果你想把这个值直接赋值给CALayer的contents，那你将会得到一个编译错误。因为CGImageRef并不是一个真正的Cocoa对象，而是一个Core Foundation类型。
     尽管Core Foundation类型跟Cocoa对象在运行时貌似很像（被称作toll-free bridging），他们并不是类型兼容的，不过你可以通过bridged关键字转换。
     */
    self.layerView.layer.contents = (__bridge id)image.CGImage;
}

- (void)test02 { // contentGravity
    
    UIImage *image = [UIImage imageNamed:@"logo_login@3x.png"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
}

- (void)test03 { // contentsScale
    
    UIImage *image = [UIImage imageNamed:@"logo_login@3x.png"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    
    self.layerView.layer.contentsScale = image.scale;
}

- (void)test04 { // maskToBounds
    
    UIImage *image = [UIImage imageNamed:@"logo_login@3x.png"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    
    self.layerView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
