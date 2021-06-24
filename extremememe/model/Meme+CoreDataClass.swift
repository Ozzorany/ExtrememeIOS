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
import Firebase

@objc(Meme)
public class Meme: NSManagedObject {
    static func create(id:String, name:String, imageUrl:String, lastUpdated: Int64=0, userId: String)->Meme{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let meme = Meme(context: context)
        meme.id = id
        meme.name = name
        meme.imageUrl = imageUrl
        meme.lastUpdated = lastUpdated
        meme.logicalDeleted = false
        meme.userId = userId
        return meme
    }
    
    static func create(json:[String:Any])->Meme?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let meme = Meme(context: context)
        meme.id = json["id"] as? String
        meme.name = json["name"] as? String
        meme.imageUrl = json["imageUrl"] as? String
        meme.logicalDeleted = false
        meme.userId = json["userId"] as? String
        if let ld = json["logicalDeleted"] as? Bool{
            meme.logicalDeleted = ld
        }
        meme.lastUpdated = 0
        if let timestamp = json["lastUpdated"] as? Timestamp{
            meme.lastUpdated = timestamp.seconds
        }
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
        json["userId"] = userId
        json["lastUpdated"] = FieldValue.serverTimestamp()
        json["logicalDeleted"] = logicalDeleted
        return json
    }
}

extension Meme {
    static func getAll(callback:@escaping ([Meme])->Void){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Meme.fetchRequest() as NSFetchRequest<Meme>
        request.predicate = NSPredicate(format:"logicalDeleted == \(false)")
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
    
    static func getAllMyMemes(userId: String, callback:@escaping ([Meme])->Void){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Meme.fetchRequest() as NSFetchRequest<Meme>
        request.predicate = NSPredicate(format:"logicalDeleted == \(false) and userId == \(userId)")
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
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
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
        request.predicate = NSPredicate(format: "id == \(byId) AND logicalDeleted == \(false)")
        
        
        do{
            let students = try context.fetch(request)
            if students.count > 0 {
                return students[0]
            }
        }catch{
            
        }
        return nil
    }
    
    static func setLocalUpdate(_ update: Int64){
        UserDefaults.standard.setValue(update, forKey: "MemeLastUpdateTime")
    }
    
    static func getLocalUpdate()->Int64{
        return Int64(UserDefaults.standard.integer(forKey: "MemeLastUpdateTime"))
        
    }
}

