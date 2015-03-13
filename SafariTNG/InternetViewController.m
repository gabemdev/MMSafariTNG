//
//  InternetViewController.m
//  SafariTNG
//
//  Created by Rockstar. on 3/11/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "InternetViewController.h"
#define HOME @"www.mobilemakers.co"


@interface InternetViewController ()<UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation InternetViewController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self goToString:[NSString stringWithFormat:@"%@", HOME]];
    _webView.delegate = self;
    
}

#pragma mark - UIWebView
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Loading failed."
                                                    message:error.localizedDescription
                                                   delegate:self
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles:@"Go Home", nil];
    [alert show];
    [_activityIndicator stopAnimating];
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self goToString:HOME];
    }
}

#pragma mark - UITextField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToString:textField.text];
    [textField setText:nil];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Helper Methods
- (void)goToString:(NSString *)string {
    NSString *urlString = [NSString stringWithFormat:@"http://%@", string];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

@end
