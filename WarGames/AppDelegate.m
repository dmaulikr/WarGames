//
//  AppDelegate.m
//  WarGames
//
//  Created by Andre Cardozo on 2/15/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "AppDelegate.h"
#include <IOKit/IOKitLib.h>

#import "HIDThing.h"



@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  
  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  
  NSBundle* bundle = [NSBundle mainBundle];
  
  statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon" ofType:@"png"]];
  
  [statusItem setImage:statusImage];
  [statusItem setToolTip:@"Hello"];

  [statusItem setMenu:statusMenu];
  

  
  xmlManager = [[XMLManager alloc] init];
  thing = [[HIDThing alloc] init];
  
  
  [xmlManager requestAndParseXML];

  
  [thing check_hid];

}

- (IBAction) status:(id)sender {

  NSLog(@"status");
  
  [thing on];
  
}


- (IBAction) move:(id)sender {

  NSLog(@"move");
  
  [thing off];
  
}


@end
