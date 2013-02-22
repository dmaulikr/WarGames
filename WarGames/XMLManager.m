//
//  XMLManager.m
//  WarGames
//
//  Created by Calvin Hui on 2/19/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "XMLManager.h"

@implementation XMLManager

@synthesize buildBreaker;
@synthesize user;
@synthesize password;
@synthesize ciDomain;
@synthesize ciPath;

- (id)init {
  self = [super init];
  if (self) {
    NSLog(@"XMLManager");

    prevBuildNumber = -1;
    buildBreaker = @"";

    [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(requestAndParseXML) userInfo:nil repeats:YES];
  }
  return self;
}

- (NSInteger) getBuildNumber:(NSString*) theTitle {

  NSError* error;
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([0-9]+)" options:NSRegularExpressionCaseInsensitive error:&error];
  NSRange range = [regex rangeOfFirstMatchInString:theTitle options:kNilOptions range:NSMakeRange(0, [theTitle length])];
  NSString* buildNumber = [theTitle substringWithRange:range];

  return [buildNumber integerValue];
}

- (void) requestAndParseXML {

  NSLog(@"requestAndParseXML %@", user);

  url = [NSURL URLWithString:ciDomain];
  client = [AFHTTPClient clientWithBaseURL:url];
  [client setAuthorizationHeaderWithUsername:[self user] password:[self password]];

  request = [client requestWithMethod:@"GET" path:ciPath parameters:nil];

  [AFXMLRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/atom+xml"]];

  operation = [AFXMLRequestOperation XMLDocumentRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id XML) {

    NSError* error;
    NSXMLNode* title = [[XML nodesForXPath:@"//entry[1]/title" error:&error] objectAtIndex:0];
    NSXMLNode* author = [[XML nodesForXPath:@"//entry[1]/author" error:&error] objectAtIndex:0];

    if(error)
    {
      NSLog(@"Error: Can't find build number");
      return;
    }

    NSLog(@"author name: %@", [author stringValue]);
    NSLog(@"title name: %@", [title stringValue]);

    NSInteger buildNumber = [self getBuildNumber:[title stringValue]];

    if(buildNumber != prevBuildNumber && [[title stringValue] rangeOfString:@"Failed"].location != NSNotFound)
    {
      // NSLog(@"fine");

      buildBreaker = [author stringValue];

      [[NSNotificationCenter defaultCenter]
       postNotificationName:@"Build Broke" object:self];

      prevBuildNumber = buildNumber;
    }

  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error , id XML) {
    NSLog(@"Error: %@", [error description]);
  } ];
  [operation start];
}

@end
