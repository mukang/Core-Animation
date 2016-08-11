//
//  ViewController.m
//  16-CATextLayer
//
//  Created by 穆康 on 16/7/28.
//  Copyright © 2016年 穆康. All rights reserved.
//

#import "ViewController.h"
#import "LayerLabel.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *labelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test03];
}

- (void)test01 {
    
    // create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    // set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    // choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    // set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    // choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    // set layer text
    textLayer.string = text;
}

- (void)test02 {
    
    // create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:textLayer];
    
    // set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    // choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    // choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSDictionary *attribs = @{
                              NSForegroundColorAttributeName: [UIColor blackColor],
                              NSFontAttributeName: font
                              };
    [string addAttributes:attribs range:NSMakeRange(0, string.length)];
    
    attribs = @{
                NSForegroundColorAttributeName: [UIColor redColor],
                NSFontAttributeName: font,
                NSUnderlineStyleAttributeName: @(1)
                };
    [string addAttributes:attribs range:NSMakeRange(6, 5)];
    
    // set layer text
    textLayer.string = string;
}

- (void)test03 {
    
    LayerLabel *label = [[LayerLabel alloc] init];
    label.text = @"this makes our label create a CATextLayer instead of a regular CALayer for its backing layer";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = self.labelView.bounds;
    [self.labelView addSubview:label];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
