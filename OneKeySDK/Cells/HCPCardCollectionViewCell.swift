//
//  HCPCardCollectionViewCell.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit

class HCPCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapper: OKBaseView!
    @IBOutlet weak var drLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    func configWith(theme: OKThemeConfigure?, item: Activity, selected: Bool) {
        wrapper.setBorderWith(width: selected ? 2 : 0,
                              cornerRadius: 8,
                              borderColor: selected ? (theme?.selectedMarkerColor ?? UIColor.red) : UIColor.clear )
        
        // Fonts
        drLabel.font = theme?.defaultFont
        categoryLabel.font = theme?.defaultFont
        addressLabel.font = theme?.defaultFont
        distanceLabel.font = theme?.defaultFont
        
        // Colors
        drLabel.textColor = theme?.primaryColor
        drLabel.text = item.title.label
        categoryLabel.text = item.workplace.name
        addressLabel.text = item.workplace.address.longLabel
        distanceLabel.text = "500m"
    }
}
