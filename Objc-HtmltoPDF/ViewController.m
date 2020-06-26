//
//  ViewController.m
//  Objc-HtmltoPDF
//
//  Created by Luke Inger on 24/06/2020.
//  Copyright © 2020 Luke Inger. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController{
    NSString *_htmlContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(generatePDF)];

    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Demo" withExtension:@"html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    _htmlContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
}

-(void)generatePDF{
    
    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
    [render addPrintFormatter:self.webView.viewPrintFormatter startingAtPageAtIndex:0];
    
    CGRect page = CGRectMake(0, 0, 580, 800);
    CGRect printable = UIEdgeInsetsInsetRect(page, UIEdgeInsetsMake(0, 0, 0, 0));
    
    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
    [render setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
    
    NSMutableData *pdfData = [[NSMutableData alloc] init];
    UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil);
    
    for (NSInteger i=0; i<render.numberOfPages; i++){
        
        UIGraphicsBeginPDFPage();
        CGRect bounds = UIGraphicsGetPDFContextBounds();
        [render drawPageAtIndex:0 inRect:bounds];
        
    }
    
    UIGraphicsEndPDFContext();
    
    [self.webView loadData:pdfData MIMEType:@"application/pdf" characterEncodingName:@"utf-8" baseURL:[NSURL URLWithString:@""]];
    
    NSMutableString *path = [[NSMutableString alloc] initWithString:NSTemporaryDirectory()];
    [path appendString:@"test.pdf"];
    [pdfData writeToFile:path atomically:YES];

}


@end
