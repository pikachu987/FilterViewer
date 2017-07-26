//
//  FilterItem.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import Foundation
import GPUImage

struct FilterItem {
    var filter = GPUImageFilter()
    var name = ""

    init(_ name: String, filter: GPUImageFilter) {
        self.filter = filter
        self.name = name
    }

    init() {
        
    }
}
