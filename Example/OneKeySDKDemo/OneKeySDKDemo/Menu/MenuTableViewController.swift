//
//  MenuTableViewController.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

protocol MenuTableViewControllerDelegate: class {
    func didSelect(menu: Menu)
    func didChangeValueFor(menu: Menu, newValue: Any?)
}

extension MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {}
    func didChangeValueFor(menu: Menu, newValue: Any?) {}
}

class MenuTableViewController: UITableViewController {
    var menus: [MenuSection] = []
    weak var delegate: MenuTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func reloadData(menus: [MenuSection]) {
        self.menus = menus
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus[section].menus.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle = menus[section].title else {return nil}
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        titleLabel.text = sectionTitle
        titleLabel.sizeToFit()
        let headerView = UIView()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLabel)
        headerView.addConstraints([NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1, constant: 0),
                                   NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1, constant: 16.0),
                                   NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: headerView, attribute: .right, multiplier: 1, constant: 0)])
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if menus[section].title != nil {
            return 60.0
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = menus[indexPath.section].menus[indexPath.row]
        switch menu {
        case .textMenu(let title, let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellText", for: indexPath) as! TextMenuTableViewCell
            cell.config(title: title, value: value)
            return cell
        case .colorMenu(let title, let color):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellColor", for: indexPath) as! ColorMenuTableViewCell
            cell.config(title: title, color: color)
            return cell
        case .inputMenu(let placeHolder, let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellInput", for: indexPath) as! InputMenuTableViewCell
            cell.configWith(placeHolder: placeHolder, value: value)
            return cell
        case .selectMenu(let title, let selected, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellSelect", for: indexPath) as! SelectMenuTableViewCell
            cell.configWith(title: title, selected: selected)
            return cell
        case .detailMenu(let title):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellDetail", for: indexPath) as! DetailTableViewCell
            cell.configWith(title: title)
            return cell
        case .fontMenu(let title, let font):
            let cell = tableView.dequeueReusableCell(withIdentifier: "FontMenuTableViewCell", for: indexPath) as! FontMenuTableViewCell
            cell.configWith(title: title, font: font)
            return cell
        case .toggleMenu(let title, let isOn):
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToogleMenuTableViewCell", for: indexPath) as! ToogleMenuTableViewCell
            cell.delegate = delegate
            cell.configWith(menu: menu)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(menu: menus[indexPath.section].menus[indexPath.row])
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
