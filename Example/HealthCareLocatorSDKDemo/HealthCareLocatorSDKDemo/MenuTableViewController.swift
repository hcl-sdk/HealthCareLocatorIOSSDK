//
<<<<<<< HEAD:Example/HealthCareLocatorSDKDemo/HealthCareLocatorSDKDemo/MenuTableViewController.swift
//  MenuTableViewController.swift
//  OneKeySDKDemo
=======
//  SearchResultListViewController.swift
//  HealthCareLocatorSDK
>>>>>>> release/1.0.0:HealthCareLocatorSDK/HCPSearch/Result/List/SearchResultListViewController.swift
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

<<<<<<< HEAD:Example/HealthCareLocatorSDKDemo/HealthCareLocatorSDKDemo/MenuTableViewController.swift
enum MainMenu: String {
    case newSearch
    
    var menuTitle: String {
        switch self {
        case .newSearch:
            return "New Search"
        default:
            return ""
        }
    }
    
    static let allMenus = [MainMenu.newSearch]
}
=======
class SearchResultListViewController: UITableViewController, ActivityListHandler, ViewDesign {
    
    weak var delegate: ActivityHandler?
    
    var result: [ActivityResult] = []
>>>>>>> release/1.0.0:HealthCareLocatorSDK/HCPSearch/Result/List/SearchResultListViewController.swift

protocol MenuTableViewControllerDelegate: class {
    func didSelect(menu: MainMenu)
}

class MenuTableViewController: UITableViewController {

    weak var delegate: MenuTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD:Example/HealthCareLocatorSDKDemo/HealthCareLocatorSDKDemo/MenuTableViewController.swift
=======
        tableView.tableFooterView = UIView()
        layoutWith(theme: theme)
    }
>>>>>>> release/1.0.0:HealthCareLocatorSDK/HCPSearch/Result/List/SearchResultListViewController.swift

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
<<<<<<< HEAD:Example/HealthCareLocatorSDKDemo/HealthCareLocatorSDKDemo/MenuTableViewController.swift

=======
    
    func layoutWith(theme: HCLThemeConfigure) {
        tableView.backgroundColor = theme.listBkgColor
    }
    
>>>>>>> release/1.0.0:HealthCareLocatorSDK/HCPSearch/Result/List/SearchResultListViewController.swift
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainMenu.allMenus.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD:Example/HealthCareLocatorSDKDemo/HealthCareLocatorSDKDemo/MenuTableViewController.swift
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 32.0, weight: .medium)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = MainMenu.allMenus[indexPath.row].menuTitle
=======
        let cell = tableView.dequeueReusableCell(withIdentifier: "HCPCardTableViewCell", for: indexPath) as! HCPCardTableViewCell
        cell.configWith(theme: theme, icons: icons, item: result[indexPath.row])
        
>>>>>>> release/1.0.0:HealthCareLocatorSDK/HCPSearch/Result/List/SearchResultListViewController.swift
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
<<<<<<< HEAD:Example/HealthCareLocatorSDKDemo/HealthCareLocatorSDKDemo/MenuTableViewController.swift
        delegate?.didSelect(menu: MainMenu.allMenus[indexPath.row])
=======
        delegate?.didSelect(activity: result[indexPath.row])
>>>>>>> release/1.0.0:HealthCareLocatorSDK/HCPSearch/Result/List/SearchResultListViewController.swift
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
