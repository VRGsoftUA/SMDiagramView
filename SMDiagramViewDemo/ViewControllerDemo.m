//
//  ViewController.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/24/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "ViewControllerDemo.h"
#import "SMDiagramView-Swift.h"
//#import "SMDiagramView.h"
#import "Utils.h"

@interface ViewControllerDemo () <SMDiagramViewDataSource>
{
    CGFloat viewForSegmentWidth;
}
@property (weak, nonatomic) IBOutlet SMDiagramView *diagramView;
@property (weak, nonatomic) IBOutlet UIStepper *numberOfSegmentsStepper;
@property (weak, nonatomic) IBOutlet UILabel *numberOfSegmentsLabel;
@property (weak, nonatomic) IBOutlet UISlider *radiusForSegmentSlider;
@property (weak, nonatomic) IBOutlet UISlider *radiusForViewSlider;
@property (weak, nonatomic) IBOutlet UISlider *startAngleSlider;
@property (weak, nonatomic) IBOutlet UISlider *endAngleSlider;
@property (weak, nonatomic) IBOutlet UISlider *arcWidthSlider;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;

@end

@implementation ViewControllerDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    viewForSegmentWidth = 30.f;
    
    self.diagramView.dataSource = self;
    
    self.diagramView.emptyView = [self emptyView];
    self.diagramView.backgroundColor = [UIColor clearColor];
    
    [self reset];
}

- (void)reloadData
{
    self.diagramView.endAngle = self.startAngleSlider.maximumValue = self.endAngleSlider.value;
    self.diagramView.startAngle = self.endAngleSlider.minimumValue = self.startAngleSlider.value;
    
    self.arcWidthSlider.enabled = self.modeSwitch.isOn;
    
    self.diagramView.diagramViewMode = self.modeSwitch.isOn ? SMDiagramViewModeArc : SMDiagramViewModeSegment;
    
    self.numberOfSegmentsLabel.text = [NSString stringWithFormat:@"Number of segments: %@", @(self.numberOfSegmentsStepper.value)];
    
    [self.diagramView reloadData];
}


#pragma mark - SMDiagramViewDataSource

- (NSInteger)numberOfSegmentsInDiagramView:(nonnull SMDiagramView *)diagramView
{
    return self.numberOfSegmentsStepper.value;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForSegmentAtIndex:(NSInteger)index proportion:(CGFloat)proportion angle:(CGFloat)angle
{
    return self.radiusForSegmentSlider.value;
}

- (UIColor *)diagramView:(SMDiagramView *)diagramView colorForSegmentAtIndex:(NSInteger)index angle:(CGFloat)angle
{
    return [Utils colorForIndex:index];
}

- (UIView *)diagramView:(SMDiagramView *)diagramView viewForSegmentAtIndex:(NSInteger)index colorOfSegment:(UIColor *)colorOfSegment angle:(CGFloat)angle
{
    return [self viewForSegmentAtIndex:index];
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForView:(UIView *)view atIndex:(NSInteger)index radiusOfSegment:(CGFloat)aRadiusOfSegment angle:(CGFloat)angle
{
    return self.radiusForViewSlider.value;
}

- (CGFloat)diagramView:(SMDiagramView *)diagramView lineWidthForSegmentAtIndex:(NSInteger)index angle:(CGFloat)angle
{
    return self.arcWidthSlider.value;
}


#pragma mark - Actions

- (IBAction)valueChanged
{
    [self reloadData];
}

- (IBAction)reset
{
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    self.numberOfSegmentsStepper.minimumValue = 0;
    self.numberOfSegmentsStepper.maximumValue = maxSegmentsCount;
    self.numberOfSegmentsStepper.value = 6;
    
    self.radiusForSegmentSlider.minimumValue = screenWidth/10.f;
    self.radiusForSegmentSlider.maximumValue = screenWidth/4.f;
    self.radiusForSegmentSlider.value = screenWidth/6.f;
    
    self.startAngleSlider.minimumValue = self.endAngleSlider.minimumValue = -M_PI_2;
    self.startAngleSlider.maximumValue = self.endAngleSlider.maximumValue = self.startAngleSlider.minimumValue + 2.f*M_PI;
    self.startAngleSlider.value = self.startAngleSlider.minimumValue;
    self.endAngleSlider.value = self.endAngleSlider.maximumValue;
    
    self.radiusForViewSlider.minimumValue = self.radiusForSegmentSlider.minimumValue;
    self.radiusForViewSlider.maximumValue = self.radiusForSegmentSlider.maximumValue + viewForSegmentWidth;
    self.radiusForViewSlider.value = self.radiusForSegmentSlider.value + viewForSegmentWidth;
    
    self.modeSwitch.on = YES;
    
    self.arcWidthSlider.minimumValue = 0;
    self.arcWidthSlider.maximumValue = screenWidth/6.f;
    self.arcWidthSlider.value = 6;
    
    [self reloadData];
}


#pragma mark - Utils

- (UIView *)emptyView
{
    UILabel *emptyView = [[UILabel alloc] initWithFrame:self.diagramView.bounds];
    emptyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    emptyView.textAlignment = NSTextAlignmentCenter;
    emptyView.numberOfLines = 0;
    emptyView.text = @"This Is\nEmpty\nView";
    return emptyView;
}

- (UIView *)viewForSegmentAtIndex:(NSInteger)index
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewForSegmentWidth, viewForSegmentWidth)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.clipsToBounds = YES;
    label.text = @(index+1).stringValue;
    label.layer.cornerRadius = viewForSegmentWidth/2;
    label.backgroundColor = [Utils colorForIndex:index];
    return label;
}

@end
