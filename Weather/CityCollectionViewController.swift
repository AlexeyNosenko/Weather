//
//  CityCollectionViewController.swift
//  Weather
//
//  Created by Алексей on 21.06.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CityCollectionViewController: UICollectionViewController {
    
    var city = ""
    private var tempList: [Double] = []
    private var timeList: [String] = []
    private var iconList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadViewData()
    }
    
    func loadViewData(){
        let loader = LoadData()
        let cityWeather = loader.cityLoadDB(city)
        for c in cityWeather{
            print("loadDetail = \(c)")
            for w in c.templst{
                tempList.append(w.t)
                timeList.append(w.tTime)
                iconList.append(w.tIcon)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detail", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = String(tempList[indexPath.row])
        (cell.viewWithTag(2) as! UILabel).text = String(timeList[indexPath.row])
        (cell.viewWithTag(3) as! UIImageView).image = UIImage.init(named: String(iconList[indexPath.row]))
        return cell
    }
    
}
