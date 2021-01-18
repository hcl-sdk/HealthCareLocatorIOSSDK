//
//  SearchResultViewController.swift
//  OneKeySDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import CoreLocation

class SearchResultViewController: UIViewController, ViewDesign {
    enum ViewMode {
        case list
        case map
    }
    
    var theme: OKThemeConfigure?
    var shouldHideBackButton = false
    
    var resultNavigationVC: UINavigationController!
    var data: SearchData?
    
    var result: [ActivityResult] = []
    
    var sort = SearchResultSortViewController.SortBy.relevance {
        didSet {
            sortResultBy(sort: sort)
        }
    }
    
    private var searchResultViewModel: SearchResultViewModel?
    
    private var mode = ViewMode.list {
        didSet {
            if let viewModel = searchResultViewModel {
                viewModel.layout(view: self, theme: theme ?? OKThemeConfigure(), mode: mode)
            }
        }
    }
    
    @IBOutlet weak var topLabelsWrapper: UIStackView!
    @IBOutlet weak var topInputWrapper: UIStackView!
    @IBOutlet weak var topInputMarginLeftView: UIView!
    
    @IBOutlet weak var topInputTextField: UITextField!
    @IBOutlet weak var searchButton: BaseButton!
    
    @IBOutlet weak var bodyWrapper: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var firstSeparatorView: UIView!
    @IBOutlet weak var secondSeparatorView: UIView!
    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var activityCountLabel: UILabel!
    @IBOutlet weak var sortButtonWrapper: BaseView!
    @IBOutlet weak var sortButton: UIButton!
    
    // Result mode List
    @IBOutlet weak var selectedListViewBackgroundView: BaseView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var listLabel: UILabel!
    
    // Result mode Map
    @IBOutlet weak var selectedMapViewBackgroundView: BaseView!
    @IBOutlet weak var mapIcon: UIImageView!
    @IBOutlet weak var mapLabel: UILabel!
    
    @IBOutlet weak var noResultWrapper: UIView!
    private var noResultVC: NoSearchResultViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        topInputTextField.delegate = self
        backButton.isHidden = shouldHideBackButton
        topInputMarginLeftView.isHidden = !shouldHideBackButton
        noResultWrapper.isHidden = true
        
        if let search = data {
            searchResultViewModel = SearchResultViewModel(webservices: OKHCPSearchWebServices(manager: OKServiceManager.shared),
                                                          search: search)
            layoutWith(searchData: search)
        }

        sort = .relevance
        
        // Initialize search
        performSearch()
    }
    
    private func performSearch() {
        searchResultViewModel?.showLoadingOn(view: bodyWrapper)
        searchResultViewModel?.performSearch(config: OKManager.shared, completionHandler: {[weak self] (result, error) in
            guard let strongSelf = self else {return}
            strongSelf.handleSearch(result: result)
            // Move map to the suitable coordinate base on search action (normal, near me, quick near me)
            let shouldMoveToCurrentLocation = (strongSelf.data?.isNearMeSearch == true || strongSelf.data?.isQuickNearMeSearch == true)
            for resultVC in strongSelf.resultNavigationVC.viewControllers {
                if let resultMapVC = resultVC as? SearchResultMapViewController {
                    if shouldMoveToCurrentLocation {
                        if let currentLocation = LocationManager.shared.currentLocation {
                            resultMapVC.defaultZoomTo(location: currentLocation.coordinate)
                        }
                    } else if let location = result?.first(where: {$0.activity.workplace.address.location != nil})?.activity.workplace.address.location {
                        resultMapVC.defaultZoomTo(location: CLLocationCoordinate2DMake(location.lat, location.lon))
                    }
                    return
                }
            }
        })
    }
    
    private func handleSearch(result: [ActivityResult]?) {
        if let result = result, result.count > 0 {
            noResultWrapper.isHidden = true
            self.result = result
            reloadWith(result: result)
            searchResultViewModel?.hideLoading()
        } else {
            noResultWrapper.isHidden = false
        }
    }
    
    func reloadWith(result: [ActivityResult]) {
        activityCountLabel.text = "\(result.count)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let strongSelf = self else {return}
            for resultChildVC in strongSelf.resultNavigationVC.viewControllers {
                if let resultVC = resultChildVC as? SortableResultList {
                    resultVC.reloadWith(data: result)
                }
            }
        }
    }
    
    func layoutWith(searchData: SearchData) {
        criteriaLabel.text = searchData.codes?.first?.longLbl ?? searchData.criteria
        if searchData.isQuickNearMeSearch == true  {
            topInputWrapper.isHidden = false
            topLabelsWrapper.isHidden = true
        } else {
            topInputWrapper.isHidden = true
            topLabelsWrapper.isHidden = false
        }
        
        mode = (searchData.isNearMeSearch == true || searchData.isQuickNearMeSearch == true) ? .map : .list
        
        // Display map by default if the user active near me search at home screen
        if mode == .map {
            addressLabel.text = kNearMeTitle
            // Add map view to stack as this mode require the map should be display first
            let viewMapVC = ViewControllers.viewControllerWith(identity: .searchResultMap) as! SearchResultMapViewController
            configResultMap(viewMapVC: viewMapVC)
            resultNavigationVC.pushViewController(viewMapVC, animated: false)
        } else {
            addressLabel.text = searchData.address
        }
    }
    
    func layoutWith(theme: OKThemeConfigure) {
        searchResultViewModel?.layout(view: self, theme: theme)
    }

    @IBAction func onBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "showSearchInputVC", sender: SearchData(criteria: nil,
                                                                                  codes: nil,
                                                                                  address: nil,
                                                                                  isNearMeSearch: true,
                                                                                  isQuickNearMeSearch: true))
    }
    
    @IBAction func listViewAction(_ sender: Any) {
        mode = .list
        if let resultListVC = resultNavigationVC.viewControllers.first as? SearchResultListViewController {
            resultListVC.result = result
            resultListVC.theme = theme
            resultNavigationVC.popToViewController(resultListVC, animated: true)
        }
    }
    
    @IBAction func mapViewAction(_ sender: Any) {
        mode = .map
        if let viewMapVC = ViewControllers.viewControllerWith(identity: .searchResultMap) as? SearchResultMapViewController {
            configResultMap(viewMapVC: viewMapVC)
            resultNavigationVC.pushViewController(viewMapVC, animated: true)
        }
    }
    
    func sortResultBy(sort: SearchResultSortViewController.SortBy) {
        searchResultViewModel?.sortResultBy(sort: sort, result: result, {[weak self] (sortedResult) in
            guard let strongSelf = self else {return}
            strongSelf.result = sortedResult
            strongSelf.reloadWith(result: sortedResult)
        })
    }
    
    private func configResultMap(viewMapVC: SearchResultMapViewController) {
        viewMapVC.result = result
        viewMapVC.theme = theme
        viewMapVC.searchData = data
        viewMapVC.mapDelegate = self
    }
    
    // MARK: - Navigation

    @IBAction func unwindToSearchResultViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "embedResultNavicationVC":
                if let desVC = segue.destination as? UINavigationController {
                    resultNavigationVC = desVC
                    resultNavigationVC.delegate = self
                }
            case "showResultSortVC":
                if let desVC = segue.destination as? SearchResultSortViewController {
                    desVC.sort = sort
                }
            case "showFullCardVC":
                if let desVC = segue.destination as? HCPFullCardViewController {
                    desVC.theme = theme
                    if let activity = sender as? ActivityResult {
                        desVC.activityID = activity.activity.id
                    }
                }
            case "showSearchInputVC":
                if let desVC = segue.destination as? SearchInputViewController {
                    desVC.theme = theme
                    if let data = sender as? SearchData {
                        desVC.data = data
                    }
                }
            case "showNoResultVC":
                if let desVC = segue.destination as? NoSearchResultViewController {
                    noResultVC = desVC
                    desVC.theme = theme
                    desVC.delegate = self
                }
            default:
                return
            }
        }
    }

}

extension SearchResultViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let designAbleVC = viewController as? ViewDesign {
            var editableVC = designAbleVC
            editableVC.theme = theme
            if let theme = theme {
                editableVC.layoutWith(theme: theme)
            }
        }
        
        if let activityListHandler = viewController as? ActivityListHandler {
            var editableVC = activityListHandler
            editableVC.delegate = self
        }
    }
}

extension SearchResultViewController: ActivityHandler {
    func didSelect(activity: ActivityResult) {
        performSegue(withIdentifier: "showFullCardVC", sender: activity)
    }
}

extension SearchResultViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == topInputTextField {
            performSegue(withIdentifier: "showSearchInputVC", sender: SearchData(criteria: nil,
                                                                                      codes: nil,
                                                                                      address: nil,
                                                                                      isNearMeSearch: true,
                                                                                      isQuickNearMeSearch: true))
        }
    }
}

extension SearchResultViewController: NoSearchResultViewControllerDelegate {
    func shouldStartANewSearch() {
        guard let navigationController = self.navigationController else {return}
        for viewController in navigationController.viewControllers {
            if viewController is SearchInputViewController {
                navigationController.popToViewController(viewController, animated: true)
                return
            }
        }
        performSegue(withIdentifier: "showSearchInputVC", sender: data)
    }
}

extension SearchResultViewController: SearchResultMapViewControllerDelegate {
    func startNewSearchWith(location: CLLocationCoordinate2D, from view: SearchResultMapViewController) {
        searchResultViewModel?.showLoadingOn(view: bodyWrapper)
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location.latitude,
                                                       longitude: location.longitude)) {[weak self] (places, error) in
            guard let strongSelf = self else {return}
            if let place = places?.first {
                strongSelf.addressLabel.text = place.name
            }
        }
        searchResultViewModel?.performSearchWith(config: OKManager.shared,
                                                 coordinate: location,
                                                 completionHandler: {[weak self] (result, error) in
                                                    guard let strongSelf = self else {return}
                                                    strongSelf.handleSearch(result: result)
                                                 })
    }
    
    func startNewNearMeSearchWith(location: CLLocationCoordinate2D, from view: SearchResultMapViewController) {
        searchResultViewModel?.showLoadingOn(view: bodyWrapper)
        addressLabel.text = kNearMeTitle
        searchResultViewModel?.performSearchWith(config: OKManager.shared,
                                                 coordinate: location,
                                                 completionHandler: {[weak self] (result, error) in
                                                    guard let strongSelf = self else {return}
                                                    strongSelf.handleSearch(result: result)
                                                 })
    }
}
