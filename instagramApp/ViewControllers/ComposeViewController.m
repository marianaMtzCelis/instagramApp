//
//  ComposeViewController.m
//  instagramApp
//
//  Created by Mariana Martinez on 07/07/20.
//  Copyright © 2020 Mariana Martinez. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;

@property (weak, nonatomic) IBOutlet UITextView *captionTextView;

@property (strong, nonatomic) Post *post;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onShare:(id)sender {
    
    [Post postUserImage:self.pictureView.image withCaption:self.captionTextView.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Post success");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSLog(@"Post failed");
        }
    }];
    
    
}

- (IBAction)onCamera:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
      imagePickerVC.delegate = self;
      imagePickerVC.allowsEditing = YES;
      imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;

      [self presentViewController:imagePickerVC animated:YES completion:nil];
      
      if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
          imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
      }
      else {
          NSLog(@"Camera 🚫 available so we will use photo library instead");
          imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      } 
    
}

- (IBAction)onLibrary:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    
}

/*
 - (IBAction)takePicture:(id)sender {     UIImagePickerController *imagePickerVC = [UIImagePickerController new];     imagePickerVC.delegate = self;     imagePickerVC.allowsEditing = YES;          if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {         imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;     }     else {         NSLog(@"Camera 🚫 available so we will use photo library instead");         imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;     }          [self presentViewController:imagePickerVC animated:YES completion:nil]; }
 
 */


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    [self.pictureView setImage:editedImage];
    self.pictureView.image = [self resizeImage:editedImage withSize:CGSizeMake(150, 150)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
