//
//  LogViewController.h
//  SerialConsole
//
//  Created by Alejandro Juárez Robles on 12/16/13.
//  Copyright (c) 2013 Alejandro Juárez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogViewController : UIViewController {
    __weak IBOutlet UITextView *logWindow;
    BOOL firstOpen;
}

@property (weak, nonatomic) IBOutlet UITextView *logWindow;

- (IBAction)done:(id)sender;
- (void)setWindowScrollToVisible;

@end
