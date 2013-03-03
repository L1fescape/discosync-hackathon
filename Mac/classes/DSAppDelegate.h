//
//  DSAppDelegate.h
//  DiscoSyncStreamer
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)startRecording:(id)sender;
- (IBAction)stopRecording:(id)sender;

@end
