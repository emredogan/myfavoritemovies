//
//  Movie+CoreDataProperties.swift
//  top250movies
//
//  Created by Emre Dogan on 09/11/16.
//  Copyright © 2016 Emre Dogan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var image: NSData?
    @NSManaged var title: String?
    @NSManaged var year: String?
    @NSManaged var rating: String?
    @NSManaged var length: String?
    @NSManaged var link: String?
    @NSManaged var status: String?
    @NSManaged var statusImage: NSData?

}


