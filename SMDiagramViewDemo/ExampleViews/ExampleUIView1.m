//
//  ExampleUIView1.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/30/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ExampleUIView1.h"

@implementation ExampleUIView1

- (void)setup
{
    [super setup];
    
    diagramView.separatorWidh = 6.f;
    diagramView.startAngle = -M_PI;
    diagramView.endAngle = 0;
    diagramView.diagramOffset = CGPointMake(5.f, 0.f);
    diagramView.titleView = [self titleView];
    
    [diagramView reloadData];
}


#pragma mark - SMDiagramViewDataSource

- (NSInteger)numberOfSegmentsInDiagramView:(nonnull SMDiagramView *)diagramView
{
    return 5;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForSegmentAtIndex:(NSInteger)index proportion:(CGFloat)proportion angle:(CGFloat)angle
{
    return width/3.5f;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForView:(UIView *)view atIndex:(NSInteger)index radiusOfSegment:(CGFloat)radiusOfSegment angle:(CGFloat)angle
{
    return radiusOfSegment + 20.f;
}

- (CGPoint)diagramView:(SMDiagramView *)diagramView offsetForView:(UIView *)view atIndex:(NSInteger)index angle:(CGFloat)angle
{
    CGPoint result = CGPointZero;
    switch (index) {
        case 0:
            result = CGPointMake(-7.f, -20.f);
            break;
        case 1:
            result = CGPointMake(-4.f, -10.f);
            break;
        case 2:
            result = CGPointMake(0, -5.f);
            break;
        case 3:
            result = CGPointMake(4.f, -10.f);
            break;
        case 4:
            result = CGPointMake(7.f, -20.f);
            break;
        default:
            break;
    }
    return result;
}

- (UIView *)diagramView:(SMDiagramView *)diagramView viewForSegmentAtIndex:(NSInteger)index colorOfSegment:(UIColor *)colorOfSegment angle:(CGFloat)angle
{
    return [self viewForSegmentAtIndex:index];
}

@end
