//
//  StoryModel.h
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryListModel : NSObject
@property (nonatomic,strong) NSObject *ID;
@property (nonatomic,strong) NSString *title;
@end

@interface StoryDetailModel : NSObject
@property (nonatomic,strong) NSObject *ID;
@property (nonatomic,strong) NSObject *detailID;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *detail;
@end