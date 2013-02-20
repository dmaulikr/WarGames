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
  
  usersCommandsDictionary = [NSMutableDictionary new];
  
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
  
  // 5 - length
  int i = 5;
  
  for(i = 5; i < [settingsValue count]; i++){    
    NSString* currentLine = settingsValue[i];
    NSArray* userCommandsValue = [currentLine componentsSeparatedByString:@" "];
    
    // userCommandsValue[0]: user name
    // userCommandsValue[1]: command move 1
    // userCommandsValue[2]: command move 2
    for(int j = 0; j < [userCommandsValue count]; j++){
      NSArray* commandValue = [NSArray arrayWithObjects:userCommandsValue[1], userCommandsValue[2], nil];
      [usersCommandsDictionary setValue: commandValue forKey:userCommandsValue[0]];
    }
  }
  
  thing = [[HIDThing alloc] init];
  
  
  [xmlManager requestAndParseXML];

  
  [thing check_hid];

  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receiveTestNotification:)
                                               name:@"Build Broke"
                                             object:nil];
}


- (NSDictionary*) getCommandsByUser:(NSString*) buildBreaker {
  
  return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInteger:1500], @"U",
            [NSNumber numberWithInteger:100], @"D", nil];

}



- (void) receiveTestNotification:(NSNotification *) notification {

  NSLog(@" RECEIVED note %@", [[notification object] buildBreaker]);
  
  NSArray* commands = [usersCommandsDictionary objectForKey:[[notification object] buildBreaker]];
  
  [self pointAndShoot:commands];
}


- (void) pointAndShoot:(NSArray*) commands {
  
  [thing shootWithCommands:commands];
  
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
