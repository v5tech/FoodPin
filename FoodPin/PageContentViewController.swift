//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by scott on 14-11-4.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var headingLabel: UILabel!

    @IBOutlet weak var subHeadingLabel: UILabel!
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var btnGetStart: UIButton!
    
    @IBOutlet weak var btnForward: UIButton!
    
    var index : Int = 0
    var heading : String = ""
    var imageFile : String = ""
    var subHeading : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        subHeadingLabel.lineBreakMode = .ByWordWrapping
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        btnGetStart.hidden = (index == 2) ? false :true
        btnForward.hidden = (index == 2) ? true :false
    }

    @IBAction func close(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalkthrough")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func nextScreen(sender: AnyObject) {
        if let pageViewController = self.parentViewController as? PageViewController {
            pageViewController.forward(index)
        }
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
