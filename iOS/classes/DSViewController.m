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
#import <Firebase/Firebase.h>

@interface DSViewController ()

@property (nonatomic, strong) NSArray *rooms;

@end

@implementation DSViewController

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
	self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
	
	//Nav item image
	[self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-logo"]]];
	self.navigationItem.title = @"Discos"; //Not visible, but used to set backButton text on pushed views
	
}

- (void)setupFirebase {
	Firebase* f1 = [[Firebase alloc] initWithUrl:@"https://disco-sync.firebaseio.com/rooms"];
	[f1 on:FEventTypeValue doCallback:^(FDataSnapshot *snapshot) {
		
		NSDictionary *snapVal = [snapshot val];
		NSMutableArray *arrayOfRooms = [[NSMutableArray alloc] init];
		
		for (NSString *roomKey in snapVal) {
			[arrayOfRooms addObject:[snapVal objectForKey:roomKey]];
		}
		
		self.rooms = [arrayOfRooms copy];
		[self.tableView reloadData];
	}];
}

- (void)setupTableView {
	
	self.tableView.separatorColor = [UIColor clearColor];
	self.tableView.rowHeight = 90.0f;
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rock"]];
	
}

#pragma mark - table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.rooms.count;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	DSCell *cell = [[DSCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	
	if (indexPath.row == 0) {
		cell.displayTopBorder = NO;
	}
	
	else if (indexPath.row == self.rooms.count - 1) {
		cell.displayBottomBorder = NO;
	}
	
	cell.textLabel.text = [self.rooms[indexPath.row] valueForKey:@"name"];
	cell.detailTextLabel.text = [self.rooms[indexPath.row] valueForKey:@"genre"];
	cell.listenerCount = [NSString stringWithFormat:@"%@", [self.rooms[indexPath.row] valueForKey:@"listeners"]];
	cell.targetURL = [NSURL URLWithString:[self.rooms[indexPath.row] valueForKey:@"songurl"]];
	
	return cell;
	
}

#pragma mark table view delegate methods

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
	
	[room configureLabels];
	room.targetURL = cell.targetURL;
	
	[self.navigationController pushViewController:room animated:YES];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
