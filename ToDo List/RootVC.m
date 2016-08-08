//
//  RootVC.m
//  ToDo List
//
//  Created by павел on 14/07/16.
//  Copyright © 2016 павел. All rights reserved.
//

#import "RootVC.h"
#import "PersistanceFacade.h"
#import "MyEvent.h"

@interface RootVC ()

@property (nonatomic, strong) NSArray* myEvent;

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myEvent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    MyEvent *event = self.myEvent[indexPath.row];
    cell.textLabel.text = event.name;
    return cell;
}

- (void)loadData {
    self.myEvent = [[PersistanceFacade sharedManager] loadAllEvents];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"test");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
