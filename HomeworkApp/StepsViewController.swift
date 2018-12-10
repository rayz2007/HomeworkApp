//
//  StepsViewController.swift
//  HomeworkApp
//
//  Created by iGuest on 12/9/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {

    @IBOutlet weak var stepsView: UITextView!
    var appdata = AppData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepsView.text = appdata.completeSteps
    }

}
