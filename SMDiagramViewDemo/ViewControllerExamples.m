//
//  ViewController2.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/24/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ViewControllerExamples.h"
#import "ExampleUIView1.h"
#import "ExampleUIView2.h"
#import "ExampleUIView3.h"
#import "ExampleUIView4.h"

@interface ViewControllerExamples ()

@end

@implementation ViewControllerExamples

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

@end
