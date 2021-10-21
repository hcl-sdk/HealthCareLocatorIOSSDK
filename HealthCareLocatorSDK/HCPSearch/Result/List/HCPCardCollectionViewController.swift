//
//  HCPCardCollectionViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/18/20.
//

import UIKit

private let reuseIdentifier = "HCPCard"

class HCPCardCollectionViewController: UICollectionViewController, ViewDesign, ActivityListHandler {
    
    weak var delegate: ActivityHandler?
    
    var selectedIndexs: [Int]? {
        didSet {
            if isViewLoaded {
                collectionView.reloadData()
            }
        }
    }
    
    var result: [ActivityResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return result.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier, for: indexPath) as? HCPCardCollectionViewCell
        else {
            return .init()
        }
        cell.configWith(theme: theme, icons: icons, item: result[indexPath.row],
                        selected: selectedIndexs?.contains(indexPath.row) == true)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(activity: result[indexPath.row])
    }
}

extension HCPCardCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 311, height: 112)
    }
}

extension HCPCardCollectionViewController: SortableResultList {
    
    func reloadWith(data: [ActivityResult]) {
        result = data
        collectionView.reloadData()
    }
}
