//
//  ViewController.m
//  XLUIFont
//
//  Created by MengXianLiang on 2017/5/11.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "ViewController.h"
#import "XLSlideMenu.h"
#import "FontListViewController.h"

static NSString *DefaultSampleText = @"abc&ABC123!";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_fontNames;
    
    NSString *_sampleText;
    
    UIBarButtonItem *_composeItem;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"XLUIFont";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(showLeft)];
    
    _composeItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(edit)];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItems = @[refreshItem,_composeItem];
    
    _fontNames = [[NSMutableArray alloc] init];
    
    _sampleText = DefaultSampleText;
    
    _composeItem.enabled = false;
    
    [self buildTable];
}

-(void)buildTable
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fontNames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _sampleText;
    NSString *fontName = _fontNames[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:fontName size:20];
    cell.detailTextLabel.text = fontName;
    cell.detailTextLabel.textColor = BlueColor;
    return cell;
}

#pragma mark -
#pragma mark OtherMethods

-(void)addFontName:(NSString *)fontName{
    [_fontNames insertObject:fontName atIndex:0];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
    _composeItem.enabled = true;
}

-(void)removeFontName:(NSString *)fontName{
    NSInteger index = [_fontNames indexOfObject:fontName];
    [_fontNames removeObjectAtIndex:index];
    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    if (_fontNames.count == 0) {_composeItem.enabled = false;}
}

-(void)showLeft{
    [self.xl_sldeMenu showLeftViewControllerAnimated:true];
}

-(void)refresh{
    _sampleText = DefaultSampleText;
    [_fontNames removeAllObjects];
    [_tableView reloadData];
    FontListViewController *listVC = (FontListViewController *)self.xl_sldeMenu.leftViewController;
    [listVC refresh];
    _composeItem.enabled = false;
}

-(void)edit{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Input sample text" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

#pragma mark -
#pragma mark AlertViewDelegate
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 1) {return;}
    NSString *text = [alertView textFieldAtIndex:0].text;
    if (text.length == 0) {return;}
    _sampleText = text;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
