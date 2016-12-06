//
//  Chart.swift
//  Selvbetjening
//
//  Created by Christian Munch Hammervig on 05/12/2016.
//  Copyright © 2016 cBrain. All rights reserved.
//

import Foundation

class Chart {
    let title: String
    let url: NSURL
    
    required init(title: String, url: NSURL){
        self.title = title
        self.url = url
    }
}
