//
//  MemesTableViewCell.swift
//  extremememe
//
//  Created by Oz Zorany on 01/05/2021.
//

import UIKit

class MemesTableViewCell: UITableViewCell {
    @IBOutlet weak var memeImg: UIImageView!
    @IBOutlet weak var memeDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
