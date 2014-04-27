//
//  HomeViewController.m
//  ubercam
//
//  Created by FangYiXiong on 14-4-25.
//  Copyright (c) 2014年 Fang YiXiong. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = @"Photo";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 3;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadObjects];
}

- (void)objectsDidLoad:(NSError *)error{
    [super objectsDidLoad:error];
}

 // Override if you need to change the ordering of objects in the table.
// return objects in a different indexpath order. in this case we return object based on the section, not row, the default is row.
- (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
    if (indexPath.section < self.objects.count) {
        return [self.objects objectAtIndex:indexPath.section];
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == self.objects.count) {
        return nil;
    }
    static NSString *CellIdentifier = @"SectionHeaderCell";
    UITableViewCell *sectionHeaderView = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFImageView *profileImageView = (PFImageView *)[sectionHeaderView viewWithTag:1];
    UILabel *userNameLabel = (UILabel *)[sectionHeaderView viewWithTag:2];
    UILabel *titleLabel = (UILabel *)[sectionHeaderView viewWithTag:3];
    
    PFObject *photo = self.objects[section];
    PFUser *user = photo[@"whoTook"];
    PFFile *profilePicture = user[@"profilePicture"];
    NSString *title = photo[@"title"];
    
    userNameLabel.text = user.username;
    titleLabel.text = title;
    
    profileImageView.file = profilePicture;
    [profileImageView loadInBackground];
    return sectionHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger sections = self.objects.count;
    if (self.paginationEnabled && sections >0) {
        sections ++;
    }
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    if (indexPath.section == self.objects.count) {
        UITableViewCell *cell = [self tableView:tableView cellForNextPageAtIndexPath:indexPath];
        return cell;
    }
    static NSString *CellIdentifier = @"PhotoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    PFImageView *photo = (PFImageView *)[cell viewWithTag:1];
    photo.file = object[@"image"];
    [photo loadInBackground];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == self.objects.count) {
        return 0.0f;
    }
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.objects.count) {
        return 50.0f;
    }
    return 320.f;
}

//Override this method to customize the cell that allows the user to load the
//next page when pagination is turned on.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"LoadMoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == self.objects.count && self.paginationEnabled) {
        [self loadNextPage];
    }
}



- (PFQuery *)queryForTable{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query includeKey:@"whoTook"];
    [query orderByDescending:@"createdAt"];
    return query;
}



@end
