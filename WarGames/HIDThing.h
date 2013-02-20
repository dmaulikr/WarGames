//
//  HIDThing.h
//  WarGames
//
//  Created by Andre Cardozo on 2/15/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HIDThing : NSObject

-(void) shootWithCommands:(NSArray*) commands;

- (void) check_hid;

- (void) on;
- (void) off;

@end
