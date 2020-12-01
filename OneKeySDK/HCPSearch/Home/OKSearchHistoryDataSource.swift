//
//  OKSearchHistoryDataSource.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import UIKit

class OKSearchHistoryDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, OKViewDesign {
    var theme: OKThemeConfigure?
    
    weak var tableView: UITableView?
    var data: [HistorySection] = []

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HeaderViewMoreTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: "HeaderViewMoreTableViewCell")
        tableView.register(UINib(nibName: "ActivityMapTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: "ActivityMapTableViewCell")
        self.tableView = tableView
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        self.theme = theme
        tableView?.reloadData()
    }
    
    func reloadWith(data: [HistorySection]) {
        self.data = data
        tableView?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch data[section] {
        case .nearMe:
            return 2
        case .lastSearchs(_, let activities):
            return activities.count
        case .lasHCPConsolted(_, let activities):
            return activities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewMoreTableViewCell") as! HeaderViewMoreTableViewCell
            cell.configWith(theme: theme, title: data[indexPath.section].title, actionTitle: "View more")
            return cell
        default:
            switch data[indexPath.section] {
            case .nearMe(_, let activities):
                let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityMapTableViewCell") as! ActivityMapTableViewCell
                cell.configWith(theme: theme, activities: activities, isLastRow: true)
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
}
