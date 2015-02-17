//
//  LoginViewController.swift
//  HoursService.iOSClient
//
//  Created by Ian Roberts on 2/10/15.
//  Copyright (c) 2015 Ian Roberts. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //    var api: ServiceApi = ServiceApi()
    
    var api: HTTPTask = HTTPTask();
    
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBAction func btnLoginTouch(sender: AnyObject) {
        
        var username = txtUserName.text
        var password = txtPassword.text
        
        var error = ""
        
        if (username == "" || password == "")
        {
            error = "Please enter in a username and password"
        }
        
        if error != "" {
            var alert = UIAlertController(title: "Error in Form", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        }
        else{
            //Attemp to login
            //api.post(["username":"admin", "password":"a"], url: "http://domain1:8000/api-token-auth/")
            
            let data: Dictionary<String,AnyObject> = ["username": username, "password":password]
            api.POST("http://staging.userservice.tangentme.com/api-token-auth/", parameters: data, success: {(response: HTTPResponse) in
                println("response:\(response.responseObject!)")
                var jsonStringAsToken:NSString = response.text()!;
                var data: NSData = jsonStringAsToken.dataUsingEncoding(NSUTF8StringEncoding)!
                var error: NSError?
                
                // convert NSData to 'AnyObject'
                let anyObj: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0),
                    error: &error)
                println("Error: \(error)")
                
                let dict = anyObj as Dictionary<String,AnyObject>
                var token:NSString = dict["token"] as NSString
                
                NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                NSUserDefaults.standardUserDefaults().synchronize()
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("gotoTabVC", sender: self)
                }
                },failure: {(error: NSError, response: HTTPResponse?) in
                    self.showInvalidAlert();
            })
        }
    }
    func showInvalidAlert(){
        dispatch_async(dispatch_get_main_queue()) {
        var alert = UIAlertController(title: "Alert", message: "Your Account is invalid,Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}
