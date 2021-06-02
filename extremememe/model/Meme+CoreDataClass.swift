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
    
    static func create(json:[String:Any])->Meme?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let meme = Meme(context: context)
        meme.id = json["id"] as? String
        meme.name = json["name"] as? String
        meme.imageUrl = json["imageUrl"] as? String
        return meme
    }
    
    func toJson()->[String:Any]{
        var json = [String:Any]()
        json["id"] = id!
        json["name"] = name!
        if let imageUrl = imageUrl{
            json["imageUrl"] = imageUrl
        }else{
            json["imageUrl"] = ""
        }
        return json
    }
}

extension Meme {
    static func getAll(callback:@escaping ([Meme])->Void){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Meme.fetchRequest() as NSFetchRequest<Meme>
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        DispatchQueue.global().async {
            //second thread code
            var data = [Meme]()
            do{
                data = try context.fetch(request)
            }catch{
            }
            
            DispatchQueue.main.async {
                // code to execute on main thread
                callback(data)
            }
        }
    }

    func save(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try context.save()
        }catch{
            
        }
    }

    func delete(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(self)
        do{
            try context.save()
        }catch{
            
        }
    }

    static func getMeme(byId:String)->Meme?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let request = Meme.fetchRequest() as NSFetchRequest<Meme>
        request.predicate = NSPredicate(format: "id == \(byId)")
        do{
            let students = try context.fetch(request)
            if students.count > 0 {
                return students[0]
            }
        }catch{
            
        }
        return nil
    }}

