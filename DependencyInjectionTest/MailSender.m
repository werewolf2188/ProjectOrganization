//
//  MailSender.m
//  DependencyInjectionTest
//
//  Created by Enrique on 17/05/15.
//  Copyright (c) 2015 Werewolf. All rights reserved.
//

#import "MailSender.h"
@import MessageUI;

@interface MailSender()<MFMailComposeViewControllerDelegate>
{
    UIViewController *sender;
    MFMailComposeViewController * mail;
}
@end

@implementation MailSender
-(void)sendEmail:(UIViewController *)controller withTitle:(NSString *)title;
{
    mail = [[MFMailComposeViewController alloc]init];
    sender = controller;
    mail.mailComposeDelegate = self;
    [mail setSubject:title];
    [mail setMessageBody:title isHTML:NO];
    
    [controller presentViewController:mail animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [mail dismissViewControllerAnimated:YES completion:NULL];
}
@end
