//
//  DetailViewController.swift
//  FoodPin
//
//  Created by scott on 14-11-1.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var restaurantImageView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var restaurant:Restaurant!
    
    
    // MARK: - UIStoryboardSegue
    @IBAction func close(segue:UIStoryboardSegue){
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMap" {
            let mapViewController = segue.destinationViewController as MapViewController
            mapViewController.restaurant = self.restaurant
        }
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = restaurant.name
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.restaurantImageView.image = UIImage(data: restaurant.image)
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
    
    // MARK: - tableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as DetailTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.mapButton.hidden = true
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = NSLocalizedString("Name", comment: "Name")
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = NSLocalizedString("Type", comment: "Type")
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = NSLocalizedString("Location", comment: "Location")
            cell.valueLabel.text = restaurant.location
            cell.mapButton.hidden = false
        case 3:
            cell.fieldLabel.text = NSLocalizedString("Been here", comment: "Been here")
            cell.valueLabel.text = (restaurant.isVisited.boolValue) ? NSLocalizedString("Yes, I’ve been here before", comment: "I’ve been here before") : NSLocalizedString("No", comment: "Never Been here")
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }
}
