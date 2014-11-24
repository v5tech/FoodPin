//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by scott on 14-10-31.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var restaurants:[Restaurant] = []
    
    var searchResults:[Restaurant] = []
    
    var fetchResultsController:NSFetchedResultsController!
    
    var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        /********************************UISearchBar**********************************************/
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = UIColor.whiteColor()
        // searchController.searchBar.barTintColor = UIColor(red: 231.0/255.0, green: 95.0/255.0, blue: 53.0/255.0, alpha: 0.3)
        // searchController.searchBar.prompt = "Quick Search"
        searchController.searchBar.placeholder = NSLocalizedString("Search your restaurant", comment: "Search your restaurant")
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        
        /********************************从CoreData中获取数据**********************************************/
        var fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescription]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            var e:NSError?
            var result = fetchResultsController.performFetch(&e)
            restaurants = fetchResultsController.fetchedObjects as [Restaurant]
            if result != true {
                println(e?.localizedDescription)
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        /********************************UIPageViewController**********************************************/
        let defaults = NSUserDefaults.standardUserDefaults()
        var hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        if hasViewedWalkthrough == false {
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
                self.presentViewController(pageViewController, animated: false, completion: nil)
            }
        }
    }
    
    
    // 检索过滤
    func filterContentSearchText(searchText:String){
        searchResults = restaurants.filter({ ( restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return nameMatch != nil || locationMatch != nil
        })
    }

    func updateSearchResultsForSearchController(searchController: UISearchController){
        let searchText = searchController.searchBar.text
        filterContentSearchText(searchText)
        tableView.reloadData()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    
    // MARK: - tableView
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active {
            return searchResults.count
        }else {
            return restaurants.count
        }
    }
    // 此大法是为了滑动单元格时显示UITableViewRowAction
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active {
            return false
        }else {
            return true
        }
    }
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
            var shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
            NSLocalizedString("Share", comment: "Share Action"), handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let shareMenu = UIAlertController(title: nil, message: NSLocalizedString("Share using", comment: "For social sharing"),
        preferredStyle: .ActionSheet)
                
            let twitterAction = UIAlertAction(title: NSLocalizedString("Twitter", comment: "For sharing on Twitter"), style:
        UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) -> Void in
        })
            let facebookAction = UIAlertAction(title: NSLocalizedString("Facebook", comment: "For sharing on Facebook"), style:
            UIAlertActionStyle.Default, handler: {(action:UIAlertAction!) -> Void in
            })
            let emailAction = UIAlertAction(title: NSLocalizedString("Email", comment: "For sharing on Email"), style: UIAlertActionStyle.Default,
            handler: {(action:UIAlertAction!) -> Void in
            })
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: UIAlertActionStyle.Cancel,
                handler: {(action:UIAlertAction!) -> Void in
            })
            shareMenu.addAction(twitterAction)
            shareMenu.addAction(facebookAction)
            shareMenu.addAction(emailAction)
            shareMenu.addAction(cancelAction)
            self.presentViewController(shareMenu, animated: true, completion: nil)
            } )
            
           var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default,
                    title: "Delete",handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                    // Delete the row from the data source
                        
                        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
                            let restaurantToDelete = self.fetchResultsController.objectAtIndexPath(indexPath) as Restaurant
                            managedObjectContext.deleteObject(restaurantToDelete)
                            var error:NSError?
                            if managedObjectContext.save(&error) != true {
                                println("Delete error: " + error!.localizedDescription)
                            }
                        }
            
            } )
        
            deleteAction.backgroundColor = UIColor(red: 237.0/255.0, green: 75.0/255.0, blue: 27.0/255.0, alpha: 1.0)
            shareAction.backgroundColor = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 1.0)

            return [deleteAction,shareAction]
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as CustomTableViewCell
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        cell.nameLabel.text = restaurant.name
        cell.typeLabel.text = restaurant.type
        cell.locationLabel.text = restaurant.location
        cell.favorIconImageView.hidden = !restaurant.isVisited.boolValue
        cell.thumbnailImageView.image = UIImage(data: restaurant.image)
        cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2
        cell.thumbnailImageView.clipsToBounds = true
        return cell
    }
        
    // MARK: - nav
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            let destinationController = segue.destinationViewController as DetailViewController
            //destinationController.hidesBottomBarWhenPushed = true
            let indexPath = tableView.indexPathForSelectedRow()!
            let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            destinationController.restaurant = restaurant
        }
    }
    
    // unwind segue
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
}
