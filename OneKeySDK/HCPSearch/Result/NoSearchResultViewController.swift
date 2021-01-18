//
//  NoSearchResultViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 1/18/21.
//

import UIKit

protocol NoSearchResultViewControllerDelegate {
    func shouldStartANewSearch()
}

class NoSearchResultViewController: UIViewController, ViewDesign {
    var theme: OKThemeConfigure?
    
    @IBOutlet weak var wrapper: BaseView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var imageViewWrapper: BaseView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var startNewSearchButton: BaseButton!
    
    var delegate: NoSearchResultViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTitleLabel.text = "onekey_sdk_no_result_found".localized
        descLabel.text = "onekey_sdk_no_result_message".localized
        startNewSearchButton.setTitle("onekey_sdk_start_new_search".localized, for: .normal)
        
        if let theme = theme {
            layoutWith(theme: theme)
        }
    }
    
    func layoutWith(theme: OKThemeConfigure) {

        // Fonts
        topTitleLabel.font = theme.noResultTitleFont
        descLabel.font = theme.noResultDescFont
        startNewSearchButton.titleLabel?.font = theme.defaultFont
        
        // Colors
        view.backgroundColor = theme.viewBkgColor
        wrapper.borderColor = theme.cardBorderColor
        imageViewWrapper.borderColor = theme.greyLightColor
        topTitleLabel.textColor = theme.secondaryColor
        descLabel.textColor = theme.darkColor
        searchImageView.tintColor = theme.greyLightColor
        startNewSearchButton.setTitleColor(.white, for: .normal)
        startNewSearchButton.backgroundColor = theme.primaryColor
    }
    
    @IBAction func startNewSearchAction(_ sender: Any) {
        delegate?.shouldStartANewSearch()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
