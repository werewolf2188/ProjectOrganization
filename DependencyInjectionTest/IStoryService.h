//
//  IStoryService.h
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IService.h"
#import "StoryModel.h"
@protocol IStoryService <IService>
@required
-(NSArray *)list;
-(StoryDetailModel *)detail: (StoryListModel*)listModel;
-(BOOL)insert: (StoryDetailModel *)detailmodel;
-(BOOL)update: (StoryDetailModel *)detailmodel;
-(BOOL)delete: (StoryListModel *)listmodel;
@end
