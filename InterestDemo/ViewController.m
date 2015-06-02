//
//  ViewController.m
//  InterestDemo
//
//  Created by Pranay Mathur on 5/27/15.
//  Copyright (c) 2015 Wedig. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *informationView;
@end

@implementation ViewController
@synthesize dict,cat,selectedcell,previousselectedcell,collapse,previousIndexpath,isClickedArray,isGroupCheckedArray;
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
    self.isGroupCheckedArray = [[NSMutableArray alloc] initWithCapacity:(int)self.itemsInTable.count];
    for(int i=0; i< self.itemsInTable.count;i++)
    {
        [self.isClickedArray addObject:[NSNumber numberWithBool:NO]];
        [self.isGroupCheckedArray addObject:[NSNumber numberWithBool:NO]];
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
    //NSLog(@"Total No. Elements %d",total);
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
        return 40;
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
        cell.btnGroupTap.tag = indexPath.row;
        NSArray *count=(NSArray *)subcat;
        //NSDictionary *subcat =  cat;
        //NSLog(@"Total subcat = %lu\n subcat =%@\n",(unsigned long)count.count,subcat);
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
                    xoffset = 150;
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
                    yoffset = yoffset+45;
                }
            }
            NSString *sel = subcat[i][@"selected"];
            NSString *key =subcat[i][@"key"];
            //NSLog(@"key = %@",key);
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *image;
            if(![sel boolValue])
            {
                image = [UIImage imageNamed: @"unchecked.png"];
            }
            else
            {
                image = [UIImage imageNamed: @"checked.png"];
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(29,18,20,20)];
            [imageView setImage:image];
            //imageView.userInteractionEnabled = YES;
            
            
            UILabel *lbl1 = [[UILabel alloc] init];
            [lbl1 setFrame:CGRectMake(0,5,100,20)];
            lbl1.backgroundColor=[UIColor clearColor];
            lbl1.textColor=[UIColor blackColor];
            lbl1.frame = CGRectMake(40,0,100,40);
            lbl1.numberOfLines =0;
            [lbl1 setFont:[UIFont fontWithName:@"Roboto-Light" size:12]];
            lbl1.text= subcat[i][@"value"];
            //lbl1.userInteractionEnabled = YES;
            
            //[cell.ContainerView addSubview:lbl1];
            
            button.tag= [key integerValue];
            button.backgroundColor = [UIColor redColor];
            [button setTitle:@"" forState:UIControlStateNormal];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [button setBackgroundImage:image forState:normal];
            //[button setImage:image forState:normal];
            
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenWidth = screenRect.size.width;
            CGFloat screenHeight = screenRect.size.height;
            //float buttonWidth = (((screenHeight-screenWidth)/8));
            
            //NSLog(@"window width = %f\n height=%f\n buttonWidth = %f",screenWidth,screenHeight,buttonWidth);
            button.frame = CGRectMake(xoffset,20+yoffset,(screenWidth/2)-40,40);
            [button addTarget:self action:@selector(CheckAction:) forControlEvents:UIControlEventTouchUpInside];
            [button addSubview:lbl1];
            //[button addSubview:imageView];
            [cell.ContainerView addSubview:button];
            //[lbl1 bringSubviewToFront:button];
            //[imageView bringSubviewToFront:button];
            [cell.ContainerView bringSubviewToFront:button];
            //NSLog(@"%@",subcat[1][@"value"]);
            
            
            //[cell setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:0.75 alpha:1]];
            //[cell setAccessibilityTraits:UIAccessibilityTraitSelected];
            
            
            
            //NSLog(@"x=%d,y=%d,w=%d,h=%d",20+xoffset,0+yoffset,20,20);
        }
    //[cell setBackgroundColor:[UIColor whiteColor]];
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
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor whiteColor]];
    [cell setSelectedBackgroundView:bgColorView];
    cell.ContainerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"h_line.png"]];
    
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
        NSInteger indexPath = j;
        
        for (int i=0; i<array.count; i++) {
            
            NSMutableDictionary *dictionary = [array objectAtIndex:i];
            
            NSString *keyString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"key"]];
            NSString *selectedString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"selected"]];
            
            if([keyString isEqualToString:keyvalue]){
                if([selectedString isEqualToString:@"0"])
                {
                    [dictionary removeObjectForKey:@"selected"];
                    [dictionary setObject:[NSNumber numberWithBool:true] forKey:@"selected"];
                    image = [UIImage imageNamed: @"checked.png"];
                    
                }
                else
                {
                    if ([[isGroupCheckedArray objectAtIndex:indexPath] boolValue] == YES) {
                        [isGroupCheckedArray replaceObjectAtIndex:indexPath withObject:[NSNumber numberWithBool:NO]];
                        UIImage *image = [UIImage imageNamed: @"uncheck_box.png"];
                        UIButton *btn = (UIButton*)[self.view viewWithTag:indexPath];
                        NSLog(@"%@",btn);
                        [btn setBackgroundImage:image forState:UIControlStateNormal];
                        
                    }
                    // Cell is Unchecked -> Checked
                    else {
                        [isGroupCheckedArray replaceObjectAtIndex:indexPath withObject:[NSNumber numberWithBool:YES]];
                        UIImage *image = [UIImage imageNamed: @"check_box.png"];
                        UIButton *btn = (UIButton*)[self.view viewWithTag:indexPath];
                        [btn setBackgroundImage:image forState:UIControlStateNormal];
                    }
                    
                    [dictionary removeObjectForKey:@"selected"];
                    [dictionary setObject:[NSNumber numberWithBool:false] forKey:@"selected"];
                    image = [UIImage imageNamed: @"unchecked.png"];
                }
                //NSLog(@"dictionary = %@",dictionary);
            }
        }
    }
    
    /*for (UIView *subView in self.view.subviews) {
        if (subView.tag == (int)yourSubViewTag) {
            
            [subView removeFromSuperview];
        }
    }*/
    [sender setBackgroundImage:image forState:normal];
    //NSLog(@"sender = %@",dict);
    //NSLog(@"%@",sender);
}
- (IBAction)GroupTap:(id)sender {
    NSLog(@"%ld",(long)[sender tag]);
    // Button is Checked -> Unchecked
    if ([[isGroupCheckedArray objectAtIndex:[sender tag]] boolValue] == YES) {
        [isGroupCheckedArray replaceObjectAtIndex:[sender tag] withObject:[NSNumber numberWithBool:NO]];
        UIImage *image = [UIImage imageNamed: @"uncheck_box.png"];
        [sender setBackgroundImage:image forState:normal];
    }
    // Cell is Unchecked -> Checked
    else {
        [isGroupCheckedArray replaceObjectAtIndex:[sender tag] withObject:[NSNumber numberWithBool:YES]];
        UIImage *image = [UIImage imageNamed: @"check_box.png"];
        [sender setBackgroundImage:image forState:normal];
    }

    /*NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection:0];
    InterestTableViewCell *cell = (InterestTableViewCell *) [self.Mytabelview cellForRowAtIndexPath:indexPath];*/
    UIImage *image;
    NSMutableDictionary *valuesDic = [dict objectForKey:@"VALUE"];
    
    NSArray *allPossibleKeysArray = [valuesDic allKeys];
    for (int j=0; j<allPossibleKeysArray.count; j++) {
        NSString *keyStr = [allPossibleKeysArray objectAtIndex:j];
        if(j==[sender tag])
        {
            NSLog(@"%@",keyStr);
            NSArray *array = [valuesDic objectForKey:keyStr];
            for (int i=0; i<array.count; i++) {
                NSMutableDictionary *dictionary = [array objectAtIndex:i];
                NSString *selectedString = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"selected"]];
                NSInteger selectedKey = [[dictionary objectForKey:@"key"] integerValue];
                    if([selectedString isEqualToString:@"0"])
                    {
                        [dictionary removeObjectForKey:@"selected"];
                        [dictionary setObject:[NSNumber numberWithBool:true] forKey:@"selected"];
                       // NSLog(@"%ld is not selected",(long)selectedKey);
                         if ([[isGroupCheckedArray objectAtIndex:[sender tag]] boolValue] == YES)
                         {
                            image = [UIImage imageNamed: @"checked.png"];
                            UIButton *btn = (UIButton*)[self.view viewWithTag:selectedKey];
                            [btn setBackgroundImage:image forState:UIControlStateNormal];
                         }
                         else
                         {
                            image = [UIImage imageNamed: @"unchecked.png"];
                            UIButton *btn = (UIButton*)[self.view viewWithTag:selectedKey];
                            [btn setBackgroundImage:image forState:UIControlStateNormal];
                         }
                        
                    }
                    else
                    {
                        [dictionary removeObjectForKey:@"selected"];
                        [dictionary setObject:[NSNumber numberWithBool:false] forKey:@"selected"];
                        image = [UIImage imageNamed: @"unchecked.png"];
                        //NSLog(@"%ld is not selected",(long)selectedKey);
                        if ([[isGroupCheckedArray objectAtIndex:[sender tag]] boolValue] == YES)
                        {
                            image = [UIImage imageNamed: @"checked.png"];
                            UIButton *btn = (UIButton*)[self.view viewWithTag:selectedKey];
                            [btn setBackgroundImage:image forState:UIControlStateNormal];
                        }
                        else
                        {
                            image = [UIImage imageNamed: @"unchecked.png"];
                            UIButton *btn = (UIButton*)[self.view viewWithTag:selectedKey];
                            [btn setBackgroundImage:image forState:UIControlStateNormal];
                        }
                    }
                    NSLog(@"dictionary = %@",dictionary);
                
            }
        }
        
    }
    
    
    
}



@end
