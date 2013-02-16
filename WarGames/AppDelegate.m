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

#import "AFJSONRequestOperation.h"


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
  
  [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(check_hid) userInfo:nil repeats:YES];
  
  
  thing = [[HIDThing alloc] init];
  
  [thing check_hid];
  
  NSURL *url = [NSURL URLWithString:@"https://alpha-api.app.net/stream/0/posts/stream/global"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    NSLog(@"App.net Global Stream: %@", JSON);
  } failure:nil];
  [operation start];
}

- (IBAction) status:(id)sender {

  NSLog(@"status");
  
  [thing on];
  
}


- (IBAction) move:(id)sender {

  NSLog(@"move");
  
  [thing off];
  
}

- (void) check_hid {
   NSLog(@"doing my thing");
}


@end
