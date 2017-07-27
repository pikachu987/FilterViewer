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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var filterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
        self.filterImageView.contentMode = .scaleAspectFill
        self.filterImageView.clipsToBounds = true
        self.clipsToBounds = true
        self.titleLabel.textAlignment = .center
    }

    func setEntity(_ item: FilterItem){
        self.filterImageView.image = item.image
        self.titleLabel.text = item.name
    }

    
}
