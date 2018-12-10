//
//  AppData.swift
//  HomeworkApp
//
//  Created by iosdev on 12/9/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class AppData: NSObject {

    static let shared = AppData()
    
    open var imageURL : URL!
    var labelResults : String = ""
    var equationsArray : [String.SubSequence] = []
    var history : [String] = []
    var steps : [String] = []
    var completeSteps = ""

}
