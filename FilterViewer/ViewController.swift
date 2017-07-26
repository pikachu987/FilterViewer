//
//  ViewController.swift
//  FilterViewer
//
//  Created by pikachu987 on 2017. 7. 26..
//  Copyright © 2017년 pikachu987. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate var page = 0
    fileprivate var isOrigin = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UINib(nibName: "FiltersCell", bundle: Bundle.main), forCellWithReuseIdentifier: "FiltersCell")
        self.collectionView.collectionViewLayout = .detailLayout()
        self.collectionView.isPagingEnabled = true


        self.title = FilterHelper.shared.filterArray[self.page].name
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "원본보기", style: .done, target: self, action: #selector(self.originAction(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "필터보기", style: .done, target: self, action: #selector(self.convertAction(_:)))

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { 
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @objc private func originAction(_ sender: UIBarButtonItem){
        if self.isOrigin == true{
            return
        }
        self.isOrigin = true
        self.collectionView.reloadData()
    }

    @objc private func convertAction(_ sender: UIBarButtonItem){
        if self.isOrigin == false{
            return
        }
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.isOrigin = false
        self.collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }

}



extension ViewController: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / (scrollView.contentSize.width / CGFloat(FilterHelper.shared.filterArray.count)))
        if page != self.page{
            self.page = page
            self.title = FilterHelper.shared.filterArray[self.page].name
        }
    }
}


extension ViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterHelper.shared.filterArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FiltersCell", for: indexPath) as! FiltersCell
        cell.setEntity(FilterHelper.shared.filterArray[indexPath.row], isOrigin: self.isOrigin)
        return cell
    }
}
