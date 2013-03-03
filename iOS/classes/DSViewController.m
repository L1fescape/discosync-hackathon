//
//  DSViewController.m
//  DiscoSync
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSViewController.h"
#import "DSDiscoRoomViewController.h"
#import <Firebase/Firebase.h>

@interface DSViewController ()

@end

@implementation DSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	//Set nav bar style and nav item title
	self.navigationItem.title = @"Now Playing";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	//Set table view appearance
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	
	
	//Playing with Firebase
	Firebase *f1 = [[Firebase alloc] initWithUrl:@"https://disco-sync.firebaseio.com/stream"];
	
/*	[f1 on:FEventTypeValue doCallback:^(FDataSnapshot *snap) {
		NSLog(@"Value : %@ %@", [snap val], [snap name]);
	}];
*/}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	DSCell *cell = [[DSCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	cell.textLabel.text = @"DJ Name";
	cell.detailTextLabel.text = @"Genre";
	cell.listenerCount = @"123";
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.navigationController pushViewController:[[DSDiscoRoomViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
