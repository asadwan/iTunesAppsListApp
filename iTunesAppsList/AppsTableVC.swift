//
//  ViewController.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/31/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import UIKit

class AppsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    var apps = [App]()
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - view life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"
        fetchAppsInfo()
        tableView.register(UINib(nibName: "AppsTableCell", bundle: nil), forCellReuseIdentifier: "AppsTableCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppsTableCell", for: indexPath) as! AppsTableCell
        
        if(apps.isEmpty) {
            return cell
        } else {
            let app = apps[indexPath.row]
            cell.appNameLabel.text = app.name
            cell.appImage.loadImageUsingCacheWith(url: app.imageURL!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let appDetailsVC = AppDetailsVC(nibName: "AppDetailsVC", bundle: nil)
        appDetailsVC.app = apps[indexPath.row]
        navigationController?.pushViewController(appDetailsVC, animated: true)
    }
    
    // MARK - Private methods
    
    func fetchAppsInfo() {
        let apiURL = "https://itunes.apple.com/jo/rss/topfreeapplications/limit=50/json"
        let backgroundQueue = DispatchQueue.global(qos: .userInteractive)
        backgroundQueue.async {
            App.getAppsInfoJSON(apiURL: apiURL) { (appsInfoJSON) in
                if let appsInfo = appsInfoJSON {
                    for appInfo in appsInfo {
                        let appInfo = App(appInfoJSON: appInfo)
                        self.apps.append(appInfo)
                    }
                }
                self.reload(tableView: self.tableView)
            }
        }
    }
    
    func reload(tableView: UITableView) {
        tableView.beginUpdates()
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: .none)
        tableView.endUpdates()
    }
}


