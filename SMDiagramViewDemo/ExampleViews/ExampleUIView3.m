//
//  ExampleUIView3.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/30/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ExampleUIView3.h"

@implementation ExampleUIView3

- (void)setup
{
    [super setup];
    
    diagramView.diagramViewMode = SMDiagramViewModeSegment;
    diagramView.diagramOffset = CGPointMake(0.f, -50.f);
    diagramView.minProportion = 0.05f;
    
    [diagramView reloadData];
}


#pragma mark - SMDiagramViewDataSource

- (NSInteger)numberOfSegmentsInDiagramView:(nonnull SMDiagramView *)diagramView
{
    return 6;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView proportionForSegmentAtIndex:(NSInteger)index
{
    CGFloat result = 0.f;
    switch (index) {
        case 0:
            result = 0.4f/6.f;
            break;
        case 1:
            result = 1.2f/6.f;
            break;
        case 2:
            result = 1.4f/6.f;
            break;
        case 3:
            result = 0.8f/6.f;
            break;
        case 4:
            result = 1.3f/6.f;
            break;
        case 5:
            result = 0.9f/6.f;
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
        case 0:
            result = width/2.2f;
            break;
        default:
            result = width/2.8f;
            break;
    }
    return result;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForView:(UIView *)view atIndex:(NSInteger)index radiusOfSegment:(CGFloat)radiusOfSegment angle:(CGFloat)angle
{
    CGFloat result = 0.f;
    switch (index) {
        case 0:
            result = radiusOfSegment + 20.f;
            break;
        default:
            result = radiusOfSegment - 20.f;
            break;
    }
    return result;
}

- (UIView *)diagramView:(SMDiagramView *)diagramView viewForSegmentAtIndex:(NSInteger)index colorOfSegment:(UIColor *)colorOfSegment angle:(CGFloat)angle
{
    return [self viewForSegmentAtIndex:index];
}

@end
