//
//  FQuery.h
//  Firebase
//
//  Created by Vikrum Nijjar on 9/4/12.
//
//

#import <Foundation/Foundation.h>
#import "FEventType.h"
#import "FTypedefs.h"

/*
 13 fb.core.view.Change.CHILD_ADDED = "child_added";
 14 fb.core.view.Change.CHILD_REMOVED = "child_removed";
 15 fb.core.view.Change.CHILD_CHANGED = "child_changed";
 16 fb.core.view.Change.CHILD_MOVED = "child_moved";
 17 fb.core.view.Change.VALUE = "value";
 */

@interface FQuery : NSObject

- (id) on:(FEventType)eventType doCallback:(void (^)(FDataSnapshot *))callback;
- (id) on:(FEventType)eventType doCallback:(void (^)(FDataSnapshot *))callback withCancelCallback:(void (^)(void))onCancel;
- (id) on:(FEventType)eventType doCallbackWithPrevName:(void (^)(FDataSnapshot *, NSString *))callback;
- (id) on:(FEventType)eventType doCallbackWithPrevName:(void (^)(FDataSnapshot *, NSString *))callback withCancelCallback:(void (^)(void))onCancel;

- (void) off:(id)handle;
- (void) off;

- (void) once:(FEventType)eventType doCallback:(void (^)(FDataSnapshot *))callback;
- (void) once:(FEventType)eventType doCallback:(void (^)(FDataSnapshot *))callback withCancelCallback:(void (^)(void))onCancel;
- (void) once:(FEventType)eventType doCallbackWithPrevName:(fbt_void_datasnapshot_nsstring)callback;
- (void) once:(FEventType)eventType doCallbackWithPrevName:(fbt_void_datasnapshot_nsstring)callback withCancelCallback:(void (^)(void))onCancel;

@end
