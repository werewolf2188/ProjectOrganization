//
//  StoryDetailRepository.m
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import <Objection/Objection.h>
#import "StoryDetailRepository.h"
#import "IUnitOfWork.h"
#define TABLENAME @"StoryDetail"
#define CACHENAME @"StoryDetailCache"
#define ORDERCOLUMN @"detail"
@import CoreData;

@interface StoryDetailRepository()<NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetched;
    NSArray *fetchResults;
}
@property id<IUnitOfWork> context;

@end

@implementation StoryDetailRepository
objection_requires(@"context")
@synthesize context;

-(void)initialize
{
    if (!self.context) {
        self.context = [[JSObjection defaultInjector] getObject:@protocol(IUnitOfWork)];
    }
    if (!fetched) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:TABLENAME inManagedObjectContext:[self.context managedObjectContext]];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:ORDERCOLUMN ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        fetched = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[self.context managedObjectContext] sectionNameKeyPath:nil cacheName:CACHENAME];
        fetched.delegate = self;
    }
}

-(NSArray *)select
{
    [self initialize];
    if (!fetchResults) {
        NSError *error;
        [fetched performFetch:&error];
        fetchResults = fetched.fetchedObjects;
    }
    return fetchResults;
}

-(NSObject *)detail:(NSObject*)ID
{
    [self initialize];
    NSError *error;
    NSManagedObject *object = [[self.context managedObjectContext] existingObjectWithID:((NSManagedObjectID *)ID) error:&error];
    if (!object) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return nil;
    }
    return object;
}

-(NSObject *)create
{
    [self initialize];
    return [NSEntityDescription insertNewObjectForEntityForName:TABLENAME inManagedObjectContext:[self.context managedObjectContext]];
}

-(BOOL)save
{
    [self initialize];
    NSError *error;
    if (![[self.context managedObjectContext] save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        return NO;
    }
    fetchResults = nil;
    return YES;
}

-(BOOL)remove:(NSObject *)object
{
    [[self.context managedObjectContext] deleteObject:(NSManagedObject*)object];
    return [self save];
}

//
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"Story Detail: controllerWillChangeContent");
}


- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSLog(@"Story Detail: didchangeobject");
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    NSLog(@"Story Detail: didchangesection");
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    NSLog(@"Story Detail: controllerdidChangeContent");
}

- (NSString *)controller:(NSFetchedResultsController *)controller
sectionIndexTitleForSectionName:(NSString *)sectionName
{
    NSLog(@"Story Detail: sectionIndexTitleForSectionName");
    return @"";
}

@end
