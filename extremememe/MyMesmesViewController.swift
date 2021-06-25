//
//  MyMesmesViewController.swift
//  extremememe
//
//  Created by Oz Zorany on 24/06/2021.
//

import Foundation
import UIKit
import Kingfisher
import GoogleSignIn
import Firebase


class MyMemesViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    var data = [Meme]()
    var selectedId: String = ""
    var selectedImage: String?
    var selectedDescription = ""
    var refreshControl = UIRefreshControl()
    
    @IBAction func editMeme(_ sender: UIButton) {
        let position = sender.convert(CGPoint.zero, to: self.myMemesTableView)
        let indexPath = self.myMemesTableView.indexPathForRow(at: position)

        let cell = self.myMemesTableView.cellForRow(at: indexPath!) as! MyMemesTableViewCell
        
        selectedId = cell.memeId
        selectedImage = cell.url
        selectedDescription = cell.memeDescription.text!
        
    }
    @IBOutlet weak var myMemesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        myMemesTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        Model.instance.notificationMemeList.observe {
            self.reloadData()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toAddScreen"){
            
            let destination = segue.destination as! NewMemeViewController
            destination.memeUrl = selectedImage!
            destination.memeId = selectedId
            destination.memeDescr = selectedDescription
            destination.isEditMode = true
        }
    }
    
    func reloadData(){
        let user: String = UserDefaults.standard.string(forKey: "user") ?? ""

        refreshControl.beginRefreshing()
        Model.instance.getMyMemes(userId: user){
            memes in
            self.data = memes
            self.myMemesTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        Model.instance.notificationMemeList.observe {
            self.reloadData()
        }
    }
}
    
    
    extension MyMemesViewController: UITableViewDataSource{
        
        /* UITableViewDelegate protocol */
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 400
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = view.backgroundColor
            return headerView
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = myMemesTableView.dequeueReusableCell(withIdentifier: "ownerMemeCell", for: indexPath) as! MyMemesTableViewCell
            
            let meme = data[indexPath.row]
            
            if meme.id != nil {
                cell.memeDescription.text = meme.name
                cell.memeId = meme.id!
                cell.url = meme.imageUrl!
                
                let url = URL(string: meme.imageUrl!)
                cell.memeImg.kf.setImage(with: url)
            } else {
                print(indexPath)
            }
            
            
            return cell
        }
    }

    extension MyMemesViewController: UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
            return true
        }

        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let meme = data[indexPath.row]
                Model.instance.delete(meme: meme){
                    self.data.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
               
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }}
