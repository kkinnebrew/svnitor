//
//  Repository.h
//  SVNitor
//
//  Created by Kevin Kinnebrew on 9/21/12.
//  Copyright (c) 2012 Letteer's Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject <NSCoding>
{
@private
  NSString *name;
  NSString *repositoryPath;
  NSString *revision;
}

@property (copy) NSString *name;
@property (copy) NSString *repositoryPath;
@property (copy) NSString *revision;

@end
