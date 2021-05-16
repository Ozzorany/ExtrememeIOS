//
//  NewMemeViewController.swift
//  extremememe
//
//  Created by Oz Zorany on 16/05/2021.
//

import UIKit

class NewMemeViewController: UIViewController {
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeDescription: UITextView!
    @IBAction func save(_ sender: Any) {
        let meme = Meme.create(id: "2", name: memeDescription.text!, imageUrl: "")
        Model.instance.add(meme: meme)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
