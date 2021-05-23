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
        FirebaseApp.configure()
        let db = Firestore.firestore()
    }
    
    func getAllMemes(callback:@escaping ([Meme])->Void){
        let db = Firestore.firestore()
        db.collection("memes").getDocuments { snapshot, error in
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
    
    func add(meme:Meme){
        let db = Firestore.firestore()
        db.collection("memes").document(meme.id!).setData(meme.toJson()){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            }else{
                print("Document successfully written!")
            }
        }
    }
    
    func delete(meme:Meme){
        let db = Firestore.firestore()
        db.collection("memes").document(meme.id!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }

    }
    
    func getStudent(byId:String)->Meme?{
        
        return nil
    }
    }
