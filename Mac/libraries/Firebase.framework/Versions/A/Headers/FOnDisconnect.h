//
//  FOnDisconnect.h
//  Firebase
//
//  Created by Greg Soltis on 2/18/13.
//
//

#import <Foundation/Foundation.h>

@interface FOnDisconnect : NSObject

- (void) cancel;
- (void) cancelWithOnComplete:(void (^)(NSError*))onComplete;
- (void) remove;
- (void) removeWithOnComplete:(void (^)(NSError*))onComplete;
- (void) set:(id)value;
- (void) set:(id)value withOnComplete:(void (^)(NSError*))onComplete;
- (void) set:(id)value andPriority:(id)priority;
- (void) set:(id)value andPriority:(id)priority withOnComplete:(void (^)(NSError*))onComplete;
- (void) update:(NSDictionary *)value;
- (void) update:(NSDictionary *)value withOnComplete:(void (^)(NSError*))onComplete;

@end
