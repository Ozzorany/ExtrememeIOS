//
//  Meme+CoreDataProperties.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//
//

import Foundation
import CoreData


extension Meme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meme> {
        return NSFetchRequest<Meme>(entityName: "Meme")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?

}

extension Meme : Identifiable {

}
