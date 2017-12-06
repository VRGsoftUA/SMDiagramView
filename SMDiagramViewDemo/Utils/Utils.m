//
//  Utils.m
//  SMDiagramView
//
//  Created by OLEKSANDR SEMENIUK on 12/1/17.
//  Copyright © 2017 OLEKSANDR SEMENIUK. All rights reserved.
//

#import "Utils.h"

typedef struct _Color {
    CGFloat red, green, blue;
} Color;

static Color _colors[maxSegmentsCount] = {
    {87, 140, 169}, {246, 209, 85}, {0, 75, 141}, {242, 85, 44}, {149, 222, 227}, {237, 205, 194}, {206, 49, 117}, {90, 114, 71}, {207, 176, 149}, {220, 76, 70}
};

@implementation Utils

+ (UIColor *)colorForIndex:(NSInteger)index {
    Color color = _colors[index];
    return [UIColor colorWithRed:(color.red / 255.0f) green:(color.green / 255.0f) blue:(color.blue / 255.0f) alpha:1.0f];
}

@end
