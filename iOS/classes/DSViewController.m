//
//  DSViewController.m
//  DiscoSync
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSViewController.h"
#import "DSDiscoRoomViewController.h"

@interface DSViewController ()

@end

@implementation DSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(140, 220, 40, 40)];
	button.titleLabel.text = @"enter room";
	[button addTarget:self action:@selector(pushDiscoRoom) forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor greenColor];
	[self.view addSubview:button];
}

- (void)pushDiscoRoom {
	DSDiscoRoomViewController *room = [[DSDiscoRoomViewController alloc] init];
	[self presentModalViewController:room animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
