//
//  SettingsWindowController.m
//  SVNitor
//
//  Created by Kevin Kinnebrew on 9/19/12.
//  Copyright (c) 2012 Letteer's Home. All rights reserved.
//

#import "SettingsWindowController.h"
#import "Repository.h"
#import "AppDelegate.h"

@implementation SettingsWindowController

@synthesize repositories;

- (void)windowWillLoad
{
  repositories = [[NSMutableArray alloc] init];
  
  Repository *repo = [(AppDelegate *)[[NSApplication sharedApplication] delegate] loadDataForKey:@"repository"];
  
  if (repo)
  {
    [repositories addObject:repo];
  }
}

@end
