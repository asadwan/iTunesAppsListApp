//
//  AppDetailsVC.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/31/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit
import WebKit
class AppDetailsVC: UITableViewController, WKNavigationDelegate {
    
    // MARK: - Properties
    
    var app: App!
    var webKitView: WKWebView!
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = app.name
        
        // get button to view app page on a web view
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Get", style: .plain, target: self, action: #selector(openAppLink))
        
        // register cells
        tableView.register(UINib(nibName: "AppDetailCell", bundle: nil), forCellReuseIdentifier: "AppDetailCell")
        tableView.register(UINib(nibName: "AppImageCell", bundle: nil), forCellReuseIdentifier: "AppImageCell")
        tableView.register(UINib(nibName: "AppDescriptionCell", bundle: nil), forCellReuseIdentifier: "AppDescriptionCell")
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 2) {
            return "Description"
        }
        return nil
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppImageCell", for: indexPath) as! AppImageCell
            cell.appImageView.loadImageUsingCacheWith(url: app.imageURL!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDetailCell", for: indexPath) as! AppDetailCell
            if(row == 0) {
                cell.detailKeyLabel.text = "App Name"
                cell.detailValueLabel.text = app.name
            } else if (row == 1) {
                cell.detailKeyLabel.text = "Category"
                cell.detailValueLabel.text = app.category
            } else if (row == 2) {
                cell.detailKeyLabel.text = "Release Date"
                cell.detailValueLabel.text = app.releaseDate
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppDescriptionCell", for: indexPath) as! AppDescriptionCell
            cell.appDescriptionTextView.text = app.summary
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch section {
        case 0:
            return 120.0
        case 1:
            return 66.0
        case 2:
            return 200.0
        default:
            return 66
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let imageVC = ImageVC(nibName: "ImageVC", bundle: nil)
            imageVC.imageUrl = app.imageURL
            navigationController?.pushViewController(imageVC, animated: true)
            break
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Handlers & Private Methods
    
    @objc func openAppLink() {
        let webVC = WebVC(nibName: "WebVC", bundle: nil)
        webVC.linkURL = app.link
        let navigationController = UINavigationController(rootViewController: webVC)
        present(navigationController, animated: true, completion: nil)
    }
}
