//
//  FilterHelper.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

//https://github.com/BradLarson/GPUImage


import UIKit
import GPUImage

class FilterHelper: NSObject {
    static let shared = FilterHelper()

    var filterArray = [FilterItem]()


    private override init() {
        super.init()

        self.filter1()
    }

    private func filter1(){
        for value in -3...6{
            let filter = GPUImageBrightnessFilter()
            filter.brightness = CGFloat(value)/10
            self.filterArray.append(FilterItem("Brightness\(value)", filter: filter))
        }
    }

}
