//
//  PickerListViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/27/20.
//

import UIKit

protocol PickerListViewControllerDelegate: class {
    func didSelect(item: String, at index: Int)
    func backAction()
}

class PickerListViewController: UIViewController, ViewDesign {

    var selectedIndex: Int?
    
    private let cellIdentifier = "TextPickerTableViewCell"
    
    weak var delegate: PickerListViewControllerDelegate?
    
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = [] {
        didSet {
            if isViewLoaded {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TextPickerTableViewCell",
                                 bundle: Bundle.internalBundle()),
                           forCellReuseIdentifier: cellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        delegate?.backAction()
    }
    
    func configWith(items: [String], selected: Int?) {
        self.items = items
        self.selectedIndex = selected
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PickerListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextPickerTableViewCell") as! TextPickerTableViewCell
        cell.configWith(theme: theme, item: items[indexPath.row], selected: indexPath.row == selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(item: items[indexPath.row], at: indexPath.row)
    }
}
