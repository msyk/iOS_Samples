//
//  ViewController.swift
//  CollectionView_Swift
//
//  Created by 新居雅行 on 2015/01/29.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,
UICollectionViewDataSource, UICollectionViewDelegate {
    
    var year: Int = 2015
    var month: Int = 1
    
    private var startDateBias: Int = 0
    private var endDayNum: Int = 0
    private var lines: Int = 0
    
    private let end_of_month: [Int]
    = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    private let cells_per_line: Int = 7
    private let cell_width: Float = 42.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "\(year) \(month)"
        
        let fl = collectionViewLayout as! UICollectionViewFlowLayout
        let space = (320.0 - cell_width * Float(cells_per_line))
            / Float(cells_per_line - 1)
        fl.minimumInteritemSpacing = CGFloat(space)
        fl.sectionInset = UIEdgeInsets(top: 1.0, left: 0.0, bottom: 1.0, right: 0.0)
        
        let dtFormatter = NSDateFormatter()
        dtFormatter.dateFormat = "yyyy-MM-dd"
        let firstDate = dtFormatter.dateFromString(
            NSString(format:"%4d-%2d-01", year, month) as String)
        let cal = NSCalendar.currentCalendar()
        let comps = cal.components(
            NSCalendarUnit.WeekdayCalendarUnit,
            fromDate: firstDate!)
        startDateBias = comps.weekday - 1
        endDayNum = end_of_month[month]
        lines = (endDayNum + startDateBias) / cells_per_line
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
                "DATACELL", forIndexPath: indexPath) as! DataCellView
            let dayNum = indexPath.item
                + indexPath.section * cells_per_line - startDateBias + 1
            if dayNum > 0 && dayNum <= endDayNum {
                cell.dataLabel?.text = "\(dayNum)"
            } else {
                cell.dataLabel?.text = "."
            }
            return cell
    }
    
    override func collectionView(
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return cells_per_line
    }
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView) -> Int {
            return lines
    }
    
}

