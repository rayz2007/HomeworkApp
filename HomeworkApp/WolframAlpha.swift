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
    
    var wolframURL: URL {
        return URL(string: "http://api.wolframalpha.com/v2/query?appid=\(wolframAPI)&input=\(appdata.labelResults)&podstate=Result__Step-by-step+solution&format=plaintext")!
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
            //Perform segue
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
}
