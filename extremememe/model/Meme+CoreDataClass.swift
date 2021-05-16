//
//  Meme+CoreDataClass.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//
//

import Foundation
import CoreData
import UIKit

@objc(Meme)
public class Meme: NSManagedObject {
    static func create(id:String, name:String, imageUrl:String)->Meme{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let meme = Meme(context: context)
        meme.id = id
        meme.name = name
        meme.imageUrl = imageUrl
        return meme
    }
}
