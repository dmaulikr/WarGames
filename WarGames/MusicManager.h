//
//  MusicManager.h
//  WarGames
//
//  Created by Calvin Hui on 2/21/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicManager : NSObject {

}

@property AVAudioPlayer* audioPlayer;

- (void) playFailedAlert;

@end
