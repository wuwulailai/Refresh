//
//  ViewController.swift
//  RefreshDemo
//
//  Created by wubaolai on 2018/10/19.
//  Copyright © 2018 wubaolai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshBlock = { [weak self] in
            print(self ?? "")
        }
    }

    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        index = sender.selectedSegmentIndex
        if index == 0 {
            tableView.set(loadType: .normal)
        } else if index == 1 {
            tableView.set(loadType: .loading)
        } else if index == 2 {
            tableView.set(loadType: .noData)
        } else if index == 3 {
            tableView.set(loadType: .noNetwork)
        } else if index == 4 {
            tableView.set(loadType: .error)
        }
    }
    
}

