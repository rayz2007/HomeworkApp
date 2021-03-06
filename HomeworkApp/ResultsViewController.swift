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
    var inputData = ""
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var getAnswer: UIButton!
    override func viewDidLoad() {
       // print(appdata.labelResults)
       // self.resultsBox.text = appdata.labelResults
        super.viewDidLoad()
        getAnswer.isEnabled = false
        textField.isUserInteractionEnabled = false
        self.resultsBox.text = inputData
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func printResults(_ sender: Any) {
        if (appdata.equationsArray.count != 0) {
            let getEqa = String(appdata.equationsArray[0])
            let removeSpace = String(getEqa.filter{!" ".contains($0)})
            self.resultsBox.text = removeSpace
            getAnswer.isEnabled = true
        }
    }

    
    @IBOutlet weak var resultsBox: UITextView!
    
    @IBAction func getAnswers(_ sender: Any) {
        let getEqa = String(appdata.equationsArray[0])
        let removeSpace = String(getEqa.filter{!" ".contains($0)})
        self.appdata.history.append(removeSpace)
        
        performSegue(withIdentifier: "getAnswer", sender: self)
    }
    

}
