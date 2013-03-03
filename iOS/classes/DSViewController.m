//
//  DSViewController.m
//  DiscoSync
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSViewController.h"
#import "DSDiscoRoomViewController.h"
#import "SocketIO.h" //@TODO: Remove this

@interface DSViewController ()

@end

@implementation DSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Set style and title for the nav bar
	self.navigationItem.title = @"Now Playing";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
