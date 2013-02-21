//
//  Queue.h
//  WarGames
//
//  Created by Andre Cardozo on 2/20/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

- (void) enqueue: (id)item;
- (id) dequeue;
- (id) peek;

@end