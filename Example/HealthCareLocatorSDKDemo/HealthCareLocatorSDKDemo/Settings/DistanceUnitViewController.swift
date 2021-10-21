//
//  DistanceUnitViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by theloi on 11/10/2021.
//

import UIKit
import HealthCareLocatorSDK

class DistanceUnitViewController: UIViewController {
    var menus: [MenuSection] = []
    
    weak var delegate: MenuTableViewControllerDelegate?
    var menuTable: MenuTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    func reloadData() {
        let themeMenus = [Menu.selectMenu(title: HCLDistanceUnit.km.rawValue, selected: AppSettings.distanceUnit == .km, data: HCLDistanceUnit.km),
                          Menu.selectMenu(title: HCLDistanceUnit.mile.rawValue, selected: AppSettings.distanceUnit == .mile, data: HCLDistanceUnit.mile)]
        
        menus = [MenuSection(title: kConfigDistanceUnit,
                             menus: themeMenus)]
        
        menuTable.reloadData(menus: menus)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedMenuTable":
                if let menuVC = segue.destination as? MenuTableViewController {
                    menuVC.delegate = self
                    menuVC.menus = menus
                    menuTable = menuVC
                }
            default:
                return
            }
        }
    }
}

extension DistanceUnitViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        delegate?.didSelect(menu: menu)
        navigationController?.popViewController(animated: true)
    }
}
