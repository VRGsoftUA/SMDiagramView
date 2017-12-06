//
//  SMDiagramView.m
//  Bittiq
//
//  Created by OLEKSANDR SEMENIUK on 9/22/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "SMDiagramView.h"

@interface SMDiagramViewModel: NSObject

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat angleStep;
@property (nonatomic, assign) CGFloat calculatedProportion;
@property (nonatomic, assign) CGFloat originalProportion;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat radiusOfSegment;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat radiusOfView;
@property (nonatomic, assign) CGPoint viewOffset;
@property (nonatomic, assign) CGFloat separatorWidh;
@property (nonatomic, assign) SMDiagramViewMode diagramViewMode;

@property (nonatomic, readonly) CGFloat endAngle;
@property (nonatomic, readonly) CGFloat angle;
@property (nonatomic, readonly) CGPoint viewPosition;
@property (nonatomic, readonly) CGFloat separatorStartAngle;
@property (nonatomic, readonly) CGFloat separatorEndAngle;
@property (nonatomic, readonly) CGFloat separatorLineWidth;

@end


@implementation SMDiagramViewModel

- (CGFloat)radiusOfSegment
{
    CGFloat result = 0.f;
    
    switch (self.diagramViewMode)
    {
        case SMDiagramViewModeArc:
            result = _radiusOfSegment;
            break;
        case SMDiagramViewModeSegment:
            result = _radiusOfSegment/2.f;
            break;
        default:
            break;
    }
    
    return result;
}

- (CGFloat)lineWidth
{
    CGFloat result = 0.f;
    
    switch (self.diagramViewMode)
    {
        case SMDiagramViewModeArc:
            result = _lineWidth;
            break;
        case SMDiagramViewModeSegment:
            result = _radiusOfSegment;
            break;
        default:
            break;
    }
    
    return result;
}

- (CGFloat)endAngle
{
    CGFloat result = 0.f;
    
    result = self.startAngle + self.angleStep;
    
    return result;
}

- (CGFloat)angle
{
    CGFloat result = 0.f;
    
    result = self.endAngle - self.angleStep/2.f;
    
    return result;
}

- (CGPoint)viewPosition
{
    CGPoint result = CGPointZero;
    
    result = CGPointMake([self xPosition], [self yPosition]);
    
    return result;
}

- (CGFloat)xPosition
{
    CGFloat result = 0.f;
    
    result = cosf(self.endAngle - self.angleStep/2.f) * self.radiusOfView + self.viewOffset.x;
    
    return result;
}

- (CGFloat)yPosition
{
    CGFloat result = 0.f;
    
    result = sinf(self.endAngle - self.angleStep/2.f) * self.radiusOfView + self.viewOffset.y;
    
    return result;
}

- (CGFloat)separatorStartAngle
{
    CGFloat result = 0.f;
    
    result = self.endAngle - self.separatorAngleStep/2;
    
    return result;
}

- (CGFloat)separatorEndAngle
{
    CGFloat result = 0.f;
    
    result = self.endAngle + self.separatorAngleStep/2;
    
    return result;
}

- (CGFloat)separatorAngleStep
{
    CGFloat result = 0.f;
    
    result = self.separatorWidh/self.radiusOfSegment;
    
    return result;
}

- (CGFloat)separatorLineWidth
{
    CGFloat result = 0.f;
    
    result = self.lineWidth + 2.0f / [[UIScreen mainScreen] scale];
    
    return result;
}

@end



@interface SMDiagramView ()
{
    NSArray<SMDiagramViewModel *> *models;
}

@property (nonatomic, readonly) CGPoint centerOfCircle;

@end


@implementation SMDiagramView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.diagramOffset = CGPointZero;
    self.startAngle = -M_PI_2;
    self.endAngle = self.startAngle + 2.f*M_PI;
    self.radiusOfSegments = 80.f;
    self.radiusOfViews = 130.f;
    self.arcWidth = 6.f;
    self.colorOfSegments = [UIColor blackColor];
    self.viewsOffset = CGPointZero;
    self.diagramViewMode = SMDiagramViewModeArc;
    self.separatorWidh = 1.f;
    self.separatorColor = self.backgroundColor;
    self.minProportion = 0.1f;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self drawDiagram];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateViewsPositions];
}

- (CGPoint)centerOfCircle
{
    CGPoint result = CGPointZero;
    
    result = CGPointMake(self.frame.size.width/2.f + self.diagramOffset.x, self.frame.size.height/2.f + self.diagramOffset.y);
    
    return result;
}

- (void)drawDiagram
{
    for (NSInteger i = 0; i < models.count; i++)
    {
        SMDiagramViewModel *model = models[i];
        
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextAddArc(c, self.centerOfCircle.x, self.centerOfCircle.y, model.radiusOfSegment, model.startAngle, model.endAngle, NO);
        CGContextSetLineWidth(c, model.lineWidth);
        CGContextSetStrokeColorWithColor(c, model.color.CGColor);
        CGContextDrawPath(c, kCGPathStroke);
    }
    
    if (self.diagramViewMode == SMDiagramViewModeArc)
    {
        [self drawSeparator];
    }
}

- (void)drawSeparator
{
    if (models.count < 2)
    {
        return;
    }
    
    for (SMDiagramViewModel *model in models)
    {
        CGContextRef c = UIGraphicsGetCurrentContext();
        CGContextAddArc(c, self.centerOfCircle.x, self.centerOfCircle.y, model.radiusOfSegment, model.separatorStartAngle, model.separatorEndAngle, NO);
        CGContextSetLineWidth(c, model.separatorLineWidth);
        CGContextSetStrokeColorWithColor(c, self.separatorColor.CGColor);
        CGContextDrawPath(c, kCGPathStroke);
    }
}

- (void)removeViews
{
    for (SMDiagramViewModel *model in models)
    {
        if (model.view)
        {
            [model.view removeFromSuperview];
        }
    }
    
    [self hideEmptyView];
}

- (void)updateViewsPositions
{
    for (SMDiagramViewModel *model in models)
    {
        if (model.view)
        {
            model.view.center = CGPointMake(self.centerOfCircle.x + model.viewPosition.x, self.centerOfCircle.y + model.viewPosition.y);
        }
    }
    
    self.titleView.center = self.centerOfCircle;
}

- (void)setTitleView:(UIView *)titleView
{
    [self.titleView removeFromSuperview];
    
    _titleView = titleView;
    
    [self addSubview:titleView];
    [self layoutIfNeeded];
}

- (void)setEmptyView:(UIView *)emptyView
{
    [self.emptyView removeFromSuperview];
    
    _emptyView = emptyView;
    
    [self addSubview:emptyView];
    [self hideEmptyView];
}

- (void)updateProportions
{
    CGFloat additionalSum = 0.f;
    CGFloat lessSum = 0.f;
    CGFloat sum = 0.f;
    
    for (SMDiagramViewModel *model in models)
    {
        sum += model.calculatedProportion;
        
        if (model.calculatedProportion < self.minProportion)
        {
            lessSum += model.calculatedProportion;
            additionalSum += self.minProportion - model.calculatedProportion;
            model.calculatedProportion = self.minProportion;
        }
    }
    
    if (additionalSum == 0.f)
    {
        return;
    }
    
    CGFloat greatSum = sum - lessSum;
    for (SMDiagramViewModel *model in models)
    {
        if (model.calculatedProportion > self.minProportion)
        {
            model.calculatedProportion -= (model.calculatedProportion/greatSum) * additionalSum;
        }
    }
    
    [self updateProportions];
}

- (void)reloadData
{
    [self removeViews];
    
    models = [NSArray array];
    
    NSInteger count = [self.dataSource numberOfSegmentsInDiagramView:self];
    
    if (self.endAngle > self.startAngle)
    {
        if (count)
        {
            CGFloat originalProportion = 1.f/count;
            
            NSAssert(roundf(originalProportion*100)/100 >= self.minProportion, @"SMDiagramView. 1.f/count should not be less minProportion\ncount = %@\nminProportion = %2f", @(count), self.minProportion);
            
            NSMutableArray<SMDiagramViewModel *> *result = [NSMutableArray new];
            
            CGFloat totalProportion = 0.f;
            for (NSInteger i = 0; i < count; i++)
            {
                SMDiagramViewModel *model = [SMDiagramViewModel new];
                
                model.originalProportion = originalProportion;
                
                if ([self.dataSource respondsToSelector:@selector(diagramView:proportionForSegmentAtIndex:)])
                {
                    model.originalProportion = [self.dataSource diagramView:self proportionForSegmentAtIndex:i];
                }
                
                totalProportion += model.originalProportion;
                
                NSAssert(roundf(totalProportion * 100)/100 <= 1.f && totalProportion >= 0.00f, @"SMDiagramView. Sum of proportions = %2f must be less or equal 1.00f or equal 0.00f", totalProportion);
                
                model.calculatedProportion = model.originalProportion;
                
                [result addObject:model];
            }
            
            models = [NSArray arrayWithArray:result];
            
            [self updateProportions];
            
            CGFloat startAngle = self.startAngle;
            
            for (NSInteger i = 0; i < count; i++)
            {
                SMDiagramViewModel * model = models[i];
                
                model.startAngle = startAngle;
                model.angleStep = (self.endAngle - self.startAngle)*model.calculatedProportion;
                
                model.color = self.colorOfSegments;
                if ([self.dataSource respondsToSelector:@selector(diagramView:colorForSegmentAtIndex:angle:)])
                {
                    UIColor *color = [self.dataSource diagramView:self colorForSegmentAtIndex:i angle:model.angle];
                    if (color)
                    {
                        model.color = color;
                    }
                }
                
                model.view = nil;
                if ([self.dataSource respondsToSelector:@selector(diagramView:viewForSegmentAtIndex:colorOfSegment:angle:)])
                {
                    model.view = [self.dataSource diagramView:self viewForSegmentAtIndex:i colorOfSegment:model.color angle:model.angle];
                    if (model.view)
                    {
                        [self addSubview:model.view];
                    }
                }
                
                model.radiusOfSegment = self.radiusOfSegments;
                if ([self.dataSource respondsToSelector:@selector(diagramView:radiusForSegmentAtIndex:proportion:angle:)])
                {
                    model.radiusOfSegment = [self.dataSource diagramView:self radiusForSegmentAtIndex:i proportion:model.calculatedProportion angle:model.angle];
                }
                
                model.radiusOfView = self.radiusOfViews;
                if ([self.dataSource respondsToSelector:@selector(diagramView:radiusForView:atIndex:radiusOfSegment:angle:)])
                {
                    model.radiusOfView = [self.dataSource diagramView:self radiusForView:model.view atIndex:i radiusOfSegment:model.radiusOfSegment angle:model.angle];
                }
                
                model.viewOffset = self.viewsOffset;
                if ([self.dataSource respondsToSelector:@selector(diagramView:offsetForView:atIndex:angle:)])
                {
                    model.viewOffset = [self.dataSource diagramView:self offsetForView:model.view atIndex:i angle:model.angle];
                }
                
                model.lineWidth = self.arcWidth;
                if (self.diagramViewMode == SMDiagramViewModeArc && [self.dataSource respondsToSelector:@selector(diagramView:lineWidthForSegmentAtIndex:angle:)])
                {
                    model.lineWidth = [self.dataSource diagramView:self lineWidthForSegmentAtIndex:i angle:model.angle];
                }
                
                model.separatorWidh = self.separatorWidh;
                model.diagramViewMode = self.diagramViewMode;
                startAngle = model.endAngle;
            }
            
        } else
        {
            [self showEmptyView];
        }
    }
    
    [self layoutIfNeeded];
    [self setNeedsDisplay];
}

- (void)showEmptyView
{
    [self bringSubviewToFront:self.emptyView];
    self.emptyView.alpha = 1;
    self.emptyView.hidden = NO;
}

- (void)hideEmptyView
{
    self.emptyView.alpha = 0;
    self.emptyView.hidden = YES;
}

@end

