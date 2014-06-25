//
//  LogViewController.m
//  SerialConsole
//
//  Created by Alejandro Juárez Robles on 12/16/13.
//  Copyright (c) 2013 Alejandro Juárez Robles. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()

@end

@implementation LogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"LogViewController");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ns.log"];
        NSFileHandle *fh = [ NSFileHandle fileHandleForReadingAtPath:log];
        [fh seekToEndOfFile];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getData:)
                                                     name:@"NSFileHandleReadCompletionNotification"
                                                   object:fh];
        [fh readInBackgroundAndNotify];
        firstOpen = YES;
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ns.log"];
    NSFileHandle *fh = [ NSFileHandle fileHandleForReadingAtPath:log];
    [fh seekToEndOfFile];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getData:)
                                                 name:@"NSFileHandleReadCompletionNotification"
                                               object:fh];
    [fh readInBackgroundAndNotify];
    firstOpen = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ns.log"];
    
    if ( firstOpen ) {
        NSString *content = [NSString stringWithContentsOfFile:log encoding:NSUTF8StringEncoding error:NULL];
        logWindow.editable = TRUE;
        logWindow.text = [ logWindow.text stringByAppendingString: content];
        logWindow.editable = FALSE;
        firstOpen = NO;
    }

}

- (void)getData: (NSNotification *)aNotification
{
    NSData *data = [[aNotification userInfo] objectForKey:NSFileHandleNotificationDataItem];
    if ([data length]) {
        NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        logWindow.editable = TRUE;
        logWindow.text = [logWindow.text stringByAppendingString:aString];
        logWindow.editable = FALSE;
        [self setWindowScrollToVisible];
        [[aNotification object] readInBackgroundAndNotify];
    } else {
        [self performSelector:@selector(refreshLog:) withObject:aNotification afterDelay:1.0];
    }
}

- (void)refreshLog: (NSNotification *)aNotification
{
    [[aNotification object] readInBackgroundAndNotify];
}

- (void)setWindowScrollToVisible
{
    NSRange txtOutputRange;
    txtOutputRange.location = [[logWindow text] length];
    txtOutputRange.length = 0;
    logWindow.editable = TRUE;
    [logWindow scrollRangeToVisible:txtOutputRange];
    [logWindow setSelectedRange:txtOutputRange];
    logWindow.editable = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
