//
//  IUnitOfWork.h
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@protocol IUnitOfWork <NSObject>
- (NSManagedObjectContext *) managedObjectContext;
@end
