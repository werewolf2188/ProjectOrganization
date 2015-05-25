//
//  StoryDetail.h
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Story;

@interface StoryDetail : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) Story *story;

@end
