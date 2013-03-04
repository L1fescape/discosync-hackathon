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
	self.navigationItem.title = @"Discos";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	//Set table view appearance
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
	self.tableView.rowHeight = 90.0f;
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rock"]];
	
	
	//Playing with Firebase
	Firebase *f1 = [[Firebase alloc] initWithUrl:@"https://disco-sync.firebaseio.com/stream"];
	
/*	[f1 on:FEventTypeValue doCallback:^(FDataSnapshot *snap) {
		NSLog(@"Value : %@ %@", [snap val], [snap name]);
	}];
*/}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	DSCell *cell = [[DSCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Will Newton";
		cell.detailTextLabel.text = @"Moombahton, Dutch";
		cell.listenerCount = @"123";
	}
	
	else if (indexPath.row == 1) {
		cell.textLabel.text = @"Knife Party";
		cell.detailTextLabel.text = @"EDM";
		cell.listenerCount = @"122";
	}
	
	else if (indexPath.row == 2) {
		cell.textLabel.text = @"Deadmau5";
		cell.detailTextLabel.text = @"House";
		cell.listenerCount = @"122";
	}
	
	else if (indexPath.row == 3) {
		cell.textLabel.text = @"The Glitch Mob";
		cell.detailTextLabel.text = @"Glitch";
		cell.listenerCount = @"9999999";
	}
	
	else if (indexPath.row == 4) {
		cell.textLabel.text = @"Dilon Francis";
		cell.detailTextLabel.text = @"Whatever he plays";
		cell.listenerCount = @"1234";
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	DSDiscoRoomViewController *room = [[DSDiscoRoomViewController alloc] init];
	DSCell *cell = (DSCell *)[tableView cellForRowAtIndexPath:indexPath];
	room.DJName.text = cell.textLabel.text;
	room.genre.text = cell.detailTextLabel.text;
	room.listeners.text = cell.numberOfListeners.text;
	
	if (indexPath.row % 3 == 0) {
		room.backgroundView.image = [UIImage imageNamed:@"room-1"];
	}
	
	else if (indexPath.row % 3 == 1) {
		room.backgroundView.image = [UIImage imageNamed:@"room-2"];
	}
	
	else if (indexPath.row % 3 == 2) {
		room.backgroundView.image = [UIImage imageNamed:@"room-3"];
	}
	
	[self.navigationController pushViewController:room animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
