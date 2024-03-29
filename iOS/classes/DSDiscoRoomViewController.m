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

@property (nonatomic, strong) AudioStreamer *streamer;

- (BOOL)targetURLIsValid:(NSURL *)targetURL;

@end

@implementation DSDiscoRoomViewController

- (NSString *)roomName {
	return self.firebase.name;
}

- (void)setFirebase:(Firebase *)firebase {
	_firebase = firebase;
	[_firebase on:FEventTypeValue doCallback:^(FDataSnapshot *snapshot) {
		[self performSelectorOnMainThread:@selector(setLatestSnapshotDict:) withObject:snapshot.val waitUntilDone:NO];
	}];
}

- (void)setLatestSnapshotDict:(NSDictionary *)latestSnapshotDict {
	if (!_latestSnapshotDict) {
		_latestSnapshotDict = [latestSnapshotDict mutableCopy];
	}
	else {
		// crash is here, check for dict
		if ([latestSnapshotDict isKindOfClass:[NSDictionary class]]) {
			[_latestSnapshotDict addEntriesFromDictionary:latestSnapshotDict];
		}
	}
	[self updateDisplay];
}

- (void)setTargetURL:(NSURL *)targetURL {
	NSLog(@"setTargetURL: %@", [targetURL absoluteString]);
	if ([self targetURLIsValid:targetURL] && ![[_targetURL absoluteString] isEqualToString:[targetURL absoluteString]]) {
		NSLog(@"targetURL has changed to %@", [targetURL absoluteString]);
		_targetURL = targetURL;
		// restart the stream, the URL has changed
		BOOL wasPlaying = self.streamer.isPlaying;
		[self setupStreamer];
		if (wasPlaying) {
			NSLog(@"play stream");
			[self.streamer start];
		}
	}
}

- (BOOL)targetURLIsValid:(NSURL *)targetURL {
	NSString *urlString = [targetURL absoluteString];
	NSLog(@"checking substring %@", [urlString substringToIndex:7]);
	if (urlString.length && [[urlString substringToIndex:7] isEqualToString:@"http://"]) {
		return YES;
	}
	return NO;
}

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
		_DJName.numberOfLines = 0;
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

- (UILabel *)listenerCount {
	if (!_listenerCount) {
		_listenerCount = [[UILabel alloc] initWithFrame:CGRectMake(8, 176, 320, 140)];
		_listenerCount.backgroundColor = [UIColor clearColor];
		_listenerCount.textColor = [UIColor whiteColor];
		_listenerCount.font = [UIFont systemFontOfSize:28.0f];
		_listenerCount.shadowColor = [UIColor blackColor];
		_listenerCount.shadowOffset = CGSizeMake(0,1);
	}
	return _listenerCount;
}

- (void)viewDidLoad {
	NSLog(@"Disco room didload");
    [super viewDidLoad];
	[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-logo"]]];
	
	[self.view addSubview:self.backgroundView];
	[self.view addSubview:self.DJName];
	[self.view addSubview:self.genre];
	[self.view addSubview:self.listenerCount];
	[self configureLabels];
	
	//Set up streamer and start pulling audio
	[self setupStreamer];
	NSLog(@"view didload ended");
}

- (void)viewWillAppear:(BOOL)animated {
	NSLog(@"room will appear");
	[self.streamer start];
	int listeners = [[self.latestSnapshotDict valueForKey:@"listeners"] intValue] + 1;
	NSLog(@"Listeners: %@ => %i", [self.latestSnapshotDict valueForKey:@"listeners"], listeners);
	[self.firebase update:@{@"listeners": [NSNumber numberWithInt:listeners]}];

}

- (void)viewWillDisappear:(BOOL)animated {
	NSLog(@"room will dissapear");
	[self.streamer stop];
	int listeners = [[self.latestSnapshotDict valueForKey:@"listeners"] intValue] - 1;
	if (listeners >= 0) {
		NSLog(@"Decrementing listeners to %i", listeners);
		[self.firebase update:@{@"listeners": [NSNumber numberWithInt:listeners]}];
	}
}

- (void)setupStreamer {
	if ([self targetURLIsValid:self.targetURL]) {
		self.streamer = [[AudioStreamer alloc] initWithURL:self.targetURL];
	}
}

- (void)configureLabels {
	[self.DJName sizeToFit];
	[self.genre sizeToFit];
	[self.listenerCount sizeToFit];

	CGRect DJRect = self.DJName.frame;
	CGRect genreRect = self.genre.frame;
	CGRect listenersRect = self.listenerCount.frame;

	genreRect.origin.y = DJRect.origin.y + DJRect.size.height - 8;
	self.genre.frame = genreRect;

	listenersRect.origin.y = genreRect.origin.y + genreRect.size.height;
	self.listenerCount.frame = listenersRect;
}

- (void)updateDisplay {
	self.DJName.text = [self.latestSnapshotDict valueForKey:@"name"];
	self.genre.text = [self.latestSnapshotDict valueForKey:@"genre"];
	self.listenerCount.text = [[NSString stringWithFormat:@"%@", [self.latestSnapshotDict valueForKey:@"listeners"]] stringByAppendingString:@" listening"];
	self.targetURL = [NSURL URLWithString:[self.latestSnapshotDict valueForKey:@"songurl"]];
	[self.DJName sizeToFit];
	[self.genre sizeToFit];
	[self.listenerCount sizeToFit];
}

@end
