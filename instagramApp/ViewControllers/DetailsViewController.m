//
//  DetailsViewController.m
//  instagramApp
//
//  Created by Mariana Martinez on 08/07/20.
//  Copyright © 2020 Mariana Martinez. All rights reserved.
//

#import "DetailsViewController.h"
#import <Parse/Parse.h>
#import "PFImageView.h"
#import "DateTools.h"
#import "NSDate+TimeAgo.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *postImageView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
    NSDate *createdAt = [self.post createdAt];
    NSString *ago = [createdAt timeAgo];
    NSString *createdAtString = ago;
    self.timestampLabel.text = createdAtString;
    
    [self refreshData];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
