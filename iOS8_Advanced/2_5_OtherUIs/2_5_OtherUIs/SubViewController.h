//
//  SubViewController.h
//  2_5_OtherUIs
//
//  Created by Masayuki Nii on 2013/12/29.
//  Copyright (c) 2013年 msyk.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController

//@property (nonatomic, strong) NSBlockOperation *doAfterDisappear;
@property (nonatomic, weak  ) UIPopoverController *myPopover;
//@property (nonatomic        ) BOOL isModalDialog;

@end
