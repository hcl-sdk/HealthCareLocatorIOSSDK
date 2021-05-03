//
//  OKHCPSearchInputViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class OKHCPSearchInputViewController: UIViewController {
    var webService: OKHCPSearchWebServicesProtocol = MockOKHCPSearchWebServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSearchAction(_ sender: Any) {
        webService.searchHCPWith(input: SearchHCPInput()) {[weak self] (result, error) in
            guard let strongSelf = self, let unwrapResult = result else {return}
            strongSelf.performSegue(withIdentifier: "showResultVC", sender: unwrapResult)
        }
    }
    
    // MARK: - Navigation

    @IBAction func unwindToOKHCPSearchInputViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showResultVC":
                if let desVC = segue.destination as? OKHCPSearchResultViewController,
                   let result = sender as? [SearchResultModel] {
                    desVC.result = result
                }
            default:
                return
            }
        }
    }
}
