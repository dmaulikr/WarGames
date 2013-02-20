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
  
  NSError *err = nil;
  NSString *path = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"txt"];
  NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
  
  if(!contents) {
    //handle error
  }
  
  // setting[0]: Username
  // setting[1]: Password
  // setting[2]: ci pipeline domain
  // setting[3]: ci pipeline rss feed path
  NSArray* settingsValue = [contents componentsSeparatedByString:@"\n"];
  
  xmlManager = [[XMLManager alloc] init];
  
  [xmlManager setUser:settingsValue[0]];
  [xmlManager setPassword:settingsValue[1]];
  [xmlManager setCiDomain:settingsValue[2]];
  [xmlManager setCiPath:settingsValue[3]];
  
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
