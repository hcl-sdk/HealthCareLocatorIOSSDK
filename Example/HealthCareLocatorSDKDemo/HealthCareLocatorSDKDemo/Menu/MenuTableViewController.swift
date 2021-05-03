//
//  MenuTableViewController.swift
//  HealthCareLocatorSDKDemo
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
    var expandedSection: [Int] = []
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
        return (expandedSection.contains(section) || menus[section].colapsedLimit == nil) ?
            menus[section].menus.count :
            min(menus[section].colapsedLimit!, menus[section].menus.count)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionTitle = menus[section].title else {return nil}
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor(hexString: "5CBCD5")
        titleLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        titleLabel.text = sectionTitle
        stackView.addArrangedSubview(titleLabel)

        if menus[section].colapsedLimit != nil {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
            button.tag = section
            button.setTitle("View more", for: .normal)
            button.setTitleColor(UIColor(hexString: "5CBCD5"), for: .normal)
            button.addTarget(self, action: #selector(toogleListAction(sender:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        let headerView = UIView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(stackView)
        headerView.addConstraints([NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0),
                                   NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0),
                                   NSLayoutConstraint(item: stackView, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1, constant: 16.0),
                                   NSLayoutConstraint(item: stackView, attribute: .right, relatedBy: .equal, toItem: headerView, attribute: .right, multiplier: 1, constant: -16.0)])
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
            let formatedTitle = title.splitBefore(separator: { $0.isUpperCase }).map {String($0).capitalizingFirstLetter().replacingOccurrences(of: "Bkg", with: "Background")}.joined(separator: " ")
            cell.config(title: formatedTitle, color: color)
            return cell
        case .inputMenu(let placeHolder, let value):
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCellInput", for: indexPath) as! InputMenuTableViewCell
            cell.configWith(placeHolder: placeHolder, value: value)
            cell.delegate = self
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
            let formatedTitle = title.splitBefore(separator: { $0.isUpperCase }).map {String($0).capitalizingFirstLetter()}.joined(separator: " ")
            cell.configWith(title: formatedTitle, font: font)
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
    
    @objc func toogleListAction(sender: UIButton) {
        let section = sender.tag
        if let index = expandedSection.firstIndex(of: section) {
            expandedSection.remove(at: index)
        } else {
            expandedSection.append(section)
        }
        
        tableView?.beginUpdates()
        tableView?.reloadSections(IndexSet(integer: section), with: .automatic)
        tableView?.endUpdates()
        
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

extension MenuTableViewController: InputMenuTableViewCellDelegate {
    func didChangeText(newText: String?, for cell: InputMenuTableViewCell) {
        delegate?.didChangeValueFor(menu: .inputMenu(placeHolder: cell.inputTextField.placeholder ?? "",
                                                     value: nil),
                                    newValue: newText)
    }
}
