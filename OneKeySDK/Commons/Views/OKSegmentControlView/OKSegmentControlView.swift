//
//  OKSegmentControlView.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/17/20.
//

import UIKit

@IBDesignable
class OKSegmentControlView: UIView {
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.gray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBOutlet var wrapperStackView: UIStackView!
    
    var items: [OkSegmentControlModel] = [] {
        didSet {
            layoutWith(items: items, selectedIndex: selectedIndex)
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            layoutWith(items: items, selectedIndex: selectedIndex)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2.0
    }
    
    init(items: [OkSegmentControlModel], selectedIndex: Int) {
        super.init(frame: CGRect.zero)
        initialize()
        self.items = items
        self.selectedIndex = selectedIndex
    }
    
    private func initialize() {
        if let nibView = Bundle.internalBundle().loadNibNamed("OKSegmentControlView", owner: self, options: nil)?.first as? UIStackView {
            nibView.distribution = .fillEqually
            nibView.alignment = .fill
            nibView.axis = .horizontal
            nibView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(nibView)
            addConstraints([NSLayoutConstraint(item: nibView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 2),
                            NSLayoutConstraint(item: nibView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 2),
                            NSLayoutConstraint(item: nibView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -2),
                            NSLayoutConstraint(item: nibView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
            wrapperStackView = nibView
        }
    }
    
    private func layoutWith(items: [OkSegmentControlModel], selectedIndex: Int) {
        // Clean sub views
        for subView in wrapperStackView.arrangedSubviews {
            wrapperStackView.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
        
        for (index, item) in items.enumerated() {
            wrapperStackView.addArrangedSubview(OkSegmentControlItem(item: item,
                                                                     index: index,
                                                                     selected: index == selectedIndex))
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
}
