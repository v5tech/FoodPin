//
//  AboutViewController.swift
//  FoodPin
//
//  Created by scott on 14-11-6.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContact(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            var composer = MFMailComposeViewController()
            composer.delegate = self
            composer.mailComposeDelegate = self
            composer.setToRecipients(["sxyx2008@163.com"])
            composer.navigationBar.tintColor = UIColor.whiteColor()
            self.presentViewController(composer, animated: true, completion: { () -> Void in
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            })
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!){
        switch result.value {
            case MFMailComposeResultCancelled.value:
                println("Cancelled")
            case MFMailComposeResultSaved.value:
                println("Saved")
            case MFMailComposeResultSent.value:
                println("Sent")
            case MFMailComposeResultFailed.value:
                println("Mail send Failed: \(error.localizedDescription)")
            default:
                break
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
