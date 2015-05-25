//
//  DependencyModule.m
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import "DependencyModule.h"

#import "IUnitOfWork.h"
#import "DITContext.h"

#import "IStoryRepository.h"
#import "StoryRepository.h"
#import "IStoryDetailRepository.h"
#import "StoryDetailRepository.h"

#import "IStoryService.h"
#import "StoryService.h"

#import "IMailSender.h"
#import "MailSender.h"

@implementation DependencyModule
-(void)configure
{
    [self bind:[[DITContext alloc]init] toProtocol:@protocol(IUnitOfWork)];
    [self bind:[[StoryRepository alloc]init] toProtocol:@protocol(IStoryRepository)];
    [self bind:[[StoryDetailRepository alloc]init] toProtocol:@protocol(IStoryDetailRepository)];
    [self bind:[[StoryService alloc]init] toProtocol:@protocol(IStoryService)];
    [self bind:[[MailSender alloc]init] toProtocol:@protocol(IMailSender)];
}
@end
