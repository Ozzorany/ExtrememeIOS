//
//  Model.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//

import Foundation
import UIKit
import CoreData

class Model {
static let instance = Model()

private init(){}
        
    func getAllMemes(callback:@escaping ([Meme])->Void){
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

    func add(meme:Meme){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try context.save()
        }catch{
            
        }
    }

    func delete(meme:Meme){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(meme)
        do{
            try context.save()
        }catch{
            
        }
    }

    func getMeme(byId:String)->Meme?{
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
    }

}
