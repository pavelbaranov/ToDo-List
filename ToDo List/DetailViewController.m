//
//  ViewController.m
//  ToDo List
//
//  Created by павел on 04/07/16.
//  Copyright © 2016 павел. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;


@end

@implementation DetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.buttonSave addTarget:(self) action:@selector(save) forControlEvents:
     UIControlEventTouchUpInside];
    [self.datePicker addTarget:self action:@selector(datePickerValueChange) forControlEvents:UIControlEventValueChanged];
    
    self.datePicker.minimumDate=[NSDate date];
    
    UITapGestureRecognizer * handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEndEditing)];
    
    [self.view addGestureRecognizer:handleTap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) datePickerValueChange{
    self.eventDate = self.datePicker.date;
     NSLog(@"self.eventDate %@",self.eventDate);
}

-(void) handleEndEditing {
    [self.view endEditing:YES];
}

-(void) save {
    
    NSString * eventInfo=self.textField.text;
    
    NSDateFormatter * formater=[[NSDateFormatter alloc]init];
    formater.dateFormat=@"HH:mm dd.MMMM.yyyy";
    
    NSString * eventDate=[formater stringFromDate:self.eventDate];
    
    NSDictionary * dict=[[NSDictionary alloc] initWithObjectsAndKeys: eventInfo, @"eventInfo", eventDate,@"eventDate", nil];
    
    NSLog(@"save");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    if ([textField isEqual:self.textField]) {
        [self.textField resignFirstResponder];
  
    }
 
    return YES;
}
@end
