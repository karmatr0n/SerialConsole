//
//  ViewController.m
//  SerialConsole
//
//  Created by Alejandro Juárez Robles on 12/15/13.
//  Copyright (c) 2013 Alejandro Juárez Robles. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    rscMgr = [[RscMgr alloc] init];
    [rscMgr  setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendString:(id)sender {
    [self.textEntry resignFirstResponder];
    NSString *text = self.textEntry.text;
    int bytesToWrite = (int)text.length;
    for (int i = 0; i < bytesToWrite; i++){
        txBuffer[i] = (int)[text characterAtIndex:i];
    }
    int bytesWritten = [rscMgr write:txBuffer Length:bytesToWrite];

}

- (IBAction)openLog:(id)sender {
}
#pragma mark - RscMgrDelegate methods

- (void) cableConnected:(NSString *)protocol {
    [rscMgr setBaud:9600];
    [rscMgr open];
}

- (void)cableDisconnected {

}

- (void)portStatusChanged {

}

- (void)readBytesAvailable:(UInt32)numBytes {
    int bytesRead = [rscMgr read:rxBuffer Length:numBytes];
    NSLog(@"Read %d bytes from serial cable.", bytesRead);
    for (int i = 0; i < numBytes; i++) {
        self.serialView.text = [NSString stringWithFormat:@"%@%c", self.serialView.text, ((char*)rxBuffer)[i]];
    }
}


- (BOOL)rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    return FALSE;
    
}

- (void)didReceivePortConfig {
    
}
@end
