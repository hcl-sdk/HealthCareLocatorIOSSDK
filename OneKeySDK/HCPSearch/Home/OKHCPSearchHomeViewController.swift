//
//  OKHCPSearchHomeViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class OKHCPSearchHomeViewController: UIViewController, OKViewDesign {

    var theme: OKThemeConfigure?
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bodyContentWrapper: UIStackView!
    @IBOutlet weak var topSearchBtn: OKBaseView!
    @IBOutlet weak var bottomSearchBtn: OKBaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        if let theme = theme {
            layoutWith(theme: theme)
        }
    }

    func layoutWith(theme: OKThemeConfigure) {
        topSearchBtn.backgroundColor = theme.primaryColor
        bottomSearchBtn.backgroundColor = theme.primaryColor
        bottomSearchBtn.titleLabel?.font = theme.titleFont
        headerTitleLabel.font = theme.titleFont
        searchTextField.font = theme.defaultFont
        
        let HCPView = OKSearchTypeView(theme: theme,
                                       image: UIImage(named: "ic-search", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                       title: "Find and Locate other HCP",
                                       description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        bodyContentWrapper.addArrangedSubview(HCPView)
        
        let consultView = OKSearchTypeView(theme: theme,
                                           image: UIImage(named: "ic-person", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                           title: "Consult Profile",
                                           description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        bodyContentWrapper.addArrangedSubview(consultView)
        
        let informationView = OKSearchTypeView(theme: theme,
                                               image: UIImage(named: "ic-edit", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                               title: "Request my Information update",
                                               description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        bodyContentWrapper.addArrangedSubview(informationView)
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

extension OKHCPSearchHomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "showSearchInputVC", sender: nil)
    }
}
