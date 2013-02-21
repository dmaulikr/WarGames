//
//  XMLManager.h
//  WarGames
//
//  Created by Calvin Hui on 2/19/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFXMLRequestOperation.h"
#import "AFHTTPClient.h"

@interface XMLManager : NSObject {

  NSInteger prevBuildNumber;
  NSURL *url;
  AFHTTPClient *client;
  NSURLRequest *request;
  AFXMLRequestOperation* operation;
  
}

@property NSString* buildBreaker;
@property NSString* user;
@property NSString* password;
@property NSString* ciDomain;
@property NSString* ciPath;


- (void) requestAndParseXML;
- (NSInteger) getBuildNumber:(NSString*) theTitle;

@end
