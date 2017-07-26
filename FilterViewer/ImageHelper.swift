//
//  ImageHelper.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import UIKit

class ImageHelper: NSObject {
    static let shared = ImageHelper()

    var images = [UIImage]()

    private override init() {
        super.init()

        self.addImage("image1.jpeg")
        self.addImage("image2.jpeg")
        self.addImage("image3.jpeg")
    }

    private func addImage(_ named: String){
        guard let image = UIImage(named: named) else {
            return
        }
        self.images.append(image)
    }
}
