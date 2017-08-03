//
//  DetailPresenter.swift
//  MVP1
//
//  Created by 유병재 on 2017. 8. 3..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import UIKit
import Gloss
import Alamofire

class DetailPresenter : Presenter {
    
    func getIssueDetail(title:String) {
        self.delegate?.startLoading()
        Alamofire.request("https://api.github.com/repos/architecture-study/foobar/issues/\(title)/comments").responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let issueJson = data as? [JSON] else { return }
                guard let issueList = [IssueDetailData].from(jsonArray: issueJson) else { return }
                self.dataArr = issueList
                self.delegate?.finishLoading()
            case .failure(let error):
                print(error)
                self.delegate?.finishLoading()
            }
        }
    }
}

extension DetailPresenter {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetail", for: indexPath) as? IssueDetailCell, let data = self.dataArr[indexPath.row] {
            cell.configure(data: data as? IssueDetailData)
            return cell
        }
        return UITableViewCell()
    }
}
