//
//  DSDiscoRoomViewController.m
//  DiscoSync
//
//  Created by Neal Ormsbee on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSDiscoRoomViewController.h"
#import "AudioStreamer.h"

@interface DSDiscoRoomViewController ()

@property (nonatomic, strong) AudioStreamer *audioStreamer;

@end

@implementation DSDiscoRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.audioStreamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:@"http://vipicecast.yacast.net/europe1.mp3"]];
	
	UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(140, 220, 40, 40)];
	playButton.backgroundColor = [UIColor purpleColor];
	
	[playButton addTarget:self action:@selector(playStream) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:playButton];
}

- (void)playStream {
	
	[self.audioStreamer start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
