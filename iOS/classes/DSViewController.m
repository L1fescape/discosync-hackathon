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
	Firebase *f1 = [[Firebase alloc] initWithUrl:@"https://discosync.firebase.com"];
	
	[f1 on:FEventTypeValue doCallback:^(FDataSnapshot *snap) {
		NSLog(@"Value : %@ %@", [snap val], [snap name]);
	}];
	
	[f1 set:@"hello, world"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
	cell.textLabel.text = @"DJ Name";
	cell.detailTextLabel.text = @"Genre";
	UILabel *derp = [[UILabel alloc] initWithFrame:CGRectMake(0, cell.frame.size.height*3/4, cell.frame.size.width - 20, cell.frame.size.height/4)];
	derp.textAlignment = NSTextAlignmentRight;
	derp.backgroundColor = [UIColor clearColor];
	derp.font = [UIFont systemFontOfSize:12.0];
	derp.text = @"123";
	[cell.contentView addSubview:derp];
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
