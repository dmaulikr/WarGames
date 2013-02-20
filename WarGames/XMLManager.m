//
//  XMLManager.m
//  WarGames
//
//  Created by Calvin Hui on 2/19/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "XMLManager.h"


#import "AFHTTPClient.h"



@implementation XMLManager

- (id)init {
  self = [super init];
  if (self) {
    NSLog(@"XMLManager");
    
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(requestAndParseXML) userInfo:nil repeats:YES];
  }
  return self;
}

- (NSInteger) getBuildNumber:(NSString*) theTitle {
  
  NSString* str = @"hello (9999) world";
  
  NSError* error;
  
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([0-9]+)" options:NSRegularExpressionCaseInsensitive error:&error];
  

  //NSArray* matches = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
  
  
  
  NSString* hello = [regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"$1"];
  
  NSLog(@"num %@", hello);
  
  
  // Determine which retailer user's assortments to get
//  NSNumber* num = [[[NSNumberFormatter alloc] init] numberFromString:[regex stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, [str length]) withTemplate:@"$1"]];

  //NSLog(@"num %@", num);
  
  return 0;
}


- (void) requestAndParseXML {
  
  NSLog(@"check_hid");
  
  NSURL *url = [NSURL URLWithString:@""];
  AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:url];
  [client setAuthorizationHeaderWithUsername:@"" password:@""];
  
  NSURLRequest *request = [client requestWithMethod:@"GET" path:@"" parameters:nil];
  
  [AFXMLRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"application/atom+xml"]];
  
  operation = [AFXMLRequestOperation XMLDocumentRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id XML) {
    
    NSError* error;
    
    NSXMLNode* title = [[XML nodesForXPath:@"//entry[1]/title" error:&error] objectAtIndex:0];
    
    NSXMLNode* author = [[XML nodesForXPath:@"//entry[1]/author" error:&error] objectAtIndex:0];
    
    
    NSLog(@"author name: %@", [author stringValue]);
    NSLog(@"title name: %@", [title stringValue]);
    
    [self getBuildNumber:[title stringValue]];
    
    if(error)
    {
      
    }
    
    

    
    
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error , id XML) {
    
    NSLog(@"Error: %@", XML);
    
  } ];
  [operation start];
  
}

@end
