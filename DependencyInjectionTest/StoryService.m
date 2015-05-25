//
//  StoryService.m
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//
#import <Objection/Objection.h>
#import "StoryService.h"
#import "IStoryRepository.h"
#import "IStoryDetailRepository.h"
#import "Story.h"
#import "StoryDetail.h"
@interface StoryService()

@property (nonatomic,strong) id<IStoryRepository> storyRep;
@property (nonatomic,strong) id<IStoryDetailRepository> storyDetailRep;
@end

@implementation StoryService

objection_requires(@"storyRep", @"storyDetailRep")
@synthesize storyRep;
@synthesize storyDetailRep;

-(void)initialize
{
    if (!self.storyRep) {
        self.storyRep = [[JSObjection defaultInjector] getObject:@protocol(IStoryRepository)];
    }
    if (!self.storyDetailRep) {
        self.storyDetailRep = [[JSObjection defaultInjector] getObject:@protocol(IStoryDetailRepository)];
    }
}
-(NSArray *)list
{
    [self initialize];
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    StoryListModel *model;
    for (Story *stp in [self.storyRep select]) {
        model = [[StoryListModel alloc]init];
        model.title = stp.title;
        model.ID = stp.objectID;
        [temp addObject:model];
    }
    
    return temp;
}
-(StoryDetailModel *)detail: (StoryListModel*)listModel
{
    [self initialize];
    Story *story = (Story *)[self.storyRep detail:listModel.ID];
    StoryDetailModel * model = [[StoryDetailModel alloc]init];
    model.ID = story.objectID;
    model.title = story.title;
    model.detail = story.storydetail.detail;
    model.detailID = story.storydetail.objectID;
    
    return model;
}
-(BOOL)insert: (StoryDetailModel *)detailmodel
{
    [self initialize];
    Story *story = (Story*)[self.storyRep create];
    StoryDetail *storyDetail = (StoryDetail*)[self.storyDetailRep create];
    
    story.title = [NSString stringWithFormat:@"%@ - Texto de dotnet",detailmodel.title];
    story.createddate = [NSDate date];
    storyDetail.detail = detailmodel.detail;
    story.storydetail = storyDetail;
    storyDetail.story = story;
    
    return [self.storyRep save];
}
-(BOOL)update: (StoryDetailModel *)detailmodel
{
    [self initialize];
    Story *story = (Story *)[self.storyRep detail:detailmodel.ID];
    story.title = detailmodel.title;
    story.storydetail.detail = detailmodel.detail;
    
    return [self.storyRep save];;
}
-(BOOL)delete: (StoryListModel *)listmodel
{
    [self initialize];
    Story *story = (Story *)[self.storyRep detail:listmodel.ID];
    
    return [self.storyRep remove:story];;
}
@end
