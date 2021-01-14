//
//  SearchHomeViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit

class SearchHomeViewController: UIViewController, ViewDesign {

    var theme: OKThemeConfigure?
    var icons: OKIconsConfigure?

    private let viewModel = SearchHomeViewModel()
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var contentWrapperView: BaseView!
    @IBOutlet weak var searchTextFieldWrapper: BaseView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var bodyContentWrapper: UIStackView!
    @IBOutlet weak var topSearchBtn: BaseButton!
    @IBOutlet weak var bottomSearchBtn: BaseButton!
    
    private var isContentViewHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentScrollView.alpha = isContentViewHidden ? 0 : 1
        contentScrollView.isUserInteractionEnabled = !isContentViewHidden

        searchTextField.delegate = self
        if let theme = theme {
            layoutWith(theme: theme, icons: icons ?? OKIconsConfigure())
        }
        
        layoutWith(traitCollection: traitCollection)
    }

    func layoutWith(theme: OKThemeConfigure) {
        layoutWith(theme: theme, icons: OKIconsConfigure())
    }
    
    func layoutWith(theme: OKThemeConfigure, icons: OKIconsConfigure) {
        viewModel.layout(view: self, with: theme, icons: icons)
    }
    
    func hideBodyView(isHidden: Bool) {
        isContentViewHidden = isHidden
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "showSearchInputVC", sender: searchTextField.text)
    }
    
    // MARK: - Navigation

    @IBAction func unwindToSearchHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    private func layoutWith(traitCollection: UITraitCollection) {
        viewModel.layout(view: self, with: traitCollection)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "showSearchInputVC":
                if let desVC = segue.destination as? SearchInputViewController {
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

extension SearchHomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "showSearchInputVC", sender: nil)
    }
}
