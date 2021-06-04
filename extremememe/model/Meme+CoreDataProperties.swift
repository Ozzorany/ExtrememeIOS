//
//  Meme+CoreDataProperties.swift
//  
//
//  Created by Oz Zorany on 04/06/2021.
//
//

import Foundation
import CoreData


extension Meme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meme> {
        return NSFetchRequest<Meme>(entityName: "Meme")
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var lastUpdated: Int64
    @NSManaged public var logicalDeleted: Bool

}
