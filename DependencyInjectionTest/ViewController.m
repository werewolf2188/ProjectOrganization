//
//  ViewController.m
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//
#import <Objection/Objection.h>
#import "ViewController.h"
#import "IStoryService.h"
#import "IMailSender.h"

@interface ViewController ()
{
    StoryDetailModel *detailModel;
}

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextView *detail;
@property (nonatomic,strong) id<IStoryService> service;
@property (nonatomic,strong) id<IMailSender> mail;
@end

@implementation ViewController

objection_requires(@"service", @"mail")
@synthesize service;
@synthesize mail;
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.service) {
        self.service = [[JSObjection defaultInjector] getObject:@protocol(IStoryService)];
    }
    
    if (!self.mail) {
        self.mail = [[JSObjection defaultInjector] getObject:@protocol(IMailSender)];
    }
    
    if (self.listModel) {
        detailModel = [self.service detail: self.listModel];
        self.titleText.text = detailModel.title;
        self.detail.text = detailModel.detail;
    }
    else detailModel = [[StoryDetailModel alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    detailModel.title = self.titleText.text;
    detailModel.detail = self.detail.text;
    if (detailModel.ID) {
        [self.service update:detailModel];
    }
    else [self.service insert:detailModel];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)mail:(id)sender {
    detailModel.title = self.titleText.text;
    detailModel.detail = self.detail.text;
    [self.mail sendEmail:self withTitle:detailModel.title];
}

@end
