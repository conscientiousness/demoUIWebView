//
//  ViewController.m
//  HelloMyBrowser
//
//  Created by Jesselin on 2015/6/5.
//  Copyright (c) 2015年 Jesse. All rights reserved.
//

#import "ViewController.h"

//<UITextFieldDelegate> 為 protocal 代表一種溝通方式
//裡面是很多method的集合，但未實做 -- apple定義的

@interface ViewController () <UITextFieldDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
//@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadindView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //在view執行時就觸發goButtonPress
    [self goButtonPress:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)goButtonPress:(id)sender {
    NSString *urlString = _urlTextField.text;
    //轉換為NSURL格式:有可能的格式為http,https,file,telnet,mailto...
    NSURL *url = [NSURL URLWithString:urlString];
    //把url丟給request : HTTPGet的動作
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

//- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
//    _urlTextField.text = @"aaaaaa";
//    
//    return NO;
//}

#pragma mark - UITextFieldDelegate Method

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    //關閉鍵盤
    [textField resignFirstResponder];
    
    [self goButtonPress:nil];
    
    return NO;
}

#pragma mark - UIWebViewDelegate Methods

//是否允許跳到其他網址
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlString = [request.URL absoluteString];
    
    NSLog(@"URL String: %@",urlString);
    
    return YES;
}

//回報資訊給viewControler
- (void) webViewDidStartLoad:(UIWebView *)webView {
    [_loadindView startAnimating];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    [_loadindView stopAnimating];
    
}

- (void) webview:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [_loadindView stopAnimating];
}

@end
