//
//  OkSegmentControlItem.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/17/20.
//

import UIKit

class OkSegmentControlItem: UIView {

    var index: Int = 0
    
    var item: OkSegmentControlModel = OkSegmentControlModel(icon: nil,
                                                            title: "Item",
                                                            selectedBackgroundColor: UIColor.green,
                                                            selectedForcegroundColor: UIColor.white,
                                                            nonSelectedBackgroundColor: UIColor.white,
                                                            nonSelectedForcegroundColor: UIColor.darkGray) {
        didSet {
            configWith(item: item, index: index, selected: selected)
        }
    }
    
    var selected: Bool = false {
        didSet {
            configWith(item: item, index: index, selected: selected)
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    init(item: OkSegmentControlModel, index: Int, selected: Bool) {
        super.init(frame: CGRect.zero)
        initialize()
        self.item = item
        self.selected = selected
        configWith(item: item, index: index, selected: selected)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = bounds.height/2.0
    }
    
    private func initialize() {
        if let nibView = Bundle.internalBundle().loadNibNamed("OkSegmentControlItem", owner: self, options: nil)?.first as? UIView {
            nibView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(nibView)
            addConstraints([NSLayoutConstraint(item: nibView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
                            NSLayoutConstraint(item: nibView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
                            NSLayoutConstraint(item: nibView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
                            NSLayoutConstraint(item: nibView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)])
        }
    }
    
    func configWith(item: OkSegmentControlModel, index: Int, selected: Bool) {
        self.index = index
        titleLabel.text = item.title
        titleLabel.textColor = selected ? item.selectedForcegroundColor : item.nonSelectedForcegroundColor
        bgView.backgroundColor = selected ? item.selectedBackgroundColor : UIColor.clear
        icon.tintColor = selected ? item.selectedForcegroundColor : item.nonSelectedForcegroundColor
        icon.image = item.icon
        icon.isHidden = item.icon == nil
    }
}
