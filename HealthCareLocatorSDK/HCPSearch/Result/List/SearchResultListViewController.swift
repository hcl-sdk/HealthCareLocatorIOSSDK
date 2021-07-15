//
//  SearchResultListViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/23/20.
//

import UIKit

class SearchResultListViewController: UITableViewController, ActivityListHandler, ViewDesign {
    
    static let shared = SearchResultListViewController()
    weak var delegate: ActivityHandler?
    var result: [ActivityResult] = []
    var selectedIndexs: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = .init()
        layoutWith(theme: theme)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let first = SearchResultListViewController.shared.selectedIndexs.first {
            tableView.scrollToRow(at: IndexPath(row: first, section: 0),
                                  at: .top, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SearchResultListViewController.shared.selectedIndexs = []
    }
    
    func layoutWith(theme: HCLThemeConfigure) {
        tableView.backgroundColor = theme.listBkgColor
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "HCPCardTableViewCell", for: indexPath) as? HCPCardTableViewCell
        else {
            return .init()
        }
        cell.configWith(theme: theme, icons: icons, item: result[indexPath.row],
                        selected: SearchResultListViewController.shared.selectedIndexs.contains(indexPath.row) == true)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(activity: result[indexPath.row])
    }
}

extension SearchResultListViewController: SortableResultList {
    
    func reloadWith(data: [ActivityResult]) {
        result = data
        if isViewLoaded {
            tableView.beginUpdates()
            let sections = NSIndexSet(indexesIn: NSRange(location: 0, length: tableView.numberOfSections))
            tableView.reloadSections(sections as IndexSet, with: .automatic)
            tableView.endUpdates()
        }
    }
}
