//
//  PersistanceFacade.m
//  ToDo List
//
//  Created by павел on 14/07/16.
//  Copyright © 2016 павел. All rights reserved.
//

#import "PersistanceFacade.h"

@interface PersistanceFacade ()

@property (nonatomic, strong) NSMutableArray* events;

@end

@implementation PersistanceFacade

#pragma mark Singleton Methods

+ (id)sharedManager {
    static PersistanceFacade *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.events = [NSMutableArray new];
    }
    return self;
}

- (NSArray*)loadAllEvents {
    return self.events;
}

- (void)addEvent:(MyEvent*)event {
    //TODO: save event
    if (event != nil) {
        [self.events addObject:event];
    }
}

@end
