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
    var comments : Int = 0
}

extension IssueData : Decodable {
    init?(json : JSON) {
        self.title =  ("title" <~~ json) ?? ""
        self.comments = ("comments" <~~ json) ?? 0
    }
}

struct IssueDetailData {
    var userData : UserData = UserData()
    var contents : String = ""
    var updateDate : String = ""
}

extension IssueDetailData : Decodable {
    init?(json: JSON) {
        self.userData = ("user" <~~ json) ?? UserData()
        self.contents = ("body" <~~ json) ?? ""
        self.updateDate = ("updated_at" <~~ json) ?? ""
    }
}

struct UserData {
    var id : String = ""
    var profileImgUrl : String = ""
}

extension UserData : Decodable {
    init?(json: JSON) {
        self.id = ("login" <~~ json) ?? ""
        self.profileImgUrl = ("avatar_url" <~~ json) ?? ""
    }
}
