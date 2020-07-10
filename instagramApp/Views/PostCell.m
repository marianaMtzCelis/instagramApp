//
//  PostCell.m
//  instagramApp
//
//  Created by Mariana Martinez on 08/07/20.
//  Copyright © 2020 Mariana Martinez. All rights reserved.
//

#import "PostCell.h"
#import <Parse/Parse.h>

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData {
    
    NSNumber *number = self.post.likeCount;
    int value = [number intValue];
    [self.likeButton setTitle:[NSString stringWithFormat:@"%i", value] forState:UIControlStateNormal];
    
}

- (IBAction)onLike:(id)sender {
    
    NSNumber *number = self.post.likeCount;
    int value = [number intValue];
    number = [NSNumber numberWithInt:value + 1];
    self.post.likeCount = number;
    
    // TODO: Make red boton work
   // [self.likeButton setImage:[UIImage imageNamed:@"heart.fill"] forState:UIControlStateNormal];
    
    // TODO: send update to parse
    
    [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"updated post");
        } else {
            NSLog(@"Error updating post");
        }
    }];
    
    [self refreshData];
}


@end
