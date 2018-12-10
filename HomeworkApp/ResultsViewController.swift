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

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var getAnswer: UIButton!
    override func viewDidLoad() {
       // print(appdata.labelResults)
       // self.resultsBox.text = appdata.labelResults
        super.viewDidLoad()
        getAnswer.isEnabled = false
        textField.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func printResults(_ sender: Any) {
        if (appdata.equationsArray.count != 0) {
            self.resultsBox.text = String(appdata.equationsArray[0])
            getAnswer.isEnabled = true
        }
    }

    
    @IBOutlet weak var resultsBox: UITextView!
    


}
