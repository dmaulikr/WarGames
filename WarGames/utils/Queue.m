//
//  Queue.m
//  WarGames
//
//  Created by Andre Cardozo on 2/20/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "Queue.h"

@implementation NSMutableArray (Queue)

- (void) enqueue: (id)item {
  [self addObject:item];
}

- (id) dequeue {
  id item = nil;
  if ([self count] != 0) {
    item = [self objectAtIndex:0];
    [self removeObjectAtIndex:0];
  }
  return item;
}

- (id) peek {
  id item = nil;
  if ([self count] != 0) {
    item = [self objectAtIndex:0];
  }
  return item;
}

@end