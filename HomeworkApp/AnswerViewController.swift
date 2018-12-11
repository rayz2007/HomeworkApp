//
//  AnswerViewController.swift
//  HomeworkApp
//
//  Created by iGuest on 12/9/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var ResultView: UITextView!
    var appdata = AppData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResultView.isUserInteractionEnabled = false
        ResultView.text = appdata.steps[appdata.steps.count - 1]
        print("get ans")
        print(appdata.steps[appdata.steps.count - 1])
    }
    
    @IBAction func backToHome(_ sender: Any) {
        ResultView.text = ""
        performSegue(withIdentifier: "backToHome", sender: self)
        
    }
}
