//
//  ViewController.m
//  PruebaSwipeCell
//
//  Created by Pablo on 29/6/15.
//  Copyright (c) 2015 Bioshook. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController () <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, MyTableViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSMutableArray *testArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // If you set the seperator inset on iOS 6 you get a NSInvalidArgumentException...weird
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0); // Makes the horizontal row seperator stretch the entire length of the table view
    }
    
    _sections = [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    
    _testArray = [[NSMutableArray alloc] init];
    
    
    for (int i = 0; i < _sections.count; ++i) {
        [_testArray addObject:[NSMutableArray array]];
    }
    
    for (int i = 0; i < 100; ++i) {
        NSString *string = [NSString stringWithFormat:@"%d", i];
        [_testArray[i % _sections.count] addObject:string];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _testArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_testArray[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sections[section];
}

// Show index titles

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Mcell";
    
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDate *dateObject = _testArray[indexPath.section][indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.titleLabel.text = [dateObject description];
    cell.titleLabel.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
    
}

- (void)cellSwiper:(NSIndexPath*)indexPath{
    [_testArray[indexPath.section] removeObjectAtIndex:indexPath.row];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

@end