//
//  OKHCPSearchResultViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class OKHCPSearchResultViewController: UIViewController {

    var resultNavigationVC: UINavigationController!
    var result: [SearchResultModel] = []
    
    @IBOutlet weak var displayModeSegmentView: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeViewMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            resultNavigationVC.popToRootViewController(animated: true)
        case 1:
            if let viewMapVC = UIStoryboard(name: "HCPSearch", bundle: Bundle.internalBundle()).instantiateViewController(withIdentifier: "OKHCPSearchResultMapViewController") as? OKHCPSearchResultMapViewController {
                viewMapVC.result = result
                resultNavigationVC.pushViewController(viewMapVC, animated: true)
            }
        default:
            return
        }
    }

    // MARK: - Navigation

    @IBAction func unwindToOKHCPSearchResultViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedResultNavicationVC":
                if let desVC = segue.destination as? UINavigationController {
                    resultNavigationVC = desVC
                }
            default:
                return
            }
        }
    }

}
