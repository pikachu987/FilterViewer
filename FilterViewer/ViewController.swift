//
//  ViewController.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!

    fileprivate var filterArray = [FilterItem]()

    private let image = UIImage(named: "image3.jpeg")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.imageView.image = self.image
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true

        self.titleLabel.textAlignment = .center
        self.titleLabel.text = "Original"

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.register(UINib(nibName: "FilterCell", bundle: Bundle.main), forCellReuseIdentifier: "FilterCell")

        self.makeFilter()
    }

    //필터 넣기
    private func makeFilter(){
        guard let image = self.image else {
            return
        }

        FilterHelper.shared.makeFilter(image){ (filter) in
            self.filterArray.append(filter)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.setEntity(self.filterArray[indexPath.row])
        return cell
    }
}
