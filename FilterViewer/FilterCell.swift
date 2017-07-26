//
//  FilterCell.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import UIKit
import GPUImage

class FilterCell: UITableViewCell {
    @IBOutlet weak var filterImageView: UIImageView!

    private var filterImage: UIImage?
    private var originImage: UIImage?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.filterImageView.contentMode = .scaleAspectFill
        self.filterImageView.clipsToBounds = true
        self.clipsToBounds = true
    }

    func setEntity(_ row: Int, item: FilterItem, isOrigin: Bool){
        let image = ImageHelper.shared.images[row]
        self.originImage = image
        self.filterImageView?.image = image
        if !isOrigin{
            DispatchQueue.global().async {
                let filter = item.filter
                let stillImageSource = GPUImagePicture(image: image)
                stillImageSource?.addTarget(filter)
                filter.useNextFrameForImageCapture()
                stillImageSource?.processImage()
                let image = filter.imageFromCurrentFramebuffer()
                DispatchQueue.main.async {
                    self.filterImage = image
                    self.filterImageView.image = image
                }
            }
        }
    }

    
}
