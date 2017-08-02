//
//  DetailViewController.swift
//  MVP1
//
//  Created by 유병재 on 2017. 8. 2..
//  Copyright © 2017년 유병재. All rights reserved.
//

import UIKit

class DetailViewController : UITableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    
    fileprivate let presenter = Presenter()
    var titleStr : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator?.activityIndicatorViewStyle = .gray
        self.activityIndicator?.hidesWhenStopped = true
        self.presenter.delegate = self
        self.tableView?.delegate = self
        self.tableView?.dataSource = presenter
        if let title = self.titleStr {
            self.presenter.getIssueDetail(title: title)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController : IssueDelegate {
    func startLoading() {
        self.activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        self.activityIndicator?.stopAnimating()
        self.tableView?.reloadData()
    }
}

