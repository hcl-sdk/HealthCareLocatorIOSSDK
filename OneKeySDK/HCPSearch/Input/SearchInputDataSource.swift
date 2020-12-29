//
//  SearchInputDataSource.swift
//  OneKeySDK
//
//  Created by Truong Le on 12/25/20.
//

import Foundation
import UIKit

protocol SearchInputDataSourceDelegate: class {
    func didSelect(result: SearchAutoComplete)
}

class SearchInputDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private var searchResult: [SearchAutoComplete] = []
    private var input: String = ""
    private var theme: OKThemeConfigure?
    private var tableView: UITableView!
    
    weak var delegate: SearchInputDataSourceDelegate?
    
    init(tableView: UITableView, theme: OKThemeConfigure?) {
        super.init()
        self.tableView = tableView
        self.theme = theme
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func reloadWith(result: [SearchAutoComplete], input: String) {
        self.searchResult = result
        self.input = input
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let theme = theme {
            switch searchResult[indexPath.row] {
            case .Code(let code):
                let cell = tableView.dequeueReusableCell(withIdentifier: "CodeAutoCompleteTableViewCell") as! CodeAutoCompleteTableViewCell
                cell.configWith(theme: theme,
                                code: code,
                                highlight: input)
                return cell
            case .Individual(let individual):
                let cell = tableView.dequeueReusableCell(withIdentifier: "IndividualAutoCompleteTableViewCell") as! IndividualAutoCompleteTableViewCell
                cell.configWith(theme: theme,
                                individual: individual,
                                highlight: input)
                return cell
            case .NearMe:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
                cell.configWith(theme: theme,
                                iconImage: UIImage.OKImageWith(name: "geoloc")!,
                                title: kNearMeTitle)
                return cell
            case .Address(let address):
                let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
                cell.configWith(theme: theme,
                                iconImage: UIImage.OKImageWith(name: "marker")!,
                                title: "\(address.title), \(address.subtitle)")
                return cell
            default:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(result: searchResult[indexPath.row] )
    }
}
