//
//  DBGEncodeExampleViewController.m
//  DBGHTMLEntitiesExample
//
//  Created by David Grandinetti on 4/15/14.
//  Copyright (c) 2014 David Grandinetti. All rights reserved.
//

#import "DBGEncodeExampleViewController.h"
#import "DBGHTMLEntityEncoder.h"
#import "DBGLabelHelpers.h"

#import <ORStackView/ORStackScrollView.h>

@implementation DBGEncodeExampleViewController

- (void)loadView {
    ORStackScrollView *stackScrollView = [[ORStackScrollView alloc] init];
    stackScrollView.backgroundColor = [UIColor whiteColor];
    self.view = stackScrollView;
    
    ORStackView *stackView = stackScrollView.stackView;
    
    DBGHTMLEntityEncoder *encoder = [[DBGHTMLEntityEncoder alloc] init];
    
    UILabel *titleLabel = [DBGLabelHelpers titleLabel:@"Encoder Examples"];
    [stackView addSubview:titleLabel withPrecedingMargin:40 sideMargin:20];

    //
    // examples of the default encoding (named > decimal)
    //
    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Our example string..."]
      withPrecedingMargin:50
               sideMargin:20];
    
    [stackView addSubview:[DBGLabelHelpers basicLabel:[self basicString]]
      withPrecedingMargin:10
               sideMargin:20];

    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Encoded with default settings..."]
      withPrecedingMargin:50
               sideMargin:20];

    NSString *defaultEncode = [encoder encode:[self basicString]];
    [stackView addSubview:[DBGLabelHelpers basicLabel:defaultEncode]
      withPrecedingMargin:10
               sideMargin:20];

    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Encoded with decimal only..."]
      withPrecedingMargin:50
               sideMargin:20];

    NSString *decimalEncode = [encoder encode:[self basicString] withFormats:(DBGHTMLEntityEncoderDecimalFormat)];
    [stackView addSubview:[DBGLabelHelpers basicLabel:decimalEncode]
      withPrecedingMargin:10
               sideMargin:20];

    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Encoded with named preference over hex..."]
      withPrecedingMargin:50
               sideMargin:20];

    NSString *hexPreferenceEncode = [encoder encode:[self basicString] withFormats:(DBGHTMLEntityEncoderNamedFormat|DBGHTMLEntityEncoderHexFormat)];
    [stackView addSubview:[DBGLabelHelpers basicLabel:hexPreferenceEncode]
      withPrecedingMargin:10
               sideMargin:20];

    //
    // examples of default encoding with NSAttributedString, one regular, one decoded
    //
    [stackView addSubview:[DBGLabelHelpers explainLabel:@"Default encoding with an NSMutableAttributedString"]
      withPrecedingMargin:50
               sideMargin:20];
    
    [stackView addSubview:[DBGLabelHelpers attributedLabel:[self tweetString]]
      withPrecedingMargin:10
               sideMargin:20];
    
    NSMutableAttributedString *tweetString = [self tweetString];
    NSMutableString *mutableTweetString = tweetString.mutableString;
    [encoder encodeStringInPlace:mutableTweetString];
    
    [stackView addSubview:[DBGLabelHelpers attributedLabel:tweetString]
      withPrecedingMargin:10
               sideMargin:20];
    
    // footer spacer
    [stackView addSubview:[[UIView alloc] init] withPrecedingMargin:40];
}

#pragma mark - String generators

- (NSString *)basicString {
    return @"Today & tomorrow only, we've got extra pies to give out. Not to be confused with π #betterthandonuts, cc/ @dbgrandi ☺";
}

- (NSMutableAttributedString *)tweetString {
    UIFont *labelFont = [UIFont fontWithName:@"AvenirNext-Regular" size:22];
    NSDictionary *attributes = @{NSFontAttributeName:labelFont};
    
    NSString *basicString = [self basicString];
    
    NSMutableAttributedString *attributedTweetString = [[NSMutableAttributedString alloc] initWithString:basicString attributes:attributes];

    NSRange underlineRange = [basicString rangeOfString:@"Today & tomorrow only"];
    [attributedTweetString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:underlineRange];

    NSRange hashtagRange = [basicString rangeOfString:@"#betterthandonuts"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:hashtagRange];
    
    NSRange mentionRange = [basicString rangeOfString:@"@dbgrandi"];
    [attributedTweetString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:mentionRange];
    
    return attributedTweetString;
}

@end
