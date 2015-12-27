//
//  ViewController.h
//  QuoteGen
//
//  Created by Gina M Holden on 12/27/15.
//  Copyright (c) 2015 Gina Holden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) NSArray* myQuotes;
@property (nonatomic, strong) NSMutableArray* movieQuotes;
@property (nonatomic, strong) IBOutlet UITextView *quoteText;
- (IBAction)quoteButtonTapped:(id)sender;
@property (nonatomic,strong) IBOutlet UISegmentedControl *quoteOpt;

@end
