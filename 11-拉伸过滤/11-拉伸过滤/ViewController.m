//
//  ViewController.m
//  11-拉伸过滤
//
//  Created by 穆康 on 16/7/25.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *digitViews;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *digitImage = [UIImage imageNamed:@"digit.png"];
    
    for (UIView *view in self.digitViews) {
        view.layer.contents = (__bridge id)digitImage.CGImage;
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1);
        view.layer.contentsGravity = kCAGravityResizeAspect;
        view.layer.magnificationFilter = kCAFilterNearest;
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self tick];
}

- (void)setDigit:(NSInteger)digit forView:(UIView *)view {
    // adjust contentsRect to select correct digit
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1);
}

- (void)tick {
    
    // convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    // set hours
    [self setDigit:components.hour / 10 forView:self.digitViews[0]];
    [self setDigit:components.hour % 10 forView:self.digitViews[1]];
    
    // set minutes
    [self setDigit:components.minute / 10 forView:self.digitViews[2]];
    [self setDigit:components.minute % 10 forView:self.digitViews[3]];
    
    // set seconds
    [self setDigit:components.second / 10 forView:self.digitViews[4]];
    [self setDigit:components.second % 10 forView:self.digitViews[5]];
}

/**
 
 *  CALayer的两个属性minificationFilter和magnificationFilter。
 
 *  CALayer为此提供了三种拉伸过滤方法：kCAFilterLinear、kCAFilterNearest和kCAFilterTrilinear。
 
 *  minification（缩小图片）和magnification（放大图片）默认的过滤器都是kCAFilterLinear，这个过滤器采用双线性滤波算法，它在大多数情况下都表现良好。双线性滤波算法通过对多个像素取样最终生成新的值，得到一个平滑的表现不错的拉伸。但是当放大倍数比较大的时候图片就模糊不清了。
 
 *  kCAFilterTrilinear和kCAFilterLinear非常相似，大部分情况下二者都看不出来有什么差别。但是，较双线性滤波算法而言，三线性滤波算法存储了多个大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进而得到最后的结果。这个方法的好处在于算法能够从一系列已经接近于最终大小的图片中得到想要的结果，也就是说不要对很多像素同步取样。这不仅提高了性能，也避免了小概率因舍入错误引起的取样失灵的问题。
 
 *  kCAFilterNearest是一种比较武断的方法。从名字不难看出，这个算法（也叫最近过滤）就是取样最近的单像素点而不管其他的颜色。这样做非常快，也不会使图片模糊。但是，最明显的效果就是，会使得压缩图片更糟，图片放大之后也显得块状或是马赛克严重。
 
 *  总的来说，对于比较小的图或者是差异特别明显，极少斜线的大图，最近过滤算法会保留这种差异明显的特质以呈现更好的结果。但是对于大多数的图尤其是有很多斜线或是曲线轮廓的图片来说，最近过滤算法会导致更差的结果。换句话说，线性过滤保留了形状，最近过滤则保留了像素的差异。
 
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
