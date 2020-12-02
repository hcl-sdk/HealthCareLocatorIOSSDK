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
    
    var backgroundView: UIView = UIView()
    
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
            nibView.translatesAutoresizingMaskIntoConstraints = false
            
            backgroundView.addSubview(nibView)
            backgroundView.backgroundColor = UIColor.clear
            backgroundView.addConstraints([NSLayoutConstraint(item: nibView, attribute: .top, relatedBy: .equal, toItem: backgroundView, attribute: .top, multiplier: 1, constant: 8),
                                           NSLayoutConstraint(item: nibView, attribute: .left, relatedBy: .equal, toItem: backgroundView, attribute: .left, multiplier: 1, constant: 8),
                                           NSLayoutConstraint(item: nibView, attribute: .bottom, relatedBy: .equal, toItem: backgroundView, attribute: .bottom, multiplier: 1, constant: -8),
                                           NSLayoutConstraint(item: nibView, attribute: .right, relatedBy: .equal, toItem: backgroundView, attribute: .right, multiplier: 1, constant: -8)])
            addArrangedSubview(backgroundView)
        }
    }
    
    func configWith(theme: OKThemeConfigure, image: UIImage?, title: String, description: String) {
        iconBgView.backgroundColor = theme.primaryColor.withAlphaComponent(0.2)
        icon.image = image
        icon.tintColor = theme.primaryColor
        titleLabel.font = theme.defaultFont
        titleLabel.text = title
        descriptionLabel.font = theme.defaultFont
        descriptionLabel.text = description
    }
    
    func layoutWith(traitCollection: UITraitCollection) {
        switch traitCollection.verticalSizeClass {
        case .regular:
            // Hide border
            backgroundView.setBorderWith(width: 0, cornerRadius: 8, borderColor: .clear)
        default:
            backgroundView.setBorderWith(width: 1, cornerRadius: 8, borderColor: .lightGray)
        }
    }
}
