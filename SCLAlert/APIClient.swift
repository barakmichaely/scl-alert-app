//
//  APIClient.swift
//  SCLAlert
//
//  Created by Barak M on 6/12/15.
//  Copyright (c) 2015 Barak M. All rights reserved.
//

import UIKit

func parseJSON(data:NSData) throws -> AnyObject {
    return try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
}

func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
    var options : NSJSONWritingOptions? = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
    if NSJSONSerialization.isValidJSONObject(value) {
        if let data = try? NSJSONSerialization.dataWithJSONObject(value, options: options!) {
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
        
        print(url)
        
        var error:NSError?
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        var queue = NSOperationQueue();
        
        request.HTTPMethod = "POST"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler: { response, data, error in
            
            
            
            if (data == nil) {
            }
            
            var json:AnyObject?
            
            if (error == nil) {
                do {
                    // Convert data into a json Dictionary
                    json = try parseJSON(data!)
                } catch _ {
                    json = nil
                }
                
                if (json == nil) {
                    print("No Data")
                }
                
                // Call Callback Function?
                dispatch_async(dispatch_get_main_queue()) {
                    callback?(response,NSString(data: data!, encoding: NSUTF8StringEncoding))
                }
                
            }
        })
    }
    
    class func getUrl() {
    }
    
    class func sendReport(json:NSDictionary?) {
        postUrl("/report", postData: json, callback: {response, data in
            print("response: \(response)")
            print("data: \(data)")
        })
    }
    
    class func sendAlert(json:NSDictionary) {
        postUrl("/alert", postData: json, callback: {response, data in
            print("response: \(response)")
            print("data: \(data)")
        })
    }
    
    class func getInfo() {
        
    }
   
}
