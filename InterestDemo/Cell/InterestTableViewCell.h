//
//  InterestTableViewCell.h
//  InterestDemo
//
//  Created by Pranay Mathur on 5/27/15.
//  Copyright (c) 2015 Wedig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblSubCat1;
@property (weak, nonatomic) IBOutlet UILabel *lblSubCat2;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet UIView *ContainerView;
//@property (weak, nonatomic) IBOutlet UIButton *btnToggle;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@end
