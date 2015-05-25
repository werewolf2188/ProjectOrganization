//
//  IRepository.h
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IRepository <NSObject>
@required
-(NSArray *)select;
-(NSObject *)detail:(NSObject*)ID;
-(NSObject *)create;
-(BOOL)save;
-(BOOL)remove:(NSObject *)object;
@end
