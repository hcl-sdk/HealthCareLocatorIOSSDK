//
//  OKHCPSearchHomeViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class OKHCPSearchHomeViewController: UIViewController, OKViewDesign {
    
    func config(theme: OKThemeConfigure) {
        self.theme = theme
    }
    
    var theme: OKThemeConfigure?
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bodyContentWrapper: UIStackView!
    @IBOutlet weak var topSearchBtn: OKBaseView!
    @IBOutlet weak var bottomSearchBtn: OKBaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theme = theme {
            layoutViewWith(theme: theme)
        }
    }

    private func layoutViewWith(theme: OKThemeConfigure) {
        headerTitleLabel.text = theme.HCPThemeConfigure.titleText
        topSearchBtn.backgroundColor = theme.primaryColor
        bottomSearchBtn.backgroundColor = theme.primaryColor

        if let HCP = theme.HCPThemeConfigure.HCPSearch {
            let HCPView = OKSearchTypeView(theme: HCP, primaryColor: theme.primaryColor, secondaryColor: theme.secondaryColor)
            bodyContentWrapper.addArrangedSubview(HCPView)
        }
        
        if let consult = theme.HCPThemeConfigure.consultSearch {
            let HCPView = OKSearchTypeView(theme: consult, primaryColor: theme.primaryColor, secondaryColor: theme.secondaryColor)
            bodyContentWrapper.addArrangedSubview(HCPView)
        }
        
        if let information = theme.HCPThemeConfigure.informationUpdate {
            let HCPView = OKSearchTypeView(theme: information, primaryColor: theme.primaryColor, secondaryColor: theme.secondaryColor)
            bodyContentWrapper.addArrangedSubview(HCPView)
        }
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "showSearchInputVC", sender: searchTextField.text)
    }
    
    // MARK: - Navigation

    @IBAction func unwindToOKHCPSearchHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSearchInputVC":
                break
            default:
                return
            }
        }
    }
}
