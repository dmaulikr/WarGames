//
//  XMLManager.h
//  WarGames
//
//  Created by Calvin Hui on 2/19/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFXMLRequestOperation.h"

@interface XMLManager : NSObject {
  NSInteger* prevBuildNumber;
  AFXMLRequestOperation* operation;
  
}


-(void) requestAndParseXML;

-(NSInteger) getBuildNumber:(NSString*) theTitle;

@end
