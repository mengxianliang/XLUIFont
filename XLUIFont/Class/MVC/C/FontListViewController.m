//
//  FontListViewController.m
//  XLUIFont
//
//  Created by MengXianLiang on 2017/5/11.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "FontListViewController.h"
#import "XLSlideMenu.h"
#import "FontListHeader.h"

@interface FontListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_fontFamilyNames;
}
@end

@implementation FontListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildTable];
}

-(void)buildTable
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.xl_sldeMenu.menuWidth, 40)];
    searchBar.tintColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1];
    searchBar.barTintColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1];
    searchBar.placeholder = @"Search Font Name";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,20, self.xl_sldeMenu.menuWidth, self.view.bounds.size.height - 20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelectionDuringEditing = true;
    _tableView.editing = true;
    _tableView.tableHeaderView = searchBar;
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self fontNamesInSection:section].count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self fontFamilyNames].count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self fontFamilyNames][section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellId = @"cellId";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSString *fontName = [self fontNamesInSection:indexPath.section][indexPath.row];
    cell.textLabel.text = fontName;
    cell.textLabel.font = [UIFont fontWithName:fontName size:17];
    cell.textLabel.adjustsFontSizeToFitWidth = true;
    cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1];
    return cell;
}

-(NSArray *)fontNamesInSection:(NSInteger)section{
    NSString *familyName = [self fontFamilyNames][section];
    NSArray *fontNames  = [UIFont fontNamesForFamilyName:familyName];
    return fontNames;
}

-(NSArray *)fontFamilyNames{
    if (!_fontFamilyNames) {
        NSArray *familyNames = [UIFont familyNames];
        _fontFamilyNames = [familyNames sortedArrayUsingSelector:@selector(compare:)];
    }
    return _fontFamilyNames;
}

#pragma mark -
#pragma mark TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.xl_sldeMenu showRootViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
