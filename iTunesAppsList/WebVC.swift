//
//  WebVC.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/31/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var webKitView: WKWebView!
    var linkURL: URL!
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webKitView.allowsBackForwardNavigationGestures = true
        webKitView.load(URLRequest(url: linkURL))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissWebView))
    }
    
    // MARK: - Actions and handlers
    
    @objc func dismissWebView() {
        self.dismiss(animated: true, completion: nil)
    }
}
