//
//  SMDiagramView.h
//  Bittiq
//
//  Created by OLEKSANDR SEMENIUK on 9/22/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger
{
    SMDiagramViewModeArc,
    SMDiagramViewModeSegment
} SMDiagramViewMode;

@protocol SMDiagramViewDataSource;

@interface SMDiagramView : UIView

@property (nonatomic, weak) id<SMDiagramViewDataSource> dataSource;
@property (nonatomic, strong, nullable) UIView *emptyView;
@property (nonatomic, strong, nullable) UIView *titleView;
@property (nonatomic, assign) CGFloat minProportion; //default 0.1f
@property (nonatomic, assign) SMDiagramViewMode diagramViewMode; //default SMDiagramViewModeArc
@property (nonatomic, assign) CGPoint diagramOffset; //dafault CGPointZero
@property (nonatomic, assign) CGFloat radiusOfSegments; //default 80.f
@property (nonatomic, assign) CGFloat radiusOfViews; //default 130.f
@property (nonatomic, assign) CGFloat arcWidth; //default 6.f. Ignoring for SMDiagramViewModeSegment
@property (nonatomic, assign) CGFloat startAngle;  //dafault -pi/2.f
@property (nonatomic, assign) CGFloat endAngle; //dafault 2.f*pi - pi/2.f
@property (nonatomic, strong) UIColor *colorOfSegments; //dafault blackColor
@property (nonatomic, assign) CGPoint viewsOffset;  //dafault CGPointZero
@property (nonatomic, assign) CGFloat separatorWidh; //default 1.f
@property (nonatomic, strong) UIColor *separatorColor; //default self.backgroundColor

- (void)reloadData;

@end


@protocol SMDiagramViewDataSource <NSObject>

@required
- (NSInteger)numberOfSegmentsInDiagramView:(SMDiagramView *)diagramView;

@optional
- (CGFloat)diagramView:(SMDiagramView *)diagramView proportionForSegmentAtIndex:(NSInteger)index;
- (nullable UIColor *)diagramView:(SMDiagramView *)diagramView colorForSegmentAtIndex:(NSInteger)index angle:(CGFloat)angle;
- (nullable UIView *)diagramView:(SMDiagramView *)diagramView viewForSegmentAtIndex:(NSInteger)index colorOfSegment:(nullable UIColor *)colorOfSegment angle:(CGFloat)angle;
- (CGPoint)diagramView:(SMDiagramView *)diagramView offsetForView:(nullable UIView *)view atIndex:(NSInteger)index angle:(CGFloat)angle;
- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForSegmentAtIndex:(NSInteger)index proportion:(CGFloat)proportion angle:(CGFloat)angle;
- (CGFloat)diagramView:(SMDiagramView *)diagramView radiusForView:(nullable UIView *)view atIndex:(NSInteger)index radiusOfSegment:(CGFloat)radiusOfSegment angle:(CGFloat)angle;
- (CGFloat)diagramView:(SMDiagramView *)diagramView lineWidthForSegmentAtIndex:(NSInteger)index angle:(CGFloat)angle; //not called for SMDiagramViewModeSegment

@end

NS_ASSUME_NONNULL_END

