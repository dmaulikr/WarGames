//
//  AppDelegate.m
//  WarGames
//
//  Created by Andre Cardozo on 2/15/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#include <IOKit/IOKitLib.h>

#import "AppDelegate.h"
#import "HIDThing.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  NSBundle* bundle = [NSBundle mainBundle];

  statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
  statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon" ofType:@"png"]];

  [statusItem setImage:statusImage];
  [statusItem setToolTip:@"Hello"];
  [statusItem setMenu:statusMenu];

  musicManager = [[MusicManager alloc] init];
  
  NSError *err = nil;
  NSString *path = [bundle pathForResource:@"settings" ofType:@"txt"];
  NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];

  if(!contents) {
    //handle error
  }

  NSArray* settingsValue = [contents componentsSeparatedByString:@"\n"];

  usersCommandsDictionary = [NSMutableDictionary new];

  for(int i = 5; i < [settingsValue count]; i++)
  {
    NSString* currentLine = settingsValue[i];
    NSArray* userCommandsValue = [currentLine componentsSeparatedByString:@" "];

    // userCommandsValue[0]: user name
    // userCommandsValue[1]: command move 1
    // userCommandsValue[2]: command move 2
    for(int j = 0; j < [userCommandsValue count]; j++)
    {
      NSArray* commandValue = [NSArray arrayWithObjects:userCommandsValue[1], userCommandsValue[2], nil];
      [usersCommandsDictionary setValue: commandValue forKey:userCommandsValue[0]];
    }
  }

  xmlManager = [[XMLManager alloc] init];

  [xmlManager setUser:settingsValue[0]];      // username
  [xmlManager setPassword:settingsValue[1]];  // password
  [xmlManager setCiDomain:settingsValue[2]];  // domain
  [xmlManager setCiPath:settingsValue[3]];    // path

  thing = [[HIDThing alloc] init];

  // [xmlManager requestAndParseXML];

  [thing check_hid];
  
  [thing shootWithCommands:[NSArray arrayWithObjects:@"U:0.5", @"D:0.5", nil]];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(receiveTestNotification:)
                                               name:@"Build Broke"
                                             object:nil];
}

- (void) receiveTestNotification:(NSNotification *) notification {

  NSLog(@" RECEIVED note %@", [[notification object] buildBreaker]);

  NSArray* commands = [usersCommandsDictionary objectForKey:[[notification object] buildBreaker]];
  
  if(!commands){
    commands = [usersCommandsDictionary objectForKey:@"dlabar"];
  }
  
  [self pointAndShoot:commands];
}

- (void) pointAndShoot:(NSArray*) commands {
  [musicManager playFailedAlert];
  [thing shootWithCommands:commands];
}

- (IBAction) status:(id)sender {

  NSLog(@"status");

  [thing led:YES];
}

- (IBAction) move:(id)sender {

  NSLog(@"move");

  [thing led:NO];
}


@end
