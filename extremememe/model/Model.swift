//
//  Model.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//

import Foundation
import UIKit
import CoreData
import Firebase

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
    
    private init(){
    }
        
    let modelFirebase = ModelFirebase()
        
    func getAllMemes(callback:@escaping ([Meme])->Void){
        var localLastUpdateTime = Meme.getLocalUpdate()
        
        modelFirebase.getAllMemes(since: localLastUpdateTime){
            (memes) in
           
            
            for meme in memes {
                if(meme.lastUpdated > localLastUpdateTime) {
                    localLastUpdateTime = meme.lastUpdated
                }
            }
            Meme.setLocalUpdate(localLastUpdateTime)

           
            
            for meme in memes {
                if meme.logicalDeleted {
                    meme.delete()
                }
            }
            
            if(memes.count > 0){
                memes[0].save()
            }
            
            Meme.getAll(callback: callback)
        }
    }
    
    func add(meme:Meme, callback:@escaping ()->Void){
        modelFirebase.add(meme: meme){
            callback()
            self.notificationMemeList.post()
        }
    }
    
    func delete(meme:Meme, callback:@escaping ()->Void){
        meme.logicalDeleted = true
        modelFirebase.add(meme: meme){
            callback()
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
