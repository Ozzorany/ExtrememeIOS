//
//  Model.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//

import Foundation
import UIKit
import CoreData

class NotificationGeneral{
    let name: String
    init(_ name: String) {
        self.name = name
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(name), object: self)
    }
    
    func observe(callback:@escaping()->Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(name), object: nil, queue: nil){
            (notification) in
            callback()
        }
    }

}

class Model {
    static let instance = Model()
    public let notificationMemeList = NotificationGeneral("com.oz.extrememe")
    
    private init(){}
        
    let modelFirebase = ModelFirebase()
        
    func getAllMemes(callback:@escaping ([Meme])->Void){
        modelFirebase.getAllMemes(callback: callback)
    }
    
    func add(meme:Meme, callback:@escaping ()->Void){
        modelFirebase.add(meme: meme){
            callback()
            self.notificationMemeList.post()
        }
    }
    
    func delete(meme:Meme){
        modelFirebase.delete(meme: meme){
            self.notificationMemeList.post()
        }
    }
    
    func getMeme(byId:String)->Meme?{
        
        return nil
    }
    
    func saveImage(image:UIImage, callback:@escaping (String)->Void){
        ModelFirebase.saveImage(image: image, callback: callback)
    }

}
