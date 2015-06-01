//
//  ViewController.m
//  InterestDemo
//
//  Created by Pranay Mathur on 5/27/15.
//  Copyright (c) 2015 Wedig. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize dict,cat,selectedcell,previousselectedcell,collapse,previousIndexpath,isClickedArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    previousselectedcell=-1;
    selectedcell = -2;
    collapse =@"true";
    // Do any additional setup after loading the view, typically from a nib.
    self.dict=[[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    self.items=[dict valueForKey:@"VALUE"];
    cat =[[NSMutableDictionary alloc] init];
    cat =[dict objectForKey:@"VALUE"];
    
    self.itemsInTable=[[NSMutableArray alloc] init];
    [self.itemsInTable addObjectsFromArray:self.items];
    self.fruits = @[@"Apple", @"Pineapple", @"Orange", @"Banana", @"Pear", @"Kiwi", @"Strawberry", @"Mango", @"Walnut", @"Apricot", @"Tomato", @"Almond", @"Date", @"Melon", @"Water Melon", @"Lemon", @"Blackberry", @"Coconut", @"Fig", @"Passionfruit", @"Star Fruit"];
    
    self.isClickedArray = [[NSMutableArray alloc] initWithCapacity:(int)self.itemsInTable.count];
    for(int i=0; i< self.itemsInTable.count;i++)
    {
        [self.isClickedArray addObject:[NSNumber numberWithBool:NO]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *category= (NSString *)[self.itemsInTable objectAtIndex:indexPath.row];
    //NSLog(@"indexpath= %@\n %@",indexPath,category);
    NSMutableArray *subcat =[[NSMutableArray alloc] init];
    NSArray *keys = [cat allKeys];
    id aKey = [keys objectAtIndex:indexPath.row];
    subcat = [cat objectForKey:aKey];
    
    NSArray *count=(NSArray *)subcat;
    //NSDictionary *subcat =  cat;
    NSLog(@"Total subcat = %lu\n subcat =%@\n",(unsigned long)count.count,subcat);
    
    int total = (int)count.count;
    NSLog(@"Total No. Elements %d",total);
    int fix = 60;
    int offset = 60;
    int send;
    if(total==0)
    {
        send = fix;
    }
    else
    {
        send = fix+(offset*(total/2));
    }
    
    //NSLog(@"indexrow = %ld \n pre = %d\n sel = %d \n",(long)[indexPath row],previousselectedcell,selectedcell);
    if([[self.isClickedArray objectAtIndex:indexPath.row] boolValue] == YES)
    {
        return  send;
    }
    /*else if ([indexPath row] == selectedcell) {
       
            return  send;
    }*/
    else
    {
        return 60;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return [self.fruits count];
    return [self.itemsInTable count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    InterestTableViewCell *cell = (InterestTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Fetch Fruit
    //NSString *fruit = [self.fruits objectAtIndex:[indexPath row]];
    
    NSString *category= (NSString *)[self.itemsInTable objectAtIndex:indexPath.row];
    //if ([indexPath row] == selectedcell) {
        
        NSMutableArray *subcat =[[NSMutableArray alloc] init];
        NSArray *keys = [cat allKeys];
        id aKey = [keys objectAtIndex:indexPath.row];
        ///id anObject = [dict objectForKey:aKey];
        subcat = [cat objectForKey:aKey];

        NSArray *count=(NSArray *)subcat;
        //NSDictionary *subcat =  cat;
        NSLog(@"Total subcat = %lu\n subcat =%@\n",(unsigned long)count.count,subcat);
        int xoffset;
        int yoffset = 0;
        for(int i=0; i<count.count;i++)
        {
            
            if(i==0)
            {
                xoffset=0;
            }
            else
            {
                if(i%2 == 0)
                {
                xoffset = 0;
                }
                else
                {
                    xoffset = 180;
                }
            }
            if(i==0)
            {
                yoffset = 0;
            }
            else
            {
                if(i%2==0)
                {
                    yoffset = yoffset+40;
                }
            }
            NSString *sel = subcat[i][@"selected"];
            NSString *key =subcat[i][@"key"];
            NSLog(@"key = %@",key);
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *image;
            if(![sel boolValue])
            {
                image = [UIImage imageNamed: @"uncheck_box.png"];
            }
            else
            {
                image = [UIImage imageNamed: @"check_box.png"];
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,40,20,20)];
            [imageView setImage:image];
            //imageView.userInteractionEnabled = YES;
            
            
            UILabel *lbl1 = [[UILabel alloc] init];
            [lbl1 setFrame:CGRectMake(0,5,100,20)];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.textColor=[UIColor blackColor];
            lbl1.frame = CGRectMake(30,0,100,100);
            lbl1.text= subcat[i][@"value"];
            //lbl1.userInteractionEnabled = YES;
            
            //[cell.ContainerView addSubview:lbl1];
            
             button.tag= [key integerValue];
            button.backgroundColor = [UIColor redColor];
            [button setTitle:@"" forState:UIControlStateNormal];
            //[button setImage:image forState:normal];
            
            button.frame = CGRectMake(25+xoffset,yoffset,120,120);
            [button addTarget:self action:@selector(CheckAction:) forControlEvents:UIControlEventTouchUpInside];
            [button addSubview:lbl1];
            [button addSubview:imageView];
            [cell.ContainerView addSubview:button];
            //[lbl1 bringSubviewToFront:button];
            //[imageView bringSubviewToFront:button];
            NSLog(@"%@",subcat[1][@"value"]);
            
            
            
            
            
            
            NSLog(@"x=%d,y=%d,w=%d,h=%d",20+xoffset,0+yoffset,20,20);
        }
    //}
    // NSArray *subcat = [[self.itemsInTable objectAtIndex:indexPath.row] valueForKey:@"Subcategory"];
    cell.ContainerView.hidden=YES;
    //[cell.lblCategory setText:fruit];
    //cell.lblCategory.text = fruit;
    cell.lblCategory.text = category;
    //cell.lblSubCat1.text = subcat[0];
    //cell.lblSubCat2.text = subcat[1];
    
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InterestTableViewCell *cell = (InterestTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    // Cell is OPEN -> CLOSED
    if ([[self.isClickedArray objectAtIndex:indexPath.row] boolValue] == YES) {
        [self.isClickedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        cell.ContainerView.hidden = YES;
        UIImage *image = [UIImage imageNamed: @"list_right_arrow.png"];
        [cell.image setImage:image];
    }
    // Cell is CLOSED -> OPEN
    else {
        [self.isClickedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        cell.ContainerView.hidden = NO;
        UIImage *image = [UIImage imageNamed: @"list_down_arrow.png"];
        [cell.image setImage:image];
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
    /*if([collapse isEqualToString:@"true"])
    {
        collapse = @"false";
    }
    else
    {
            collapse = @"true";
    }
    int row = (int)[indexPath row];
    if(previousselectedcell != -1)
    {
        InterestTableViewCell *previouscell = (InterestTableViewCell *) [tableView cellForRowAtIndexPath:previousIndexpath];
        previouscell.ContainerView.hidden=YES;
        if(selectedcell != row)
        {
            previousselectedcell = selectedcell;
            previousIndexpath = indexPath;
        }
    }*/
    
    
    
    
    //selectedcell = row;
//    if([collapse isEqualToString:@"true"])
//    {
//        cell.ContainerView.hidden = NO;
//        UIImage *image = [UIImage imageNamed: @"list_down_arrow.png"];
//        [cell.image setImage:image];
//    }
//    else
//    {
//        cell.ContainerView.hidden = YES;
//        UIImage *image = [UIImage imageNamed: @"list_right_arrow.png"];
//        [cell.image setImage:image];
//    }
    
    
   
    
    
    /*if(previousselectedcell == -1)
    {
        previousselectedcell = selectedcell;
    }*/
    
}

/*-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    InterestTableViewCell *cell = (InterestTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    if ([[self.isClickedArray objectAtIndex:indexPath.row] boolValue] == YES) {
        [self.isClickedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        cell.ContainerView.hidden = YES;
        UIImage *image = [UIImage imageNamed: @"list_right_arrow.png"];
        [cell.image setImage:image];
    }
    // Cell is CLOSED -> OPEN
    else {
        [self.isClickedArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        cell.ContainerView.hidden = NO;
        UIImage *image = [UIImage imageNamed: @"list_down_arrow.png"];
        [cell.image setImage:image];
    }

}*/

- (IBAction)CheckAction:(UIButton *)sender
{
    NSString *keyvalue = [NSString stringWithFormat: @"%ld", (long)sender.tag];
    UIImage *image;
    
    NSMutableDictionary *valuesDic = [dict objectForKey:@"VALUE"];
    
    
    NSArray *allPossibleKeysArray = [valuesDic allKeys];
    
    for (int j=0; j<allPossibleKeysArray.count; j++) {
        
        NSString *keyStr = [allPossibleKeysArray objectAtIndex:j];
        
        NSArray *array = [valuesDic objectForKey:keyStr];
        
        for (int i=0; i<array.count; i++) {
            
            NSMutableDictionary *dictionary = [array objectAtIndex:i];
            
            NSString *keyString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"key"]];
            NSString *selectedString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"selected"]];
            
            if([keyString isEqualToString:keyvalue]){
                if([selectedString isEqualToString:@"0"])
                {
                    [dictionary removeObjectForKey:@"selected"];
                    [dictionary setObject:[NSNumber numberWithBool:true] forKey:@"selected"];
                    image = [UIImage imageNamed: @"check_box.png"];
                    
                }
                else
                {
                    [dictionary removeObjectForKey:@"selected"];
                    [dictionary setObject:[NSNumber numberWithBool:false] forKey:@"selected"];
                    image = [UIImage imageNamed: @"uncheck_box.png"];
                }
                NSLog(@"dictionary = %@",dictionary);
            }
        }
    }
    NSLog(@"sender = %@",dict);
    NSLog(@"%@",sender.imageView.image);
}

@end
