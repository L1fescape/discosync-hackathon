//
//  DSCell.h
//  DiscoSync
//
//  Created by Neal Ormsbee on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSCell : UITableViewCell

@property (nonatomic, strong) UILabel *numberOfListeners;
@property (nonatomic, strong) NSString *listenerCount;
@property (nonatomic) BOOL displayTopBorder;
@property (nonatomic) BOOL displayBottomBorder;

@end
