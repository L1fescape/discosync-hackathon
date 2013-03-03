//
//  DSAppDelegate.m
//  DiscoSyncStreamer
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSAppDelegate.h"
#import "Novocaine.h"
#import "DSNovocainChunkStringer.h"

@interface DSAppDelegate ()

@property (nonatomic, strong) Novocaine *audioManager;
@property (nonatomic, strong) DSNovocainChunkStringer *stringer;

@end

@implementation DSAppDelegate

- (Novocaine *)audioManager {
	if (!_audioManager) {
		NSLog(@"Creading audio manager");
		_audioManager = [Novocaine audioManager];
	}
	return _audioManager;
}

- (DSNovocainChunkStringer *)stringer {
	if (!_stringer) {
		NSLog(@"Creading chunk stringer");
		_stringer = [DSNovocainChunkStringer new];
	}
	return _stringer;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	NSLog(@"App launched, fool.");

/*
	// Create a reference to a Firebase location
	Firebase* f1 = [[Firebase alloc] initWithUrl:@"https://vikrum.firebaseio.com/"];
	
	// Write data to Firebase
	[f1 set:@"Do you have data? You'll love Firebase."];
*/

}

- (IBAction)startRecording:(id)sender {
	// AUDIO SOMETHING WRITING YEAH!
	// ========================================
	
	__block int totalSamples = 0;
	self.audioManager.inputBlock = ^(float *data, UInt32 numFrames, UInt32 numChannels) {
		// [fileWriter writeNewAudio:data numFrames:numFrames numChannels:numChannels];
		[self.stringer stringNewAudio:data numFrames:numFrames numChannels:numChannels];
		int numSamples = numFrames/numChannels;
		float samplesPerSec = self.audioManager.samplingRate/numChannels;
		totalSamples += numSamples;
		if (totalSamples % (int)samplesPerSec == 0) {
			NSLog(@"Counter: %i. Number of samples/second: %f. Sampling rate: %f.", totalSamples, samplesPerSec, self.audioManager.samplingRate);
			NSLog(@"NumFrames: %d, numChannels: %d. NumSamples: %i", numFrames, numChannels, numSamples);
		}
		if (totalSamples > 10 * samplesPerSec) { // 10 seconds of recording
			//if (totalSamples > 1000) { // 10 seconds of
			NSLog(@"I think we're done recording?");
			self.audioManager.inputBlock = nil;
		}
	};
}

- (IBAction)stopRecording:(id)sender {
	// AUDIO SOMETHING READING COOL!
	// ========================================
	// __block int counter = 0;
	[self.audioManager setOutputBlock:^(float *data, UInt32 numFrames, UInt32 numChannels) {
		[self.stringer destringNewAudio:data numFrames:numFrames numChannels:numChannels];
	}];
}
@end
