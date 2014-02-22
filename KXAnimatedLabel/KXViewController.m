//
//  KXViewController.m
//  KXAnimatedLabel
//
//  Created by 桜井雄介 on 2014/02/14.
//  Copyright (c) 2014年 Yusuke Sakurai. All rights reserved.
//

#import "KXViewController.h"

@interface KXViewController ()

@property (weak, nonatomic) IBOutlet KXAnimatedLabel *label;

@end

@implementation KXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.label setFullText:@"あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい森で飾られたモリーオ市、郊外のぎらぎらひかる草の波。"];
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByCharWrapping;
    self.label.duration = 0.1;
    self.label.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.label startAnimation];
}

- (void)labelDidFinishAnimation:(KXAnimatedLabel *)label
{
}

- (void)labelDidTapTwice:(KXAnimatedLabel *)label
{
    [label startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
