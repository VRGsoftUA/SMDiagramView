//
//  ExampleUIView4.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/30/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ExampleUIView4.h"

@implementation ExampleUIView4

- (void)setup
{
    [super setup];
    
    diagramView.diagramViewMode = SMDiagramViewModeSegment;
    diagramView.diagramOffset = CGPointMake(0.f, 0.f);
    diagramView.startAngle = -M_PI_2;
    diagramView.endAngle = M_PI;
    
    [diagramView reloadData];
}


#pragma mark - SMDiagramViewDataSource

- (NSInteger)numberOfSegmentsInDiagramView:(nonnull SMDiagramView *)diagramView
{
    return 8;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForSegmentAtIndex:(NSInteger)index proportion:(CGFloat)proportion angle:(CGFloat)angle
{
    return width/2.2f;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView proportionForSegmentAtIndex:(NSInteger)index
{
    CGFloat result = 0.f;
    switch (index) {
        case 0:
            result = 0.8f/8.f;
            break;
        case 1:
            result = 1.2f/8.f;
            break;
        case 2:
            result = 1.5f/8.f;
            break;
        case 3:
            result = 0.8f/8.f;
            break;
        case 4:
            result = 1.f/8.f;
            break;
        case 5:
            result = 0.9f/8.f;
            break;
        case 6:
            result = 1.f/8.f;
            break;
        case 7:
            result = 0.8f/8.f;
            break;
        default:
            break;
    }
    return result;
}

@end
