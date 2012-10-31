//
//  exampleViewController.h
//  example
//
//  Created by Priyanka R on 29/10/12.
//  Copyright (c) 2012 Priyanka R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface exampleViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    
    IBOutlet UIPickerView *pickerView;
    NSMutableArray *hoursArray;
    NSMutableArray *minsArray;
    NSMutableArray *secsArray;
    NSInteger interval;
    NSString *totalTimeStr ;
    
    IBOutlet UILabel *timeCounterLabel;
    __weak IBOutlet UIButton *newButton;
    __weak IBOutlet UIButton *stopButton;
    __weak IBOutlet UIButton *startButton;
}
- (IBAction)newTimer:(id)sender;
- (IBAction)stopTimer:(id)sender;
- (IBAction)startTimer:(id)sender;
@property(retain, nonatomic) UIPickerView *pickerView;
@property(retain, nonatomic) NSMutableArray *hoursArray;
@property(retain, nonatomic) NSMutableArray *minsArray;
@property(retain, nonatomic) NSMutableArray *secsArray;
@property(nonatomic) NSInteger interval;
@property(retain, nonatomic) UIActionSheet * actionSheet;
@property(retain, atomic) UILabel * timeCounterLabel;
@property(retain, atomic) NSString * totalTimeStr;

@end
