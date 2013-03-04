//
//  DSNovocainChunkStringer.h
//  DiscoSyncStreamer
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSNovocainChunkStringer : NSObject

// Methods to manipulate the bad data structure
- (void)addObject:(id)object;
- (id)removeFirstObject;

- (void)stringNewAudio:(float *)newData numFrames:(UInt32)thisNumFrames numChannels:(UInt32)thisNumChannels;
- (void)destringNewAudio:(float *)newData numFrames:(UInt32)thisNumFrames numChannels:(UInt32)thisNumChannels;
@end
