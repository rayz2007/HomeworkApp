//
//  ResultsViewController.swift
//  HomeworkApp
//
//  Created by iGuest on 12/9/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    var appdata = AppData.shared

    override func viewDidLoad() {
        print(appdata.labelResults)
        self.resultsBox.text = appdata.labelResults
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet weak var resultsBox: UILabel!
    
    


}
