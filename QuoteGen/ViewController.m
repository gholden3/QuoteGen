//
//  ViewController.m
//  QuoteGen
//
//  Created by Gina M Holden on 12/27/15.
//  Copyright (c) 2015 Gina Holden. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.myQuotes = @[
                      @"Live and let live",
                      @"Don't cry over spilt milk",
                      @"Always look on the bright side of life",
                      @"Nobody's perfect",
                      @"Can't see the woods for the trees",
                      @"Better to have loved and lost then not loved at all",
                      @"The early bird catches the worm",
                      @"As slow as a wet week"
                      ];
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [NSMutableArray arrayWithContentsOfFile:plistCatPath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)quoteButtonTapped:(id)sender{
    if (self.quoteOpt.selectedSegmentIndex == 2) {
        // 1.1 - Get array count
        int array_tot = [self.myQuotes count];
        // 1.2 - Initialize string for concatenated quotes
        NSString *all_my_quotes = @"";
        NSString *my_quote = nil;
        // 1.3 - Iterate through array
        for (int x=0; x < array_tot; x++) {
            my_quote = self.myQuotes[x];
            all_my_quotes = [NSString stringWithFormat:@"%@\n%@\n",  all_my_quotes,my_quote];
        }
        self.quoteText.text = [NSString stringWithFormat:@"%@", all_my_quotes];
    }
    else{
        NSString *selectedCategory = @"classic";
        if(self.quoteOpt.selectedSegmentIndex==1){
            selectedCategory = @"modern";
        }
        //filter array by category using predicates
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category = %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        int array_tot = [filteredArray count];
        if (array_tot > 0) {
            // 2.5 - get random index
            int index = (arc4random() % array_tot);
            // 2.6 - get the quote string for the index
            NSString *quote = filteredArray[index][@"quote"];
            NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
            if (![source length] == 0) {
                if ([selectedCategory isEqualToString:@"classic"]) {
                    quote = [NSString stringWithFormat:@"From Classic Movie\n\n%@",  quote];
                } else {
                    quote = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
                }
                if ([source hasPrefix:@"Harry"]) {
                    quote = [NSString stringWithFormat:@"HARRY ROCKS!!\n\n%@",  quote];
                }
                self.quoteText.text = quote;
                // 2.10 - Update row to indicate that it has been displayed
                int movie_array_tot = [self.movieQuotes count];
                NSString *quote1 = filteredArray[index][@"quote"];
                for (int x=0; x < movie_array_tot; x++) {
                    NSString *quote2 = self.movieQuotes[x][@"quote"];
                    if ([quote1 isEqualToString:quote2]) {
                        NSMutableDictionary *itemAtIndex = (NSMutableDictionary *)self.movieQuotes[x];
                        itemAtIndex[@"source"] = @"DONE";
                    }
                }
            }
            //self.quoteText.text = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
        } else {
            self.quoteText.text = [NSString stringWithFormat:@"No quotes to display."];
        }
    }
}

@end
