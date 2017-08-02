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
    @IBOutlet var comments : UILabel?
    
    func configure(data: IssueData?) {
        guard let data = data else { return }
        self.title?.text = data.title
        self.comments?.text = "댓글 \(data.comments)개"
    }
}

class IssueDetailCell : UITableViewCell {
    @IBOutlet var id : UILabel?
    @IBOutlet var profileImg : UIImageView?
    @IBOutlet var contents : UILabel?
    @IBOutlet var date : UILabel?
    
    func configure(data: IssueDetailData?) {
        guard let data = data else { return }
        self.id?.text = data.userData.id
        self.profileImg?.layer.cornerRadius = 15
        self.profileImg?.clipsToBounds = true
        self.contents?.text = data.contents
        self.date?.text = data.updateDate
        if let imgUrl = URL(string: data.userData.profileImgUrl) {
            self.profileImg?.image = UIImage(data: try! Data(contentsOf: imgUrl))
        }
    }
}
