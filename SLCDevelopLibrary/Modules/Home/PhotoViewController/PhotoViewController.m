//
//  PhotoViewController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/26.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@end

@implementation PhotoViewController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutPageSubviews];
}

- (void)layoutPageSubviews {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

#pragma mark - event response

#pragma mark - private mothods

#pragma mark - getters and setters

@end
