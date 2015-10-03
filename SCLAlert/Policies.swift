//
//  Policies.swift
//  SCLAlert
//
//  Created by Barak M on 8/4/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

class Policies: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        let url = NSURL(string: "https://www.pace.edu/sexual-assault")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        self.view.bringSubviewToFront(activityIndicator)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        //activityIndicator.startAnimating()
        print(activityIndicator.hidden)
        print(activityIndicator.frame.origin)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        //activityIndicator.stopAnimating()
        print(activityIndicator.hidden)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
