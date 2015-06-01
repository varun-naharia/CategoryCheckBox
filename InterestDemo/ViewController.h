//
//  ViewController.h
//  InterestDemo
//
//  Created by Pranay Mathur on 5/27/15.
//  Copyright (c) 2015 Wedig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestTableViewCell.h"
@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *items;
@property NSArray *fruits;
@property (nonatomic, retain) NSMutableArray *itemsInTable;
@property(nonatomic,retain)NSMutableDictionary *dict;
@property(nonatomic,retain)NSMutableDictionary *cat;
@property(nonatomic) int selectedcell;
@property(nonatomic) int previousselectedcell;
@property(nonatomic) NSString *collapse;
//@property(nonatomic,strong) InterestTableViewCell *cell;
//@property(nonatomic,retain)NSMutableDictionary *category;
@property (weak, nonatomic) IBOutlet UITableView *Mytabelview;
@property(weak,nonatomic) NSIndexPath *previousIndexpath;
@property (nonatomic, retain) NSMutableArray *isClickedArray;


@end

