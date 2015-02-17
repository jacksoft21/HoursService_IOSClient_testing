//
//  FirstViewController.swift
//  HoursService.iOSClient
//
//  Created by Ian Roberts on 2/10/15.
//  Copyright (c) 2015 Ian Roberts. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     @IBAction func btnLogout(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            NSUserDefaults.standardUserDefaults().setObject("", forKey: "token")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}

