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
#import "MBProgressHUD.h"

@interface DSViewController ()

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, strong) NSMutableDictionary *latestSnapshotDict;
@property (nonatomic, strong) NSArray *rooms;

@end

@implementation DSViewController

- (void)setLatestSnapshotDict:(NSMutableDictionary *)latestSnapshotDict {
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	// NSLog(@"new root snapshot: %@", latestSnapshotDict); // can be used to demonstrate firebase bug, lolz
	if (!_latestSnapshotDict) {
		_latestSnapshotDict = [latestSnapshotDict mutableCopy];
	}
	else {
		for (NSString *key in [latestSnapshotDict allKeys]) {
			NSLog(@"merging for key %@, new type: %@", key, NSStringFromClass([[latestSnapshotDict objectForKey:key] class]));
			if ([_latestSnapshotDict objectForKey:key]) {
				[(NSMutableDictionary *)[_latestSnapshotDict objectForKey:key] addEntriesFromDictionary:[latestSnapshotDict objectForKey:key]];
			}
			else {
				[_latestSnapshotDict setObject:[latestSnapshotDict objectForKey:key] forKey:key];
			}
		}
	}

	self.rooms = [_latestSnapshotDict allKeys];
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
	
	
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	hud.labelText = @"Loading Rooms";
	
}

- (void)setupNavigationBar {
	//Nav bar gradient
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bar"] forBarMetrics:UIBarMetricsDefault];

	//Nav item image
	[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-logo"]]];
	self.navigationItem.title = @"Discos"; //Not visible, but used to set backButton text on pushed views
}

- (void)setupFirebase {
	self.firebase = [[Firebase alloc] initWithUrl:@"https://disco-sync.firebaseio.com/rooms"];
	[self.firebase on:FEventTypeValue doCallback:^(FDataSnapshot *snapshot) {
		NSLog(@"Main room info updated");
		[self performSelectorOnMainThread:@selector(setLatestSnapshotDict:) withObject:snapshot.val waitUntilDone:NO];
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
	NSLog(@"Generating cell for roomName: %@", roomName);
	cell.firebase = [self.firebase child:roomName];
	cell.latestSnapshotDict = [self.latestSnapshotDict objectForKey:roomName];

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
	room.latestSnapshotDict = [self.latestSnapshotDict objectForKey:roomName];

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
