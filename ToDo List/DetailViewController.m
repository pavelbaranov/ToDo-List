//
//  ViewController.m
//  ToDo List
//
//  Created by павел on 04/07/16.
//  Copyright © 2016 павел. All rights reserved.
//

#import "DetailViewController.h"
#import "MyEvent.h"
#import "PersistanceFacade.h"

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
    
    NSLog(@"view did load");
}

- (void)dealloc {
    NSLog(@"dealloc");
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
    if (self.textField.text.length > 0){
    MyEvent* event = [MyEvent new];
    event.name = self.textField.text;
    event.date = self.datePicker.date;
    
    
    NSDictionary * dict=[[NSDictionary alloc] initWithObjectsAndKeys:event.name,@"event.name",event.date ,@"event.date", nil];
    
    NSDate *currentDate = [NSDate date];
    NSLog(@"%@", currentDate);
    
    [[PersistanceFacade sharedManager]addEvent:event];
    
    UILocalNotification * notification =[UILocalNotification new];
    notification.userInfo=dict;
    notification.timeZone=[NSTimeZone defaultTimeZone];
    notification.fireDate=event.date;
    notification.alertBody=self.textField.text;
    notification.applicationIconBadgeNumber=1;
    notification.soundName=UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
   else
   {
       UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Внимание"
                                                                     message:@"Введите текст напоминания."
                                                              preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {}];
       
       [alert addAction:defaultAction];
       [self presentViewController:alert animated:YES completion:nil];
       
       
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
{
    if ([textField isEqual:self.textField]) {
        [self.textField resignFirstResponder];
  
    }
 
    return YES;
}



@end
