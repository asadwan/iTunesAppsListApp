//
//  ImageVC.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/31/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.loadImageUsingCacheWith(url: imageUrl)
    }
}
