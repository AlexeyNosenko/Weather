//
//  CityCollectionViewController.swift
//  Weather
//
//  Created by Алексей on 21.06.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CityCollectionViewController: UICollectionViewController {
    
    var city = ""
    private var temp_list: [Double] = []
    private var time_list: [String] = []
    private var icon_list: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadViewData()
    }
    
    func loadViewData(){
        let loader = LoadData()
        let cityWeather = loader.CityLoadDB(city)
        for c in cityWeather{
            print("loadDetail = \(c)")
            for w in c.templst{
                temp_list.append(w.t)
                time_list.append(w.t_time)
                icon_list.append(w.t_icon)
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return temp_list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detail", for: indexPath)
        (cell.viewWithTag(1) as! UILabel).text = String(temp_list[indexPath.row])
        (cell.viewWithTag(2) as! UILabel).text = String(time_list[indexPath.row])
        (cell.viewWithTag(3) as! UIImageView).image = UIImage.init(named: String(icon_list[indexPath.row]))
        return cell
    }
    
}
