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

@end

@implementation DSViewController

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	//Set nav bar style and title image
	[self setupNavigationBar];
	
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

- (void)setupTableView {
	
	self.tableView.separatorColor = [UIColor clearColor];
	self.tableView.rowHeight = 90.0f;
	self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rock"]];
	
}

#pragma mark - table view data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//@TODO: In the future, this would query a server to find out how many DJ's are present at a given event
	return 5;
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	DSCell *cell = [[DSCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	
	if (indexPath.row == 0) {
		cell.textLabel.text = @"Will Newton";
		cell.detailTextLabel.text = @"Moombahton, Dutch";
		cell.listenerCount = @"42";
		cell.displayTopBorder = NO;
	}
	
	else if (indexPath.row == 1) {
		cell.textLabel.text = @"Knife Party";
		cell.detailTextLabel.text = @"Dubstep, Electro";
		cell.listenerCount = @"901";
	}
	
	else if (indexPath.row == 2) {
		cell.textLabel.text = @"Deadmau5";
		cell.detailTextLabel.text = @"House";
		cell.listenerCount = @"7821";
	}
	
	else if (indexPath.row == 3) {
		cell.textLabel.text = @"The Glitch Mob";
		cell.detailTextLabel.text = @"Glitch Hop";
		cell.listenerCount = @"431";
	}
	
	else if (indexPath.row == 4) {
		cell.textLabel.text = @"Dilon Francis";
		cell.detailTextLabel.text = @"Moombahton";
		cell.listenerCount = @"23";
		cell.displayBottomBorder = NO;
	}
	
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
	
	[self.navigationController pushViewController:room animated:YES];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
