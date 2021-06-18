//
//  ModelFirebase.swift
//  extremememe
//
//  Created by Oz Zorany on 23/05/2021.
//

import Foundation
import Firebase


class ModelFirebase{
    init(){
        let db = Firestore.firestore()
    }
    
    func getAllMemes(since: Int64, callback:@escaping ([Meme])->Void){
        let db = Firestore.firestore()
        db.collection("memes")
            .whereField("lastUpdated", isGreaterThan: Timestamp(seconds: since, nanoseconds: 0))
            .getDocuments { snapshot, error in
            if let err = error{
                print("Error reading document: \(err)")
            }else{
                if let snapshot = snapshot{
                    var memes = [Meme]()
                    for snap in snapshot.documents{
                        if let st = Meme.create(json:snap.data()){
                            memes.append(st)
                        }
                    }
                    callback(memes)
                    return
                }
            }
            callback([Meme]())
        }
        
    }
    
    func add(meme:Meme, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        let id = Firestore.firestore().collection("memes").document().documentID
        meme.id = id
        db.collection("memes").document(id).setData(meme.toJson()){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written!")
            }
            callback()
        }
    }
    
    func delete(meme:Meme, callback:@escaping ()->Void){
        let db = Firestore.firestore()
        db.collection("memes").document(meme.id!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
            callback()
        }

    }
    
    func getStudent(byId:String)->Meme?{
        
        return nil
    }
    
    static func saveImage(image:UIImage, callback:@escaping (String)->Void){
        let storageRef = Storage.storage().reference(forURL:
                                                        "gs://extrememe-ios.appspot.com/pic")
        let data = image.jpegData(compressionQuality: 0.8)
        let imageRef = storageRef.child("imageName")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    callback("")
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
}
