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
    
    init(theme: OKThemeConfigure, image: UIImage?, title: String, description: String) {
        super.init(frame: CGRect.zero)
        initialize()
        configWith(theme: theme, image: image, title: title, description: description)
    }
    
    private func initialize() {
        distribution = .fill
        alignment = .fill
        axis = .vertical
        if let nibView = Bundle.internalBundle().loadNibNamed("OKSearchTypeView", owner: self, options: nil)?.first as? UIView {
            addArrangedSubview(nibView)
        }
    }
    
    func configWith(theme: OKThemeConfigure, image: UIImage?, title: String, description: String) {
        iconBgView.backgroundColor = theme.secondaryColor
        icon.image = image
        icon.tintColor = theme.primaryColor
        titleLabel.font = theme.titleFont
        titleLabel.text = title
        descriptionLabel.font = theme.defaultFont
        descriptionLabel.text = description
    }
}
