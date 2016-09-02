//
//  WebViewController.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/2/17.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    var url: NSURL!
    var displayTitle: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: url))
        indicatorView.startAnimating()
        
        title = displayTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension WebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        indicatorView.stopAnimating()
        indicatorView.hidden = true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        indicatorView.stopAnimating()
    }
}
