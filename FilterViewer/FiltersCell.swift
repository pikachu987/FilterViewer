//
//  FiltersCell.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import UIKit

class FiltersCell: UICollectionViewCell {
    @IBOutlet private weak var tableView: UITableView!

    fileprivate var isOrigin: Bool = false

    fileprivate var item = FilterItem()
    override func awakeFromNib() {
        super.awakeFromNib()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: "FilterCell", bundle: Bundle.main), forCellReuseIdentifier: "FilterCell")
        self.tableView.rowHeight = 400
    }

    func setEntity(_ item: FilterItem, isOrigin: Bool){
        self.item = item
        self.isOrigin = isOrigin
        self.tableView.setContentOffset(.zero, animated: false)
        self.tableView.reloadData()
    }
}


extension FiltersCell: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}


extension FiltersCell: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ImageHelper.shared.images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.setEntity(indexPath.row, item: self.item, isOrigin: self.isOrigin)
        return cell
    }
}
