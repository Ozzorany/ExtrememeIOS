//
//  NewMemeViewController.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//

import UIKit


class NewMemeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var memeId: String = ""
    var memeUrl: String = ""
    var memeDescr: String?
    var isEditMode: Bool = false
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeDescription: UITextView!
    @IBAction func save(_ sender: Any) {
        if let image = image{
            Model.instance.saveImage(image: image) { (url) in
                self.saveMeme(url: url)
            }
        }else{
            self.saveMeme(url: memeUrl)
        }
    }
    
    func saveMeme(url:String){
        let user: String = UserDefaults.standard.string(forKey: "user") ?? ""
        let meme: Meme
        
        if isEditMode
        {
            meme = Meme.create(id: memeId, name: memeDescription.text, imageUrl: url, userId: user)
           
            
           Model.instance.update(meme: meme){
            self.navigationController?.popViewController(animated: true)
            self.tabBarController?.selectedIndex = 0
           }
        } else {
            meme = Meme.create(id: "", name: memeDescription.text, imageUrl: url, userId: user)
            
            Model.instance.add(meme: meme){
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    var image: UIImage?
    
    @IBAction func editImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
        
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.memeImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEditMode {
            let url = URL(string: memeUrl)
            memeImage.kf.setImage(with: url)
            memeDescription.text = memeDescr
        }
    }
}
