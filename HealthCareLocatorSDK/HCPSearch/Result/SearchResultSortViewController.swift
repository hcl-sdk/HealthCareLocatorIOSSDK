//
//  SearchResultSortViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/25/20.
//

import UIKit

class SearchResultSortViewController: UIViewController {
    //
    enum SortBy: Int {
        case distance
        case lastName
    }
    
    var sort = SortBy.lastName {
        didSet {
            if isViewLoaded {
                layoutWith(sort: sort)
            }
        }
    }
    
    @IBOutlet weak var wrapperView: BaseView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var relevanceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var resetButton: BaseButton!
    @IBOutlet weak var applyButton: BaseButton!
    @IBOutlet weak var relevenceBackground: BaseView!
    @IBOutlet weak var distanceBackground: BaseView!
    @IBOutlet weak var nameBackground: BaseView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutWith(theme: theme, icons: icons)
    }
    
    private func layoutWith(sort: SortBy) {
        switch sort {
        case .distance:
            relevenceBackground.backgroundColor = .white
            distanceBackground.backgroundColor = theme.primaryColor
            nameBackground.backgroundColor = .white
        case .lastName:
            relevenceBackground.backgroundColor = .white
            distanceBackground.backgroundColor = .white
            nameBackground.backgroundColor = theme.primaryColor
        }
    }
    
    @IBAction func didSelectRelevaneSort(_ sender: Any) {
        
    }
    
    @IBAction func didSelectDistanceSort(_ sender: Any) {
        sort = .distance
    }
    
    @IBAction func didSelectNameSort(_ sender: Any) {
        sort = .lastName
    }
    
    @IBAction func resetAction(_ sender: Any) {
        sort = .lastName
    }
    
    @IBAction func applyAction(_ sender: Any) {
        performSegue(withIdentifier: "backToSearchResultVC", sender: sort)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "backToSearchResultVC" {
            if let resultVC = segue.destination as? SearchResultViewController,
               let sort = sender as? SortBy {
                resultVC.sort = sort
            }
        }
    }
}

extension SearchResultSortViewController: ViewDesign {

    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        topLabel.text = "hcl_sort_label".localized
        distanceLabel.text = "hcl_distance_item".localized
        nameLabel.text = "Last name".localized
        resetButton.setTitle("hcl_reset_button".localized, for: .normal)
        applyButton.setTitle("hcl_apply_button".localized, for: .normal)
        
        resetButton.titleLabel?.font = theme.buttonFont
        applyButton.titleLabel?.font = theme.buttonFont
        topLabel.font = theme.modalTitleFont
        distanceLabel.font = theme.sortCriteriaFont
        nameLabel.font = theme.sortCriteriaFont
        
        // Icons
        closeButton.setImage(icons.crossIcon, for: .normal)
        
        // Colors
        view.backgroundColor = theme.darkmode ? kDarkColor : theme.viewBkgColor
        wrapperView.backgroundColor = theme.darkmode ? kDarkLightColor : .white
        topLabel.textColor = theme.secondaryColor
        closeButton.tintColor = theme.greyDarkColor
        relevenceBackground.borderColor = theme.greyLighterColor
        distanceBackground.borderColor = theme.greyLighterColor
        nameBackground.borderColor = theme.greyLighterColor
        relevenceBackground.borderColor = theme.greyLighterColor
        distanceBackground.borderColor = theme.greyLighterColor
        nameBackground.borderColor = theme.greyLighterColor
        applyButton.backgroundColor = theme.buttonAcceptBkgColor
        resetButton.backgroundColor = theme.buttonDiscardBkgColor
        separatorView.backgroundColor = theme.greyLighterColor
        wrapperView.borderColor = theme.cardBorderColor

        layoutWith(sort: sort)
    }
}
