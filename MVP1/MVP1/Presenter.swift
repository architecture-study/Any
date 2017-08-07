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
}

class Presenter : NSObject {
    
    var delegate : IssueDelegate?
    var dataArr : [Any?] = []
    
    func getIssues() {
        self.delegate?.startLoading()
        Alamofire.request("https://api.github.com/repos/architecture-study/foobar/issues").responseJSON { (response) in
            switch response.result {
            case .success(let data):
                guard let issueJson = data as? [JSON] else { return }
                guard let issueList = [IssueData].from(jsonArray: issueJson) else { return }
                self.dataArr = issueList
                self.delegate?.finishLoading()
            case .failure(let error):
                print(error)
                self.delegate?.finishLoading()
            }
        }
    }
    
    func addIssue() {
        self.delegate?.startLoading()

        let headers: HTTPHeaders = [
            "Authorization": "token 3dad1883ae3aef453bde6796559681d379ca837e",
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "title": "bj2",
            "body": "1",
        ]
        
        Alamofire.request("https://api.github.com/repos/architecture-study/foobar/issues", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                self.delegate?.finishLoading()
            case .failure(let error):
                print(error)
                self.delegate?.finishLoading()
            }
        }
    }
    
    func closeIssue(_ number:Int) {
        self.delegate?.startLoading()
        
        let headers: HTTPHeaders = [
            "Authorization": "token 3dad1883ae3aef453bde6796559681d379ca837e",
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [ "state": "close" ]
        
        Alamofire.request("https://api.github.com/repos/architecture-study/foobar/issues/\(number)", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                self.delegate?.finishLoading()
            case .failure(let error):
                print(error)
                self.delegate?.finishLoading()
            }
        }
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
            cell.configure(data: data as? IssueData)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let data = self.dataArr.remove(at: indexPath.row) as? IssueData {
                self.closeIssue(data.number)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
