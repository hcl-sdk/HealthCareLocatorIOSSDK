//
//  SearchHistoryDataSource.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/30/20.
//

import Foundation
import UIKit

protocol SearchHistoryCellDelegate: class {
    func shouldRemoveActivityAt(indexPath: IndexPath)
    func shouldRemoveSearchAt(indexPath: IndexPath)
}

protocol SearchHistoryDataSourceDelegate: class {
    func didSelectNearMeSearch()
    func didSelect(activity: Activity)
    func didSelect(search: LastSearch)
    func shouldRemoveActivityAt(index: Int)
    func shouldRemoveSearchAt(index: Int)
}

extension SearchHistoryDataSourceDelegate {
    func didSelectNearMeSearch() {}
    func didSelect(activity: Activity) {}
    func didSelect(search: LastSearch) {}
}

class SearchHistoryDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, ViewDesign {
    weak var delegate: SearchHistoryDataSourceDelegate?
    
    private let colapseItemMax = 4
    private let expandItemMax = 11
    
    weak var tableView: UITableView?
    var data: [HistorySection] = []
    var expandedSection: [Int] = []
    
    init(tableView: UITableView) {
        super.init()
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "HeaderViewMoreTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: "HeaderViewMoreTableViewCell")
        tableView.register(UINib(nibName: "ActivityMapTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: "ActivityMapTableViewCell")
        tableView.register(UINib(nibName: "HCPConsultedHistoryTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: "HCPConsultedHistoryTableViewCell")
        tableView.register(UINib(nibName: "SearchHistoryTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: "SearchHistoryTableViewCell")
        self.tableView = tableView
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
        case .lastSearchs(_, let searches):
            if searches.count == 0 {
                return 0
            } else {
                if !expandedSection.contains(section) {
                    return min(colapseItemMax, searches.count + 1)
                } else {
                    return min(expandItemMax, searches.count + 1)
                }
            }
        case .lasHCPConsolted(_, let activities):
            if activities.count == 0 {
                return 0
            } else {
                if !expandedSection.contains(section) {
                    return min(colapseItemMax, activities.count + 1)
                } else {
                    return min(expandItemMax, activities.count + 1)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewMoreTableViewCell") as! HeaderViewMoreTableViewCell
            let viewLessText = "hcl_view_less".localized
            let viewMoreText = "hcl_view_more".localized

            switch data[indexPath.section] {
            case .nearMe:
                cell.configWith(theme: theme, indexPath: indexPath, title: data[indexPath.section].title, actionTitle: nil)
            case .lastSearchs(let title, let searches):
                cell.configWith(theme: theme,
                                indexPath: indexPath,
                                title: title,
                                actionTitle: searches.count > colapseItemMax - 1 ? (expandedSection.contains(indexPath.section) ? viewLessText : viewMoreText) : nil)
            case .lasHCPConsolted(let title, let activities):
                cell.configWith(theme: theme,
                                indexPath: indexPath,
                                title: title,
                                actionTitle: activities.count > colapseItemMax - 1 ? (expandedSection.contains(indexPath.section) ? viewLessText : viewMoreText) : nil)
            }
            cell.delegate = self
            return cell
        default:
            switch data[indexPath.section] {
            case .nearMe(_, let activities):
                let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityMapTableViewCell") as! ActivityMapTableViewCell
                cell.configWith(theme: theme,
                                activities: activities,
                                center: LocationManager.shared.currentLocation?.coordinate,
                                isLastRow: true)
                cell.delegate = self.delegate
                return cell
            case .lastSearchs(_ , let searches):
                let search = searches[indexPath.row - 1]
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell") as! SearchHistoryTableViewCell
                let lastCellIndex = !expandedSection.contains(indexPath.section) ?
                    min(colapseItemMax, searches.count + 1) :
                    min(expandItemMax, searches.count + 1)
                let isLastRow = lastCellIndex == (indexPath.row + 1)
                cell.configWith(theme: theme, icons: icons, lang: HCLManager.shared.lang.code, search: search, isLastRow: isLastRow)
                cell.indexPath = indexPath
                cell.delegate = self
                return cell
            case .lasHCPConsolted(_, let activities):
                let activity = activities[indexPath.row - 1]
                let cell = tableView.dequeueReusableCell(withIdentifier: "HCPConsultedHistoryTableViewCell") as! HCPConsultedHistoryTableViewCell
                let lastCellIndex = !expandedSection.contains(indexPath.section) ?
                    min(colapseItemMax, activities.count + 1) :
                    min(expandItemMax, activities.count + 1)
                let isLastRow = lastCellIndex == (indexPath.row + 1)
                cell.configWith(theme: theme, icons: icons, lang: HCLManager.shared.lang.code, activity: activity, isLastRow: isLastRow)
                cell.indexPath = indexPath
                cell.delegate = self
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            switch data[indexPath.section] {
            case .nearMe:
                delegate?.didSelectNearMeSearch()
            case .lastSearchs(_, let searches):
                let search = searches[indexPath.row - 1]
                handleSelect(search: search)
            case .lasHCPConsolted(_, let activities):
                let hcp = activities[indexPath.row - 1]
               handleSelect(hcp: hcp)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

extension SearchHistoryDataSource: HeaderViewMoreTableViewCellDelegate {
    func onAction(indexPath: IndexPath) {
        if let index = expandedSection.firstIndex(of: indexPath.section) {
            expandedSection.remove(at: index)
        } else {
            expandedSection.append(indexPath.section)
        }
        
        tableView?.beginUpdates()
        tableView?.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        tableView?.endUpdates()
    }
}

extension SearchHistoryDataSource: SearchHistoryCellDelegate {
    func handleSelect(search: LastSearch) {
        var histories = AppConfigure.getLastSearchesHistory()
        if let index = histories.firstIndex(of: search) {
            histories.remove(at: index)
            histories.insert(search.clone(), at: 0)
            AppConfigure.setLastSearchesHistory(searches: histories)
        }
        delegate?.didSelect(search: search)
    }
    
    func handleSelect(hcp: LastHCPConsulted) {
        var HCPs = AppConfigure.getLastHCPsConsulted()
        if let index = HCPs.firstIndex(of: hcp) {
            HCPs.remove(at: index)
            HCPs.insert(hcp.clone(), at: 0)
            AppConfigure.setLastHCPsConsulted(HCPs: HCPs)
        }
        delegate?.didSelect(activity: hcp.activity)
    }
    
    func shouldRemoveActivityAt(indexPath: IndexPath) {
        switch data[indexPath.section] {
        case .lasHCPConsolted(let title, let activities):
            var newList = activities
            newList.remove(at: indexPath.row - 1)
            data[indexPath.section] = HistorySection.lasHCPConsolted(title: title, activities: newList)
            tableView?.reloadData()
            delegate?.shouldRemoveActivityAt(index: indexPath.row - 1)
        default:
            return
        }
    }
    
    func shouldRemoveSearchAt(indexPath: IndexPath) {
        switch data[indexPath.section] {
        case .lastSearchs(let title, let searches):
            var newList = searches
            newList.remove(at: indexPath.row - 1)
            data[indexPath.section] = HistorySection.lastSearchs(title: title, searches: newList)
            tableView?.reloadData()
            delegate?.shouldRemoveSearchAt(index: indexPath.row - 1)
        default:
            return
        }
    }
}
