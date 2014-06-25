//
//  ViewController.h
//  SerialConsole
//
//  Created by Alejandro Juárez Robles on 12/15/13.
//  Copyright (c) 2013 Alejandro Juárez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogViewController.h"
#import "RscMgr.h"

#define BUFFER_LEN 1024

@interface ViewController : UIViewController<RscMgrDelegate> {

    RscMgr *rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
    UInt8 txBuffer[BUFFER_LEN];
    
    __weak IBOutlet UITextField *textEntry;
    __weak IBOutlet UIButton *sendButton;
    __weak IBOutlet UITextView *serialView;
}

@property (weak, nonatomic) IBOutlet UITextField *textEntry;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextView *serialView;
@property (nonatomic, retain) LogViewController *logWindow;

- (IBAction)sendString:(id)sender;

@end
