//
//  DSDiscoRoomViewController.h
//  DiscoSync
//
//  Created by Neal Ormsbee on 3/2/13.
//  Copyright (c) 2013 Feathr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSDiscoRoomViewController : UIViewController

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UILabel *DJName;
@property (nonatomic, strong) UILabel *genre;
@property (nonatomic, strong) UILabel *listeners;
@property (nonatomic, strong) NSURL *targetURL;

- (void)configureLabels;

@end
