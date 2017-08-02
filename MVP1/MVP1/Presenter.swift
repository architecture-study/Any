//
//  Presenter.swift
//  MVP1
//
//  Created by 유병재 on 2017. 8. 2..
//  Copyright © 2017년 유병재. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Gloss

protocol IssueDelegate : class {
    func startLoading()
    func finishLoading()
    func getIssues(_ issues: [IssueData?])
}

class Presenter : NSObject {
    
    var delegate : IssueDelegate?
    var dataArr : [IssueData?] = []
    
    func getIssues() {
        self.delegate?.startLoading()
        Alamofire.request("https://api.github.com/repos/lkzhao/Hero/issues").responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print("success")
                guard let issueJson = data as? [JSON] else { return }
                guard let issueList = [IssueData].from(jsonArray: issueJson) else { return }
                self.dataArr = issueList
                self.delegate?.getIssues(issueList)
            case .failure(let error):
                print(error)
            }
        }
        self.delegate?.finishLoading()
    }
}

extension Presenter : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? IssueCell, let data = self.dataArr[indexPath.row] {
            cell.configure(data: data)
        }
        return UITableViewCell()
    }
}