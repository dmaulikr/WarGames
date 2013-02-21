//
//  MusicManager.m
//  WarGames
//
//  Created by Calvin Hui on 2/21/13.
//  Copyright (c) 2013 rga. All rights reserved.
//

#import "MusicManager.h"

@implementation MusicManager

@synthesize audioPlayer;

- (id)init {
  self = [super init];
  if (self) {
    // load the music file into the buffer and prepare to play.
    NSURL* file = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"fixit" ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    [audioPlayer prepareToPlay];
  }
  return self;
}

- (void) playFailedAlert{
  if ([audioPlayer isPlaying]) {
    [audioPlayer pause];
  } else {
    [audioPlayer play];
  }
}

@end
