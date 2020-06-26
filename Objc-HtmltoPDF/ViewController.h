//
//  ViewController.h
//  Objc-HtmltoPDF
//
//  Created by Luke Inger on 24/06/2020.
//  Copyright © 2020 Luke Inger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet WKWebView *webView;

@end

