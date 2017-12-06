//
//  ExampleUIViewCommon.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/30/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ExampleUIViewCommon.h"
#import "Utils.h"

@interface ExampleUIViewCommon ()

@end

@implementation ExampleUIViewCommon

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    width = [[UIScreen mainScreen] bounds].size.width/2;
    
    diagramView = [[SMDiagramView alloc] initWithFrame:self.bounds];
    diagramView.dataSource = self;
    diagramView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:diagramView];
    diagramView.backgroundColor = [UIColor clearColor];
}


#pragma mark - SMDiagramViewDataSource

- (NSInteger)numberOfSegmentsInDiagramView:(nonnull SMDiagramView *)diagramView
{
    return 0;
}

- (UIColor *)diagramView:(SMDiagramView *)diagramView colorForSegmentAtIndex:(NSInteger)index angle:(CGFloat)angle
{
    return [Utils colorForIndex:index];
}


#pragma mark - Utils

- (UIView *)titleView
{
    UILabel *titleView = [[UILabel alloc] init];
    titleView.numberOfLines = 0;
    titleView.font = [UIFont systemFontOfSize:12];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.text = @"This Is\nTitle\nView";
    [titleView sizeToFit];
    return titleView;
}

- (UIView *)viewForSegmentAtIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.clipsToBounds = YES;
    label.text = @(index+1).stringValue;
    label.layer.cornerRadius = 10;
    label.backgroundColor = [Utils colorForIndex:index];
    return label;
}

@end
