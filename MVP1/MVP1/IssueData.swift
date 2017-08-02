//
//  IssueData.swift
//  MVP1
//
//  Created by 유병재 on 2017. 8. 2..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import Gloss

struct IssueData {
    var title : String = ""
    var number : Int = 0
}

extension IssueData : Decodable {
    init?(json : JSON) {
        self.title =  ("title" <~~ json) ?? ""
        self.number = ("number" <~~ json) ?? 0
    }

}
