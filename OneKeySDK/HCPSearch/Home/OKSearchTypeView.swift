//
//  OKSearchTypeView.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/11/20.
//

import UIKit

class OKSearchTypeView: UIStackView {
    
    @IBOutlet weak var iconBgView: OKBaseView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    init(theme: OKIconTitleConfigure, primaryColor: UIColor, secondaryColor: UIColor) {
        super.init(frame: CGRect.zero)
        initialize()
        configWith(theme: theme, primaryColor: primaryColor, secondaryColor: secondaryColor)
    }
    
    private func initialize() {
        distribution = .fill
        alignment = .fill
        axis = .vertical
        if let nibView = Bundle.internalBundle().loadNibNamed("OKSearchTypeView", owner: self, options: nil)?.first as? UIView {
            addArrangedSubview(nibView)
        }
    }
    
    func configWith(theme: OKIconTitleConfigure, primaryColor: UIColor, secondaryColor: UIColor) {
        iconBgView.backgroundColor = secondaryColor
        icon.image = theme.image
        icon.tintColor = primaryColor
        titleLabel.text = theme.titleText
        descriptionLabel.text = theme.descriptionText
    }
}
