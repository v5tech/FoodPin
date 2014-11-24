//
//  ShareViewController.swift
//  FoodPin
//
//  Created by scott on 14-11-2.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var message: UIButton!
    @IBOutlet weak var email: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let translateDown = CGAffineTransformMakeTranslation(0, 500)
        facebook.transform = translateDown
        message.transform = translateDown
        
        let translateUp = CGAffineTransformMakeTranslation(0, -500)
        twitter.transform = translateUp
        email.transform = translateUp
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let translate = CGAffineTransformMakeTranslation(0, 0)
        
        UIView.animateWithDuration(0.8, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: {
            
            self.facebook.transform = translate
            self.email.transform = translate
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.8, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: {
            
            self.twitter.transform = translate
            self.message.transform = translate
            
            }, completion: nil)
        
    }
}
