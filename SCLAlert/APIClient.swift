//
//  APIClient.swift
//  SCLAlert
//
//  Created by Barak M on 6/12/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

func parseJSON(data:NSData, error:NSErrorPointer = nil) -> AnyObject! {
    return NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: error)
}

func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
    var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
    if NSJSONSerialization.isValidJSONObject(value) {
        if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
            if let string = NSString(data: data, encoding: NSUTF8StringEncoding ) {
                return string as String
            }
        }
    }
    return ""
}

public class APIClient {
    
    class func postUrl(var url:String, postData:NSDictionary?, callback: ((AnyObject?,AnyObject?)->Void)? ) {
        let localIp = "localhost:5000"
        let serverIp = "http://sclapp.herokuapp.com"
        let host = serverIp
        
        url = host + url
        
        if (postData != nil) {
            url += "/" + JSONStringify(postData!, prettyPrinted: false)
        }
        
        // Endcode URL
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        println(url)
        
        var error:NSError?
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var queue = NSOperationQueue();
        
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { response, data, error in
            
            
            
            if (data == nil) {
            }
            
            var json:AnyObject?
            
            if (error == nil) {
                // Convert data into a json Dictionary
                json = parseJSON(data)
                
                if (json == nil) {
                    println("No Data")
                }
                
                // Call Callback Function?
                dispatch_async(dispatch_get_main_queue()) {
                    callback?(response,NSString(data: data, encoding: NSUTF8StringEncoding))
                }
                
            }
        })
    }
    
    class func getUrl() {
    }
    
    class func sendReport(json:NSDictionary?) {
        postUrl("/report", postData: json, callback: {response, data in
            println("response: \(response)")
            println("data: \(data)")
        })
    }
    
    class func sendAlert(json:NSDictionary) {
        postUrl("/alert", postData: json, callback: {response, data in
            println("response: \(response)")
            println("data: \(data)")
        })
    }
    
    class func getInfo() {
        
    }
   
}
