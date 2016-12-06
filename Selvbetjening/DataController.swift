//
//  DataController.swift
//  Selvbetjening
//
//  Created by Christian Munch Hammervig on 05/12/2016.
//  Copyright © 2016 cBrain. All rights reserved.
//

import Foundation
import Alamofire
import HTMLReader

let URLString = "http://lev-demo.cbrain.net/selfservicewebsite/submissions"

class DataController {
    var charts: [Chart]?
    
    private func parseHTMLRow(rowElement: HTMLElement) -> Chart? {
        // TODO: implement
    }
    
    private func isChartsTable(tableElement: HTMLElement) -> Bool {
        // TODO: implement
    }
    
    func fetchCharts(completionHandler: @escaping (NSError?) -> Void) {
        Alamofire.request(URLString)
            .responseString { responseString in
                guard responseString.result.error == nil else {
                    completionHandler(responseString.result.error!)
                    return
                    
                }
                guard let htmlAsString = responseString.result.value else {
                    let error = Error.errorWithCode(.StringSerializationFailed, failureReason: "Could not get HTML as String")
                    completionHandler(error)
                    return
                }
                
                let doc = HTMLDocument(string: htmlAsString)
                
                // find the table of charts in the HTML
                let tables = doc.nodesMatchingSelector("tbody")
                var chartsTable:HTMLElement?
                for table in tables {
                    if let tableElement = table as? HTMLElement {
                        if self.isChartsTable(tableElement) {
                            chartsTable = tableElement
                            break
                        }
                    }
                }
                
                // make sure we found the table of charts
                guard let tableContents = chartsTable else {
                    // TODO: create error
                    let error = Error.errorWithCode(.DataSerializationFailed, failureReason: "Could not find charts table in HTML document")
                    completionHandler(error)
                    return
                }
                
                self.charts = []
                for row in tableContents.children {
                    if let rowElement = row as? HTMLElement { // TODO: should be able to combine this with loop above
                        if let newChart = self.parseHTMLRow(rowElement) {
                            self.charts?.append(newChart)
                        }
                    }
                }
                completionHandler(nil)
        }
    
    }
}
