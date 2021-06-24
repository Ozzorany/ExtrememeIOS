//
//  MyMemesTableViewCell.swift
//  extremememe
//
//  Created by Oz Zorany on 24/06/2021.
//

import Foundation
import UIKit

class MyMemesTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var memeImg: UIImageView!
    @IBOutlet weak var memeDescription: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
