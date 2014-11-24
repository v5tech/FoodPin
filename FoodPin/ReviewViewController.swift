//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by scott on 14-11-2.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var dialogView: UIView!
    
    var blueFffectView:UIVisualEffectView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        dialogView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        dialogView.transform = CGAffineTransformMakeTranslation(0, 500)
        
        var blueEffect = UIBlurEffect(style: .Dark)
        blueFffectView = UIVisualEffectView(effect: blueEffect)
        blueFffectView.frame = view.bounds
        backgroundImageView.addSubview(blueFffectView)
        
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.blueFffectView.removeFromSuperview()
        var blueEffect = UIBlurEffect(style: .Dark)
        blueFffectView = UIVisualEffectView(effect: blueEffect)
        blueFffectView.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height + 20);
        backgroundImageView.addSubview(blueFffectView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        UIView.animateWithDuration(0.7, delay: 0.0, options: nil, animations: { () -> Void in
//            self.dialogView.transform = CGAffineTransformMakeScale(1, 1)
//        }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
            }, completion: nil)
    }
    
}
