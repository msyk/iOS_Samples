//
//  GreenViewController.m
//  Animation
//
//  Created by 新居雅行 on 2014/10/29.
//  Copyright (c) 2014年 msyk.net. All rights reserved.
//

#import "GreenViewController.h"
#import "RedViewController.h"

@interface GreenViewController ()
@property (weak, nonatomic) IBOutlet UIView *box;
@property (weak, nonatomic) IBOutlet UIImageView *photo;

- (IBAction)tapButton:(id)sender;
- (IBAction)showAnotherView:(id)sender;
- (IBAction)showAlertView:(id)sender;
- (IBAction)showActionSheet:(id)sender;

@end

@implementation GreenViewController

- (void)setupActions:(UIAlertController *)alert
{
    UIAlertController* __weak weakAlert = alert;
    
    UIAlertAction* defaultAction
    = [UIAlertAction actionWithTitle: @"Yes, I do."
                               style: UIAlertActionStyleDefault
                             handler:
       ^(UIAlertAction * action) {
           NSLog(@"Alert Button Click = %@", action.title);
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: defaultAction];
    
    UIAlertAction* altAction
    = [UIAlertAction actionWithTitle: @"No, I don't."
                               style: UIAlertActionStyleCancel
                             handler:
       ^(UIAlertAction * action) {
           NSLog(@"Alert Button Click = %@", action.title);
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: altAction];
}

- (IBAction)showAlertView:(id)sender
{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle: @"My App"
//                          message: @"Do you know me?"
//                          delegate: self
//                          cancelButtonTitle: @"Cancel"
//                          otherButtonTitles: @"Yes, I do.", @"No, I don't", nil];
//    [alert show];
    UIAlertController* alert
    = [UIAlertController alertControllerWithTitle: @"My App"
                                          message: @"Do you know me?"
                                   preferredStyle: UIAlertControllerStyleAlert];
    
    [self setupActions:alert];
    
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}

- (IBAction)showActionSheet:(id)sender
{
    //    UIBarButtonItem *tappedItem = sender;
    
    UIAlertController* alert
    = [UIAlertController alertControllerWithTitle: @"My App"
                                          message: @"Are you sleepy?"
                                   preferredStyle: UIAlertControllerStyleActionSheet];
    alert.popoverPresentationController.permittedArrowDirections
    = UIMenuControllerArrowDown;
    alert.popoverPresentationController.barButtonItem = sender;

    UIAlertController* weakAlert = alert;

    UIAlertAction* defaultAction
    = [UIAlertAction actionWithTitle: @"Not at all."
                               style: UIAlertActionStyleDefault
                             handler:
       ^(UIAlertAction * action) {
           NSLog(@"Alert Button Click = %@", action.title);
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: defaultAction];
    
    UIAlertAction* altAction
    = [UIAlertAction actionWithTitle: @"Yes, I am."
                               style: UIAlertActionStyleCancel
                             handler:
       ^(UIAlertAction * action) {
           NSLog(@"Alert Button Click = %@", action.title);
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: altAction];
    
    UIAlertAction* otherAction
    = [UIAlertAction actionWithTitle: @"Sleeping"
                               style: UIAlertActionStyleDestructive
                             handler:
       ^(UIAlertAction * action) {
           NSLog(@"Alert Button Click = %@", action.title);
           [weakAlert dismissViewControllerAnimated: YES
                                         completion: nil];
       }];
    [alert addAction: otherAction];
    
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}

- (IBAction)showAnotherView:(id)sender
{
    RedViewController *rvc = [self.storyboard
                              instantiateViewControllerWithIdentifier: @"RedView"];
    [self presentViewController: rvc
                       animated: YES
                     completion: ^(){}];
}

- (IBAction)tapButton:(id)sender
{
    /*
    [UIView animateWithDuration: 2.0
                     animations: ^(){
                         self.photo.alpha = 0.0;
                         self.box.backgroundColor = [UIColor blackColor];
                     }
                     completion: ^(BOOL finished){
                         self.photo.alpha = 1.0;
                         self.box.backgroundColor = [UIColor whiteColor];
                         [UIView animateWithDuration: 2.0
                                          animations: ^(){
                                              self.box.alpha = 0.0;
                                              CGPoint photoCenter = self.photo.center;
                                              photoCenter.y += 200;
                                              self.photo.center = photoCenter;
                                          }
                                          completion: ^(BOOL finished){
                                              self.box.alpha = 1.0;
                                              CGPoint photoCenter = self.photo.center;
                                              photoCenter.y -= 200;
                                              self.photo.center = photoCenter;
                                          }];
                     }];
     */
    NSLog( @"self.view=%@", self.view);
    UIView *newView = [[UIView alloc]initWithFrame: self.view.frame];
    newView.backgroundColor = [UIColor yellowColor];
    [UIView transitionFromView: self.view
                        toView: newView
                      duration: 3.0
                       options: UIViewAnimationOptionTransitionFlipFromLeft
                    completion: ^(BOOL finished){
                        NSLog( @"self.view=%@", self.view);
                    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
