//
//  TableViewController.m
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//
#import <Objection/Objection.h>
#import "TableViewController.h"
#import "IStoryService.h"
#import "StoryModel.h"
#import "ViewController.h"

@interface TableViewController()
{
    NSMutableArray *list;
    StoryListModel* editModel;
}
@property (nonatomic,strong) id<IStoryService> service;
@end

@implementation TableViewController

objection_requires(@"service")
@synthesize service;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.service) {
        self.service = [[JSObjection defaultInjector] getObject:@protocol(IStoryService)];
    }
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    list = [[self.service list] mutableCopy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (list) {
        return 1;
    }
    return 0;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (list) {
        return list.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"StoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (list) {
        cell.textLabel.text = ((StoryListModel*)list[indexPath.row]).title;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editModel =((StoryListModel*)list[indexPath.row]);
    [self performSegueWithIdentifier:@"StoryDetailPush" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        StoryListModel *listModel = (StoryListModel*)[list objectAtIndex:indexPath.row];
        [self.service delete:listModel];
        [list removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        //[self.tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"StoryDetailPush"]) {
        ((ViewController*)segue.destinationViewController).listModel = editModel;
    }
}


@end
