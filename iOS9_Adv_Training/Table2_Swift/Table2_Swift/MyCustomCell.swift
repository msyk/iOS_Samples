//
//  MyCustomCell.swift
//  Table2_Swift
//
//  Created by 新居雅行 on 2015/01/28.
//  Copyright (c) 2015年 msyk.net. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    @IBOutlet var column1: UILabel?
    @IBOutlet var column2: UILabel?
    @IBOutlet var column3: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
