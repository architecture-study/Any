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

    fileprivate let presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator?.activityIndicatorViewStyle = .gray
        self.activityIndicator?.hidesWhenStopped = true
        self.presenter.delegate = self
        self.tableView?.delegate = self
        self.tableView?.dataSource = presenter
//        self.presenter.getIssues()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController, segue.identifier == "passData", let cell = sender as? IssueCell {
            dest.title = cell.title?.text
        }
    }
    
    @IBAction func loadIssue(_ sender:Any) {
        self.presenter.getIssues()
    }
    
    @IBAction func addIssue(_ sender:Any) {
        self.presenter.addIssue()
    }
}

extension ViewController : IssueDelegate {
    func startLoading() {
        self.activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        self.activityIndicator?.stopAnimating()
        self.tableView?.reloadData()
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "passData", sender: cell)
    }
}
