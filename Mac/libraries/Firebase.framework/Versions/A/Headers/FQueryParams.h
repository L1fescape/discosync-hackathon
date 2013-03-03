//
//  FQueryParams.h
//  Firebase
//
//  Created by Greg Soltis on 1/24/13.
//
//

#import <Foundation/Foundation.h>

@interface FQueryParams : NSObject <NSCopying>

-(void) setStartPriority:(id) priority;
-(void) setStartPriority:(id)priority andName:(NSString *) name;

-(void) setEndPriority:(id) priority;
-(void) setEndPriority:(id)priority andName:(NSString *) name;

-(void) setLimit:(NSInteger) limit;
@end
