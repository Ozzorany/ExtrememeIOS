//
//  MemesViewController.swift
//  extremememe
//
//  Created by Oz Zorany on 01/05/2021.
//

import UIKit

class MemesViewController: UIViewController{
    
    @IBOutlet weak var memesTableView: UITableView!
    var data = [Meme]()
    var editingFlag = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Model.instance.getAllMemes { memes in
            self.data = memes
            self.tableView.reloadData()
        }
    }
}

extension MemesViewController: UITableViewDataSource{
    
    /* UITableViewDelegate protocol */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memesTableView.dequeueReusableCell(withIdentifier: "myMemeRow", for: indexPath) as! MemesTableViewCell
        
        let meme = data[indexPath.row]
        cell.memeDescription.text = meme.name
        return cell
    }
}

extension MemesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return editingFlag
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("")
        
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let meme = data[indexPath.row]
            Model.instance.delete(meme: meme)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }}
