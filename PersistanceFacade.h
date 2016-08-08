//
//  PersistanceFacade.h
//  ToDo List
//
//  Created by павел on 14/07/16.
//  Copyright © 2016 павел. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEvent.h"

@interface PersistanceFacade : NSObject

+ (id)sharedManager;

- (NSArray*)loadAllEvents;
- (void)addEvent:(MyEvent*)event;

@end
