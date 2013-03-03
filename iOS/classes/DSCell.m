//
//  DSCell.m
//  DiscoSync
//
//  Created by Neal Ormsbee on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import "DSCell.h"

@implementation DSCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.textLabel.textColor = [UIColor whiteColor];
	self.textLabel.font = [UIFont boldSystemFontOfSize:32.0f];
	self.detailTextLabel.textColor	 = [UIColor whiteColor];
	
	self.numberOfListeners = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
	self.numberOfListeners.textAlignment = UITextAlignmentRight;
	self.numberOfListeners.backgroundColor = [UIColor clearColor];
	self.numberOfListeners.text = [self.listenerCount stringByAppendingString:@" listeners"];
	self.numberOfListeners.textColor = [UIColor whiteColor];
	[self.contentView addSubview:self.numberOfListeners];
}

@end
