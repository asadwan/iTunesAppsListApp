//
//  AppDescriptionCell.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/31/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit

class AppDescriptionCell: UITableViewCell {

    @IBOutlet weak var appDescriptionTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
