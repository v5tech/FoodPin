//
//  Restaurant.swift
//  FoodPin
//
//  Created by scott on 14-11-1.
//  Copyright (c) 2014年 scott. All rights reserved.
//

import Foundation
import CoreData

class Restaurant: NSManagedObject{
    
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var location:String!
    @NSManaged var image:NSData!
    @NSManaged var isVisited:NSNumber!
    
}