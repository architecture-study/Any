//
//  IssueCell.swift
//  MVP1
//
//  Created by 유병재 on 2017. 8. 2..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import UIKit

class IssueCell : UITableViewCell {
    @IBOutlet var title : UILabel?
    @IBOutlet var number : UILabel?
    
    func configure(data: IssueData) {
        self.title?.text = data.title
        self.number?.text = "\(data.number)"
    }
}
