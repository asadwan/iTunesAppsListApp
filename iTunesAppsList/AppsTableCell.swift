//
//  AppsTableCell.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/30/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit

class AppsTableCell: UITableViewCell {

    @IBOutlet weak var appImage: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        appImage.layer.cornerRadius = 15
        appImage.layer.masksToBounds = true
    }
}
