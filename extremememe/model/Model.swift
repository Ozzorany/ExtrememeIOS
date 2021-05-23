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
        
    let modelFirebase = ModelFirebase()
        
    func getAllMemes(callback:@escaping ([Meme])->Void){
        modelFirebase.getAllMemes(callback: callback)
    }
    
    func add(meme:Meme){
        modelFirebase.add(meme: meme)
    }
    
    func delete(meme:Meme){
        modelFirebase.delete(meme: meme)
    }
    
    func getMeme(byId:String)->Meme?{
        
        return nil
    }

}
