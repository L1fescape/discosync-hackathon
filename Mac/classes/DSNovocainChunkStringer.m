//
//  DSNovocainChunkStringer.m
//  DiscoSyncStreamer
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSNovocainChunkStringer.h"

@interface DSNovocainChunkStringer ()

@property (nonatomic, strong) NSMutableArray *chunkQueue;

- (void)sendJSONToServer:(NSData *)jsonData;

@end

@implementation DSNovocainChunkStringer

- (NSMutableArray *)chunkQueue {
	if (!_chunkQueue) {
		NSLog(@"Creating chunk queue");
		_chunkQueue = [NSMutableArray arrayWithCapacity:10];
	}
	return _chunkQueue;
}

- (void)addObject:(id)object {
	[self.chunkQueue addObject:object];
}

- (id)removeFirstObject {
	id object = [self.chunkQueue objectAtIndex:0];
	[self.chunkQueue removeObjectAtIndex:0];
	return object;
}

- (void)stringNewAudio:(float *)newData numFrames:(UInt32)thisNumFrames numChannels:(UInt32)thisNumChannels {
	// Chunk the metadata
	NSMutableDictionary *audioChunk = [NSMutableDictionary dictionaryWithCapacity:10];
	[audioChunk setValue:[NSNumber numberWithInt:thisNumChannels] forKey:@"numChannels"];
	[audioChunk setValue:[NSNumber numberWithInt:thisNumFrames] forKey:@"numFrames"];

	// Chunk the data
	NSMutableArray *audioArray = [NSMutableArray arrayWithCapacity:thisNumFrames];
	for (int i = 0; i < thisNumFrames; i++) {
		NSNumber *data = [NSNumber numberWithFloat:newData[i]];
		[self.chunkQueue addObject:data];
		[audioArray addObject:data];
	}
	[audioChunk setValue:audioArray forKey:@"data"];

	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:audioChunk options:NSJSONWritingPrettyPrinted error:nil];
	[self sendJSONToServer:jsonData];

	// [self.chunkQueue addObjectsFromArray:audioArray];
	// NSLog(@"JSON data: %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

- (void)destringNewAudio:(float *)newData numFrames:(UInt32)thisNumFrames numChannels:(UInt32)thisNumChannels {
	NSData *jsonData = [self.chunkQueue objectAtIndex:0];
	if (!jsonData) {
		NSLog(@"Buffer is empty!");
		return;
	}
	[self.chunkQueue removeObjectAtIndex:0];
	NSDictionary *chunkData = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
	NSArray *audioArray = [chunkData objectForKey:@"data"];

	/*if ([audioArray count] != thisNumFrames) {
		NSLog(@"Audio array does not have the right number of frames. we might be in trouble. Requested: %i, have: %li", thisNumFrames, (unsigned long)[audioArray count]);
	}*/

	for (int i = 0; i < thisNumFrames; i++) {
		newData[i] = [(NSNumber *)[audioArray objectAtIndex:i] floatValue];
	}

}

- (void)sendJSONToServer:(NSData *)jsonData {
	NSString *urlString = @"https://disco-sync.firebaseio.com/stream.json";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
	[request setHTTPBody:jsonData];
	[NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		if (error) {
			NSLog(@"Error. %@", error);
		}
	}];
}

@end
