//
//  FilterItem.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import UIKit

struct FilterItem {
    var name = ""
    var image: UIImage?

    init(_ name: String, image: UIImage?) {
        self.image = image
        self.name = name
    }

    init() {
        
    }
}
