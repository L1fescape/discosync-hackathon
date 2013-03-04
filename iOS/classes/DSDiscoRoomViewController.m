//
//  DSDiscoRoomViewController.m
//  DiscoSync
//
//  Created by Neal Ormsbee on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSDiscoRoomViewController.h"
#import <Firebase/Firebase.h>

@interface DSDiscoRoomViewController ()

@end

@implementation DSDiscoRoomViewController

- (UIImageView *)backgroundView {
	if (!_backgroundView) {
		_backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	}
	return _backgroundView;
}

- (UILabel *)DJName {
	if (!_DJName) {
		_DJName = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 320, 120)];
		_DJName.backgroundColor = [UIColor clearColor];
		_DJName.textColor = [UIColor whiteColor];
		_DJName.font = [UIFont boldSystemFontOfSize:48.0f];
		_DJName.numberOfLines = 2;
		_DJName.shadowColor = [UIColor blackColor];
		_DJName.shadowOffset = CGSizeMake(0, 1);
		_DJName.lineBreakMode = NSLineBreakByWordWrapping;
	}
	return _DJName;
}

- (UILabel *)genre {
	if (!_genre) {
		_genre = [[UILabel alloc] initWithFrame:CGRectMake(8, 128, 320, 40)];
		_genre.backgroundColor = [UIColor clearColor];
		_genre.textColor = [UIColor whiteColor];
		_genre.font = [UIFont italicSystemFontOfSize:32.0f];
		_genre.shadowColor = [UIColor blackColor];
		_genre.shadowOffset = CGSizeMake(0,1);
	}
	return _genre;
}

- (UILabel *)listeners {
	if (!_listeners) {
		_listeners = [[UILabel alloc] initWithFrame:CGRectMake(8, 176, 320, 40)];
		_listeners.backgroundColor = [UIColor clearColor];
		_listeners.textColor = [UIColor whiteColor];
		_listeners.font = [UIFont systemFontOfSize:28.0f];
		_listeners.shadowColor = [UIColor blackColor];
		_listeners.shadowOffset = CGSizeMake(0,1);
	}
	return _listeners;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Now Playing";
	
	[self.view addSubview:self.backgroundView];
	[self.view addSubview:self.DJName];
	[self.view addSubview:self.genre];
	[self.view addSubview:self.listeners];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
