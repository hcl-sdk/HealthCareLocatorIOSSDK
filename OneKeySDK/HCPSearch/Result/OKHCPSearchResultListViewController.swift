//
//  OKHCPSearchResultListViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/23/20.
//

import UIKit

class OKHCPSearchResultListViewController: UITableViewController, OKActivityList, OKViewDesign {
    
    weak var delegate: OKActivityHandler?
    
    var theme: OKThemeConfigure?
    var result: [ActivityResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        if let theme = theme {
            layoutWith(theme: theme)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func layoutWith(theme: OKThemeConfigure) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HCPCardTableViewCell", for: indexPath) as! HCPCardTableViewCell
        cell.configWith(theme: theme, item: result[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(activity: result[indexPath.row])
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

extension OKHCPSearchResultListViewController: OkSortableResultList {
    func reloadWith(data: [ActivityResult]) {
        result = data
        tableView.beginUpdates()
        let sections = NSIndexSet(indexesIn: NSRange(location: 0, length: tableView.numberOfSections))
        tableView.reloadSections(sections as IndexSet, with: .automatic)
        tableView.endUpdates()
    }
}
