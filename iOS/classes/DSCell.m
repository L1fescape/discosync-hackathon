//
//  DSCell.m
//  DiscoSync
//
//  Created by Neal Ormsbee on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSCell.h"

@implementation DSCell

- (void)setFirebase:(Firebase *)firebase {
	_firebase = firebase;
	[_firebase on:FEventTypeValue doCallback:^(FDataSnapshot *snapshot) {
		[self performSelectorOnMainThread:@selector(setLatestSnapshotDict:) withObject:snapshot.val waitUntilDone:NO];
	}];
}

- (void)setLatestSnapshotDict:(NSMutableDictionary *)latestSnapshotDict {
	if (!_latestSnapshotDict) {
		_latestSnapshotDict = [latestSnapshotDict mutableCopy];
	}
	else {
		[_latestSnapshotDict addEntriesFromDictionary:latestSnapshotDict];
	}

	[self updateDisplay];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.selectionStyle = UITableViewCellSelectionStyleGray;
		self.displayTopBorder = YES;
		self.displayBottomBorder = YES;
    }
    return self;
}

- (void)updateDisplay {
	self.textLabel.text = [self.latestSnapshotDict valueForKey:@"name"];
	self.detailTextLabel.text = [self.latestSnapshotDict valueForKey:@"genre"];
	self.listenerCount = [NSString stringWithFormat:@"%@", [self.latestSnapshotDict valueForKey:@"listeners"]];
	self.targetURL = [NSURL URLWithString:[self.latestSnapshotDict valueForKey:@"songurl"]];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.textLabel.textColor = [UIColor whiteColor];
	self.textLabel.font = [UIFont boldSystemFontOfSize:32.0f];
	CGRect textLabelFrame = self.textLabel.frame;
	textLabelFrame.origin.y = textLabelFrame.origin.y - 2;
	self.textLabel.frame = textLabelFrame;
	self.textLabel.shadowColor = [UIColor blackColor];
	self.textLabel.shadowOffset = CGSizeMake(0,1);
	
	self.detailTextLabel.textColor	 = [UIColor whiteColor];
	self.detailTextLabel.font = [UIFont italicSystemFontOfSize:21.0f];
	CGRect detailTextLabelFrame = self.detailTextLabel.frame;
	detailTextLabelFrame.origin.y = detailTextLabelFrame.origin.y + 3;
	self.detailTextLabel.frame = detailTextLabelFrame;
	self.detailTextLabel.shadowOffset = CGSizeMake(0,1);
	self.detailTextLabel.shadowColor = [UIColor blackColor];
	
	
	self.numberOfListeners = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width - 10, 20)];
	self.numberOfListeners.textAlignment = UITextAlignmentRight;
	self.numberOfListeners.backgroundColor = [UIColor clearColor];
	self.numberOfListeners.text = [self.listenerCount stringByAppendingString:@" listening"];
	self.numberOfListeners.textColor = [UIColor whiteColor];
	self.numberOfListeners.font = [UIFont systemFontOfSize:16.0f];
	self.numberOfListeners.shadowColor = [UIColor blackColor];
	self.numberOfListeners.shadowOffset = CGSizeMake(0,1);
	[self.contentView addSubview:self.numberOfListeners];
	
	if (self.displayBottomBorder) {
		UIView *lowerBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
		lowerBorder.backgroundColor = [UIColor blackColor];
		[self.contentView addSubview:lowerBorder];
	}
	
	else {
		UIView *lowerBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 1)];
		lowerBorder.backgroundColor = [UIColor blackColor];
		[self.contentView addSubview:lowerBorder];
		UIView *otherLowerBorder = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
		otherLowerBorder.backgroundColor = [UIColor darkGrayColor];
		[self.contentView addSubview:otherLowerBorder];
	}
	
	if (self.displayTopBorder) {
		UIView *upperBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
		upperBorder.backgroundColor = [UIColor darkGrayColor];
		[self.contentView addSubview:upperBorder];
	}
}

@end
