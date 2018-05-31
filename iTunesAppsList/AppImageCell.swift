//
//  profileImageTableCell.swift
//  ZenonCarpooling
//
//  Created by Abdullah Adwan on 5/27/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit

class AppImageCell: UITableViewCell {


    @IBOutlet weak var appImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        appImageView.layer.cornerRadius = 15
        appImageView.layer.masksToBounds = true
        self.layoutMargins = UIEdgeInsets.zero
        self.separatorInset = UIEdgeInsets.zero
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        self.tintColor = UIColor(white: 0.0, alpha: 0.0)
    }
}
