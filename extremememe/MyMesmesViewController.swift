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
    var refreshControl = UIRefreshControl()
    
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
    
    func reloadData(){
        refreshControl.beginRefreshing()
        Model.instance.getAllMemes{
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
            return 101
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = myMemesTableView.dequeueReusableCell(withIdentifier: "ownerMemeCell", for: indexPath) as! MyMemesTableViewCell
            
            let meme = data[indexPath.row]
            cell.memeDescription.text = meme.name
            let url = URL(string: meme.imageUrl!)
            cell.memeImg.kf.setImage(with: url)
            return cell
        }
    }

    extension MyMemesViewController: UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
            return true
        }

        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            print("")
            
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
