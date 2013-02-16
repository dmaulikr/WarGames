//
//  AppDelegate.h
//  WarGames
//
//  Created by Andre Cardozo on 2/15/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HIDThing.h"

@interface AppDelegate : NSObject <NSApplicationDelegate> {
  IBOutlet NSMenu* statusMenu;
  NSStatusItem* statusItem;
  NSImage* statusImage;
  
  HIDThing* thing;

}

- (IBAction) status:(id)sender;
- (IBAction) move:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
