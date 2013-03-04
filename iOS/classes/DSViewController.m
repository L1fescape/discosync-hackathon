//
//  DSViewController.m
//  DiscoSync
//
//  Created by Tommy Goode on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSViewController.h"
#import "DSDiscoRoomViewController.h"
#import "DSCell.h"

@interface DSViewController ()

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, strong) FDataSnapshot *latestSnapshot;
@property (nonatomic, strong) NSArray *rooms;

@end

@implementation DSViewController

- (void)setLatestSnapshot:(FDataSnapshot *)latestSnapshot {
	_latestSnapshot = latestSnapshot;
	NSDictionary *snapVal = [latestSnapshot val];
	self.rooms = [snapVal allKeys];
	[self.tableView reloadData];
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	//Set nav bar style and title image
	[self setupNavigationBar];
	
	//Initialize firebase
	[self setupFirebase];
	
	//Set table view styles
	[self setupTableView];
	
}

- (void)setupNavigationBar {
	//Nav bar gradient
	UIImageView *headerGradient = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,44)];
	headerGradient.image = [UIImage imageNamed:@"header-bar"];
	[self.navigationController.navigationBar insertSubview:headerGradient atIndex:1];
	// [self.navigationController.navigationBar sendSubviewToBack:headerGradient];
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

	//Nav item image
	[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-logo"]]];
	self.navigationItem.title = @"Discos"; //Not visible, but used to set backButton text on pushed views
}

- (void)setupFirebase {
	self.firebase = [[Firebase alloc] initWithUrl:@"https://disco-sync.firebaseio.com/rooms"];
	[self.firebase on:FEventTypeValue doCallback:^(FDataSnapshot *snapshot) {
		NSLog(@"Main room info updated");
		[self performSelectorOnMainThread:@selector(setLatestSnapshot:) withObject:snapshot waitUntilDone:NO];
	}];
}

- (void)setupTableView {
	self.tableView.separatorColor = [UIColor clearColor];
	self.tableView.rowHeight = 90.0f;
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rock"]];
	[self.tableView reloadData];
}

#pragma mark - table view data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	DSCell *cell = [[DSCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	NSString *roomName = [self.rooms objectAtIndex:indexPath.row];
	NSLog(@"roomName: %@", roomName);
	cell.firebase = [self.firebase child:roomName];
	cell.latestSnapshot = [self.latestSnapshot child:roomName];

	if (indexPath.row == 0) {
		cell.displayTopBorder = NO;
	}

	else if (indexPath.row == self.rooms.count - 1) {
		cell.displayBottomBorder = NO;
	}

	return cell;
}

#pragma mark table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Room clicked");
	DSDiscoRoomViewController *room = [[DSDiscoRoomViewController alloc] init];
	NSString *roomName = [self.rooms objectAtIndex:indexPath.row];
	room.firebase = [self.firebase child:roomName];
	room.latestSnapshot = [self.latestSnapshot child:roomName];

	if (indexPath.row % 3 == 0) {
		room.backgroundView.image = [UIImage imageNamed:@"room-1"];
	}

	else if (indexPath.row % 3 == 1) {
		room.backgroundView.image = [UIImage imageNamed:@"room-2"];
	}

	else if (indexPath.row % 3 == 2) {
		room.backgroundView.image = [UIImage imageNamed:@"room-3"];
	}

	NSLog(@"Pushing room");
	[self.navigationController pushViewController:room animated:YES];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
