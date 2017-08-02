//
//  ViewController.swift
//  MVP1
//
//  Created by 유병재 on 2017. 8. 2..
//  Copyright © 2017년 유병재. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView : UITableView?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?

    var dataSource : [IssueData?] = []
    fileprivate let presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator?.activityIndicatorViewStyle = .gray
        self.activityIndicator?.hidesWhenStopped = true
        self.tableView?.delegate = self
        self.tableView?.dataSource = presenter
        self.presenter.delegate = self
        self.presenter.getIssues()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : IssueDelegate {
    func startLoading() {
        self.activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        self.activityIndicator?.stopAnimating()
    }
    
    func getIssues(_ issues: [IssueData?]) {
        self.dataSource = issues
        self.tableView?.reloadData()
    }
}

extension ViewController : UITableViewDelegate {}
