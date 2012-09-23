//
//  GrowlAppDelegate.m
//  SVNitor
//
//  Created by Letteer on 9/22/12.
//  Copyright (c) 2012 Letteer's Home. All rights reserved.
//

#import "GrowlController.h"

@implementation GrowlController

- (id) init
{
  if([GrowlApplicationBridge isGrowlRunning])
  {
    // Insert code here to initialize your application
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [[mainBundle privateFrameworksPath] stringByAppendingPathComponent:@"Growl"];
    
    if(NSAppKitVersionNumber >= NSAppKitVersionNumber10_6)
      path = [path stringByAppendingPathComponent:@"2.0"];
    else
      path = [path stringByAppendingPathComponent:@"Legacy"];
    
    path = [path stringByAppendingPathComponent:@"Growl.framework"];
    
    NSLog(@"path: %@", path);
    NSBundle *growlFramework = [NSBundle bundleWithPath:path];
    if([growlFramework load])
    {
      NSDictionary *infoDictionary = [growlFramework infoDictionary];
      NSLog(@"Using Growl.framework %@ (%@)",
            [infoDictionary objectForKey:@"CFBundleShortVersionString"],
            [infoDictionary objectForKey:(NSString *)kCFBundleVersionKey]);
      
      [GrowlApplicationBridge setGrowlDelegate:self];
    }

    
    
    [GrowlApplicationBridge setGrowlDelegate:self];
  }
  else
  {
    //TODO: implement automatic pause of notifications.
  }
  return self;
}

- (NSDictionary *) registrationDictionaryForGrowl
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"GrowlNotifications" ofType:@"plist"];
  growlNotifications = [NSDictionary dictionaryWithContentsOfFile:path];
  
  NSDictionary *regDict = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"SVNitor", GROWL_APP_NAME,
                           [[growlNotifications objectForKey:@"ALL"] allValues], GROWL_NOTIFICATIONS_ALL,
                           [[growlNotifications objectForKey:@"DEFAULT"] allValues],	GROWL_NOTIFICATIONS_DEFAULT,
                           [[growlNotifications objectForKey:@"HUMAN_READABLE"] allValues],	GROWL_NOTIFICATIONS_HUMAN_READABLE_NAMES, nil];
  return regDict;
}

-(void) notifyGrowl: (NSString *)title withDesc:(NSString *)description
{
    if([GrowlApplicationBridge respondsToSelector:@selector(notifyWithTitle:description:notificationName:iconData:priority:isSticky:clickContext:identifier:)])
    {
      NSString *notifierName = [[growlNotifications objectForKey:@"ALL"] valueForKey:@"NotifierNewCommit"];
      NSLog(@"Notifier Name: %@", notifierName);
      [GrowlApplicationBridge notifyWithTitle:title
             description:description
             notificationName:notifierName
             iconData:nil
             priority:0
             isSticky:YES
             clickContext:nil
             identifier:@"SVNitor"];
    }
  else
  {
    NSLog(@"Your Growl is borked");
  }
    
}
@end
