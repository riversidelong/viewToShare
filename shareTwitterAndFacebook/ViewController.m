//
//  ViewController.m
//  shareTwitterAndFacebook
//
//  Created by 川端伸彦 on 2014/06/16.
//  Copyright (c) 2014年 mikke. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *viewToShare;
@property NSURLRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *textURL;


@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated
{
    //----
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _textURL.delegate = self;
    _viewToShare.delegate = self;
   
    
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.co.jp/"]];
    
  
    [_viewToShare loadRequest:req];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textURL resignFirstResponder];
    NSString *strUrl;
    if( [textField.text hasPrefix:@"http://" ])
    {
        strUrl = textField.text;
    }
    else
    {
        strUrl = @"http://";
        strUrl = [strUrl stringByAppendingString:textField.text];
    }
    NSURL *url = [[NSURL alloc]initWithString:strUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_viewToShare loadRequest:urlRequest];
    return YES;
}
//webをメモリ解放
- (void)dealloc
{
    _viewToShare.delegate = nil;
    
}

- (IBAction)twitterShare:(id)sender {
    NSString *abcD;
    abcD = SLServiceTypeTwitter;
    SLComposeViewController *contorller = [SLComposeViewController composeViewControllerForServiceType:abcD];
   
    //今見ているURLを投稿コメントに追加したい

    NSString* url = [_viewToShare stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSString* title = [_viewToShare stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@", url);
    NSLog(@"%@", title);
    //-------------------------------------------------

    [contorller setInitialText:title];
    [contorller addURL:[NSURL URLWithString:url]];
    //-------------------------------------------------------------
    [self presentViewController:contorller animated:YES completion:nil];
}
- (IBAction)facebookShare:(id)sender {
    NSString *facebookShare;
    facebookShare = SLServiceTypeFacebook;
    SLComposeViewController *contorller = [SLComposeViewController composeViewControllerForServiceType:facebookShare];
    NSString *url = [_viewToShare stringByEvaluatingJavaScriptFromString:@"document.URL"];
    NSString *title = [_viewToShare stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    //-----------------------------------------------------------
    [contorller setInitialText:title];
    [contorller addURL:[NSURL URLWithString:url]];
    //----------------------------------------------------------
    [self presentViewController:contorller animated:YES completion:nil];
    

}

- (IBAction)goBackButton:(id)sender {
    if( _viewToShare.canGoBack )
    {
        [_viewToShare goBack];
    }
    
}



- (IBAction)goForwardButton:(id)sender {
    if( _viewToShare.canGoForward )
    {
        [_viewToShare goForward];
    }
}

@end
