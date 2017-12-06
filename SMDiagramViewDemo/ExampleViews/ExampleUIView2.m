//
//  ExampleUIView2.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/30/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ExampleUIView2.h"

@implementation ExampleUIView2

- (void)setup
{
    [super setup];
    
    diagramView.separatorWidh = 0.f;
    diagramView.diagramOffset = CGPointMake(-5.f, 30.f);
    diagramView.titleView = [self titleView];
    [diagramView reloadData];
}


#pragma mark - SMDiagramViewDataSource

- (NSInteger)numberOfSegmentsInDiagramView:(nonnull SMDiagramView *)diagramView
{
    return 5;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView proportionForSegmentAtIndex:(NSInteger)index
{
    CGFloat result = 0.f;
    switch (index) {
        case 0:
            result = 1.f/5.f;
            break;
        case 1:
            result = 2.f/5.f;
            break;
        case 2:
            result = 0.2f/5.f;
            break;
        case 3:
            result = 0.5f/5.f;
            break;
        case 4:
            result = 1.3f/5.f;
            break;
            
        default:
            break;
    }
    return result;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForSegmentAtIndex:(NSInteger)index proportion:(CGFloat)proportion angle:(CGFloat)angle
{
    CGFloat result = 0.f;
    switch (index) {
        case 1:
            result = width/2.5f + 3.f;
            break;
        default:
            result = width/2.5f;
            break;
    }
    return result;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView lineWidthForSegmentAtIndex:(NSInteger)index angle:(CGFloat)angle
{
    CGFloat result = 0.f;
    switch (index) {
        case 1:
            result = 12.f;
            break;
        default:
            result = 6.f;
            break;
    }
    return result;
}

@end
