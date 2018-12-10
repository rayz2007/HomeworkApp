//
//  History.swift
//  HomeworkApp
//
//  Created by iosdev on 12/9/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class History: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var appdata = AppData.shared
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appdata.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "NameTableIdentifier")
        if cell == nil {
            NSLog("Creating new UITableViewCell")
            cell = UITableViewCell(style: .value1, reuseIdentifier: "NameTableIdentifier")
        }
        cell?.textLabel?.text = self.appdata.history[indexPath.row]

        return cell!
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBOutlet weak var tableView: UITableView!
    

}
