//
//  OKHCPSearchHomeViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class OKHCPSearchHomeViewController: UIViewController, OKViewDesign {

    var theme: OKThemeConfigure?
    
    @IBOutlet weak var contentWrapperView: OKBaseView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bodyContentWrapper: UIStackView!
    @IBOutlet weak var topSearchBtn: OKBaseButton!
    @IBOutlet weak var bottomSearchBtn: OKBaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        headerTitleLabel.text = "search.home.introduce_title".localized(lang: OKManager.shared.lang)
        
        if let theme = theme {
            layoutWith(theme: theme)
        }
        
        layoutWith(traitCollection: traitCollection)
    }

    func layoutWith(theme: OKThemeConfigure) {
        // Colors
        view.backgroundColor = theme.viewBkgColor
        searchTextField.textColor = theme.darkColor
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Find Healthcare Professional",
                                                                   attributes: [NSAttributedString.Key.foregroundColor : theme.greyLightColor ?? .lightGray])
        contentWrapperView.borderColor = theme.cardBorderColor
        headerTitleLabel.textColor = theme.secondaryColor
        bottomSearchBtn.backgroundColor = theme.primaryColor
        topSearchBtn.backgroundColor = theme.primaryColor

        // Fonts
        headerTitleLabel.font = theme.titleMainFont
        searchTextField.font = theme.searchInputFont
        bottomSearchBtn.titleLabel?.font = theme.defaultFont
        
        //
        for subView in bodyContentWrapper.arrangedSubviews {
            subView.removeFromSuperview()
            bodyContentWrapper.removeArrangedSubview(subView)
        }
        
        let HCPView = OKSearchTypeView(theme: theme,
                                       image: UIImage(named: "magnifier", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                       title: "Find and Locate HCP",
                                       description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        bodyContentWrapper.addArrangedSubview(HCPView)
        
        let consultView = OKSearchTypeView(theme: theme,
                                           image: UIImage(named: "profile", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                           title: "Consult HCP's Profile",
                                           description: "Lorem ipsum dolor sit amet, consect adipiscing elit")
        bodyContentWrapper.addArrangedSubview(consultView)
        
        let informationView = OKSearchTypeView(theme: theme,
                                               image: UIImage(named: "edit", in: Bundle.internalBundle(), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate),
                                               title: "Request HCP's information update",
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
    
    private func layoutWith(traitCollection: UITraitCollection) {
        for subview in bodyContentWrapper.arrangedSubviews {
            if let searchTypeView = subview as? OKSearchTypeView {
                searchTypeView.layoutWith(traitCollection: traitCollection)
            }
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSearchInputVC":
                if let desVC = segue.destination as? OKHCPSearchInputViewController {
                    desVC.theme = theme
                }
            default:
                return
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layoutWith(traitCollection: traitCollection)
    }
}

extension OKHCPSearchHomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "showSearchInputVC", sender: nil)
    }
}
