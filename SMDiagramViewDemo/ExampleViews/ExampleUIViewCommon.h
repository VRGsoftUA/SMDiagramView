//
//  ExampleUIViewCommon.h
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 11/30/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "SMDiagramView-Swift.h"
//#import "SMDiagramView.h"

@protocol SMDiagramViewDataSource;

@interface ExampleUIViewCommon : UIView <SMDiagramViewDataSource>
{
    SMDiagramView *diagramView;
    CGFloat width;
}

- (void)setup;
- (UIView *)viewForSegmentAtIndex:(NSInteger)index;
- (UIView *)titleView;

@end
