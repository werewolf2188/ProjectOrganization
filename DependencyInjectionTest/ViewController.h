//
//  ViewController.h
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryModel.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) StoryListModel *listModel;
@end

