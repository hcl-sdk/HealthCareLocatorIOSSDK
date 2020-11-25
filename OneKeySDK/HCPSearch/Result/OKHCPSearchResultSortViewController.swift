//
//  OKHCPSearchResultSortViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/25/20.
//

import UIKit

class OKHCPSearchResultSortViewController: UIViewController {
    //
    enum SortBy: Int {
        case relevance
        case distance
        case name
    }
    
    var sort = SortBy.name {
        didSet {
            if isViewLoaded {
                layoutWith(sort: sort)
            }
        }
    }
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var relevanceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var relevanceBtn: UIButton!
    @IBOutlet weak var distanceBtn: UIButton!
    @IBOutlet weak var nameBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutWith(sort: sort)
    }
    
    private func layoutWith(sort: SortBy) {
        switch sort {
        case .distance:
            distanceBtn.setImage(UIImage.OKImageWith(name: "ic-checked"), for: .normal)
            nameBtn.setImage(UIImage.OKImageWith(name: "ic-uncheck"), for: .normal)
            relevanceBtn.setImage(UIImage.OKImageWith(name: "ic-uncheck"), for: .normal)
        case .name:
            distanceBtn.setImage(UIImage.OKImageWith(name: "ic-uncheck"), for: .normal)
            nameBtn.setImage(UIImage.OKImageWith(name: "ic-checked"), for: .normal)
            relevanceBtn.setImage(UIImage.OKImageWith(name: "ic-uncheck"), for: .normal)
        case .relevance:
            distanceBtn.setImage(UIImage.OKImageWith(name: "ic-uncheck"), for: .normal)
            nameBtn.setImage(UIImage.OKImageWith(name: "ic-uncheck"), for: .normal)
            relevanceBtn.setImage(UIImage.OKImageWith(name: "ic-checked"), for: .normal)
        }
    }

    @IBAction func didSelect(_ sender: UIButton) {
        switch sender {
        case nameBtn:
            sort = .name
        case relevanceBtn:
            sort = .relevance
        case distanceBtn:
            sort = .distance
        default:
            return
        }
    }
    
    @IBAction func resetAction(_ sender: Any) {
    }
    
    @IBAction func applyAction(_ sender: Any) {
        performSegue(withIdentifier: "backToSearchResultVC", sender: sort)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "backToSearchResultVC" {
            if let resultVC = segue.destination as? OKHCPSearchResultViewController,
               let sort = sender as? SortBy {
                resultVC.sort = sort
            }
        }
    }

}
