//
//  WolframAlpha.swift
//  HomeworkApp
//
//  Created by iGuest on 12/9/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class WolframAlpha: UIViewController, XMLParserDelegate {
    
    let wolframAPI = "8TTTK2-J7V3W3EWY8"
    var appdata = AppData.shared
    let session = URLSession.shared
    var currentParsingElement = ""
    var elementTitle = ""
    var resultsSeen = false
    var steps = ""
    
//    var wolframURL: URL {
//        return URL(string: "http://api.wolframalpha.com/v2/query?appid=\(wolframAPI)&input=\(appdata.labelResults)&podstate=Result__Step-by-step+solution&format=plaintext")!
//    }
    
    var wolframURL: URL {
        return URL(string: "http://api.wolframalpha.com/v2/query?appid=8TTTK2-J7V3W3EWY8&input=solve+3x-7%3D11&podstate=Result__Step-by-step+solution&format=plaintext")!
    }
    
    var inputData = ""
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var getAnswer: UIButton!
    @IBOutlet weak var resultsBox: UITextView!
    override func viewDidLoad() {
        // print(appdata.labelResults)
        // self.resultsBox.text = appdata.labelResults
        super.viewDidLoad()
        //getAnswer.isEnabled = false
        textField.isUserInteractionEnabled = false
        self.resultsBox.text = inputData
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func printResults(_ sender: Any) {
        if (appdata.equationsArray.count != 0) {
            self.resultsBox.text = String(appdata.equationsArray[0])
            getAnswer.isEnabled = true
        }
    }
    
    @IBAction func getAnswers(_ sender: Any) {
//        let storeAns = String(self.appdata.equationsArray[0])
//        self.appdata.history.append(storeAns)
        
        self.createRequest()
    }
    
    open func createRequest() {
        var request = URLRequest(url: wolframURL)
        request.httpMethod = "GET"
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request) }
    }
    
    func runRequestOnBackgroundThread(_ request: URLRequest) {
        let task = URLSession.shared.dataTask(with: wolframURL) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentParsingElement = elementName
        elementTitle = attributeDict["title"] ?? ""
        if(elementTitle == "Possible intermediate steps"){
            resultsSeen = true
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let foundedChar = string.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines)
        if(resultsSeen && !foundedChar.isEmpty) {
            steps = steps + foundedChar
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //end of parsing
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.appdata.steps = self.steps.components(separatedBy: "\n")
            self.appdata.completeSteps = self.steps
            self.performSegue(withIdentifier: "getAnswers", sender: self)
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
}
