//
//  ViewController.m
//  05-锚点
//
//  Created by 穆康 on 16/7/21.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *hourHand;
@property (weak, nonatomic) IBOutlet UIImageView *minuteHand;
@property (weak, nonatomic) IBOutlet UIImageView *secondHand;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.hourHand.layer.anchorPoint = CGPointMake(0.5, 0.75);
    self.minuteHand.layer.anchorPoint = CGPointMake(0.5, 0.79);
    self.secondHand.layer.anchorPoint = CGPointMake(0.5, 0.83);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    
    [self tick];
}

- (void)tick {
    
    // convert time to hours, minutes and seconds
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    
    self.hourHand.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minuteHand.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secondHand.transform = CGAffineTransformMakeRotation(secondAngle);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
