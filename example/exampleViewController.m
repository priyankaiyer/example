//

//  exampleViewController.m

//  example

//

//  Created by Priyanka R and Arun Scaria on 29/10/12.

//



#import "exampleViewController.h"



@interface exampleViewController ()

@end



@implementation exampleViewController



@synthesize pickerView;

@synthesize hoursArray;

@synthesize minsArray;

@synthesize secsArray;

@synthesize interval;

@synthesize actionSheet;

@synthesize timeCounterLabel;

@synthesize totalTimeStr;



int hoursInt;

int minsInt;

int secsInt;

NSString *startButtonString = @"Start";

NSString *pauseButtonString = @"Pause";

NSTimer *gameTimer;



- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    
    
    [startButton setTitle:startButtonString forState:UIControlStateNormal];
    
    [stopButton setEnabled:NO];
    
    [stopButton setAlpha:0.5];
    
    interval = 0;
    
    
    
    hoursArray = [[NSMutableArray alloc] init];
    
    minsArray = [[NSMutableArray alloc] init];
    
    secsArray = [[NSMutableArray alloc] init];
    
    NSString *strVal = [[NSString alloc] init];
    
    
    
    for(int i=0; i<60; i++){
        
        strVal = [NSString stringWithFormat:@"%d", i];
        
        
        
        if (i < 13)
            
            [hoursArray addObject:strVal];
        
        [minsArray addObject:strVal];
        
        [secsArray addObject:strVal];
        
    }
    
    
    
    NSLog(@"[hoursArray count]: %d", [hoursArray count]);
    
    NSLog(@"[minsArray count]: %d", [minsArray count]);
    
    NSLog(@"[secsArray count]: %d", [secsArray count]);
    
    
    
    [self.view addSubview:pickerView];
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component{
    
    if (component==0)
        
        return [hoursArray count];
    
    else if (component==1)
        
        return [minsArray count];
    
    else
        
        return [secsArray count];
    
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component){
            
        case 0:
            
            return [hoursArray objectAtIndex:row];
            
        case 1:
            
            return [minsArray objectAtIndex:row];
            
        case 2:
            
            return [secsArray objectAtIndex:row];
            
    }
    
    return nil;
    
}



- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    totalTimeStr = [self calculateTimeFromPicker ];
    
}





-(NSString *)calculateTimeFromPicker{
    
    NSString *hoursStr = [NSString stringWithFormat:@"%@",[hoursArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
    
    NSString *minsStr = [NSString stringWithFormat:@"%@",[minsArray objectAtIndex:[pickerView selectedRowInComponent:1]]];
    
    NSString *secsStr = [NSString stringWithFormat:@"%@",[secsArray objectAtIndex:[pickerView selectedRowInComponent:2]]];
    
    
    
    hoursInt = [hoursStr intValue];
    
    minsInt = [minsStr intValue];
    
    secsInt = [secsStr intValue];
    
    return  [NSString stringWithFormat:@"%2d:%2d:%2d",hoursInt, minsInt, secsInt];
    
}



- (IBAction)newTimer:(id) sender {
    
    
    
    [self stopTimer:self];
    
    [gameTimer invalidate];
    
    
    
    actionSheet = [[UIActionSheet alloc] initWithTitle: @"Set Countdown Time"
                   
                                              delegate:nil
                   
                                     cancelButtonTitle:nil
                   
                                destructiveButtonTitle:nil
                   
                                     otherButtonTitles:nil];
    
    
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
   
    CGRect pickerFrame = CGRectMake(0,0,270,220);
    
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    pickerView.showsSelectionIndicator = YES;
    
    pickerView.dataSource = self;
    
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    
    [pickerView release];
    
    
    
    UILabel * hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 122, 50.0f, 50.0f)];
    
    hourLabel.text = @"Hours";
    
    hourLabel.textAlignment = NSTextAlignmentCenter;
    
    hourLabel.textColor = [UIColor whiteColor];
    
    hourLabel.backgroundColor = [UIColor clearColor];
    
    [actionSheet addSubview:hourLabel];
    
    [hourLabel release];
    
    
    
    
    
    UILabel * minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 122, 50.0f, 50.0f)];
    
    minuteLabel.text = @"Mins";
    
    minuteLabel.textAlignment = NSTextAlignmentCenter;
    
    minuteLabel.textColor = [UIColor whiteColor];
    
    minuteLabel.backgroundColor = [UIColor clearColor];
    
    [actionSheet addSubview:minuteLabel];
    
    [minuteLabel release];
    
    
    
    
    
    UILabel * secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 122, 50.0f, 50.0f)];
    
    secondLabel.text = @"Secs";
    
    secondLabel.textAlignment = NSTextAlignmentCenter;
    
    secondLabel.textColor = [UIColor whiteColor];
    
    secondLabel.backgroundColor = [UIColor clearColor];
    
    [actionSheet addSubview:secondLabel];
    
    [secondLabel release];
    
    
    
    UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Cancel"]];
    
    cancelButton.momentary = YES;
    
    cancelButton.frame = CGRectMake(10, 7.0f, 50.0f, 30.0f);
    
    
    
    cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
    
    [cancelButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:cancelButton];
    
    [cancelButton release];
    
    
    
    UISegmentedControl *setButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Set"]];
    
    setButton.momentary = YES;
    
    setButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    
    setButton.segmentedControlStyle = UISegmentedControlStyleBar;
    
    [setButton addTarget:self action:@selector(setTimeForCounter:) forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:setButton];
    
    [setButton release];
    
    
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
    
    
    
}



- (IBAction)startTimer:(id)sender {
    
    
    
    if([gameTimer isValid] == YES){
        
        [gameTimer invalidate];
        
        [startButton setTitle:startButtonString forState:UIControlStateNormal];
        
        [stopButton setEnabled:NO];
        
        [stopButton setAlpha:0.5];
        
        return;
        
    }
    
    
    
    [startButton setTitle:pauseButtonString forState:UIControlStateNormal];
    
    [stopButton setEnabled:YES];
    
    [stopButton setAlpha:1];
    
    
    
    gameTimer = [[NSTimer timerWithTimeInterval:1.00 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES] retain];
    
    [[NSRunLoop currentRunLoop] addTimer:gameTimer forMode:NSDefaultRunLoopMode];
    
}



- (void)timerFired:(NSTimer *)timer {
    
    
    
    if(interval == 0)
        
        [self timerExpired];
    
    else {
        
        interval--;
        
        if(interval == 0) {
            
            [timer invalidate];
            
            [self timerExpired];
            
        }
        
    }
    
    
    
    int hrs= interval/3600;
    
    interval = interval%3600;
    
    
    
    int mins=interval/60;
    
    int sec= interval%60;
    
    
    
    timeCounterLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hrs,mins,sec];
    
}



- (void) timerExpired {
    
    [self stopTimer:self];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Timer Expired"
                              
                                                        message:@"The timer you set is expired."
                              
                                                       delegate:self cancelButtonTitle:@"OK"
                              
                                              otherButtonTitles:nil];
    
    [alertView show];
    
    if (alertView) [alertView release];
    
}



- (IBAction)stopTimer:(id)sender {
    
    [gameTimer invalidate];
    
    [startButton setTitle:startButtonString forState:UIControlStateNormal];
    
    [stopButton setEnabled:NO];
    
    [stopButton setAlpha:0.5];
    
    
    
}



- (void) dismissActionSheet:(id) sender{
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}



- (void) setTimeForCounter:(id) sender{
    
    totalTimeStr = [NSString stringWithFormat:@"%02d:%02d:%02d",hoursInt, minsInt, secsInt];
    
    timeCounterLabel.text = totalTimeStr;
    
    interval = secsInt + (minsInt*60) + (hoursInt*3600);
    
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (void)dealloc {
    
    [timeCounterLabel release];
    
    [super dealloc];
    
}

@end

