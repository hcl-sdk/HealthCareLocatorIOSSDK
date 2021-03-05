//
//  SearchResultViewController.swift
//  HealthCareLocatorSDK
//
//  Created by Truong Le on 11/9/20.
//

import UIKit
import CoreLocation
import RxSwift

class SearchResultViewController: UIViewController, ViewDesign {
    enum ViewMode {
        case list
        case map
    }
    
    private let disposeBag = DisposeBag()
       
    var resultNavigationVC: UINavigationController!
    var data: SearchData?
    
    var result: [ActivityResult] = []
    
    var sort = SearchResultSortViewController.SortBy.relevance {
        didSet {
            sortResultBy(sort: sort)
        }
    }
    
    private var searchResultViewModel: SearchResultViewModel?
    
    var mode = ViewMode.list {
        didSet {
            if let viewModel = searchResultViewModel {
                viewModel.layout(view: self, theme: theme, mode: mode)
            }
        }
    }
    
    @IBOutlet weak var topLabelsWrapper: UIStackView!
    @IBOutlet weak var topInputWrapper: UIStackView!
    
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
    @IBOutlet weak var sortButtonBackground: BaseView!
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
        noResultWrapper.isHidden = true
        if let search = data {
            searchResultViewModel = SearchResultViewModel(webservices: HCLHCPSearchWebServices(manager: HCLServiceManager.shared),
                                                          search: search)
            layoutWith(theme: theme, icons: icons)
            layoutWith(searchData: search)
            setupSearchActionsBindding()
        }

        sort = .relevance
        
        // Initialize search
        performSearch()
    }
    
    
    private func setupSearchActionsBindding() {
        if let viewModel = searchResultViewModel {
            viewModel.resultByActionsObservable().subscribe(onNext: {[weak self] result in
                guard let strongSelf = self else {return}
                strongSelf.addressLabel.text = result.title
                strongSelf.handleSearch(result: result.result, zoomTo: (result.zoomTo ?? ActivityList(activities: result.result).getActivitiesCenter()))
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        }
    }
    
    private func performSearch() {
        searchResultViewModel?.showLoadingOn(view: bodyWrapper)
        searchResultViewModel?.performSearch(config: HCLManager.shared, completionHandler: {[weak self] (result, error) in
            guard let strongSelf = self else {return}
            let shouldMoveToCurrentLocation = strongSelf.data?.isNearMeSearch == true
            if shouldMoveToCurrentLocation {
                strongSelf.handleSearch(result: result, zoomTo: LocationManager.shared.currentLocation?.coordinate)
            } else {
                strongSelf.handleSearch(result: result, zoomTo: nil)
            }
        })
    }
    
    private func handleSearch(result: [ActivityResult]?, zoomTo: CLLocationCoordinate2D?) {
        if let result = result, result.count > 0 {
            noResultWrapper.isHidden = true
            self.result = result
            reloadWith(result: result)
            searchResultViewModel?.hideLoading()
            
            // Map zoom
            if let unwrap = zoomTo ?? (ActivityList(activities: result).getActivitiesCenter()) {
                let distance = ActivityList(activities: result).getFarestDistanceFrom(center: unwrap)
                for resultVC in resultNavigationVC.viewControllers {
                    if let resultMapVC = resultVC as? SearchResultMapViewController {
                        resultMapVC.defaultZoomTo(location: unwrap, distance: distance)
                        break
                    }
                }
            }
            
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
        searchResultViewModel?.layoutWith(view: self, searchData: searchData)
        // Display map by default if the user active near me search at home screen
        if mode == .map {
            // Add map view to stack as this mode require the map should be display first
            let viewMapVC = ViewControllers.viewControllerWith(identity: .searchResultMap) as! SearchResultMapViewController
            configResultMap(viewMapVC: viewMapVC)
            resultNavigationVC.pushViewController(viewMapVC, animated: false)
        }
    }
    
    func layoutWith(theme: HCLThemeConfigure, icons: HCLIconsConfigure) {
        searchResultViewModel?.layout(view: self, theme: theme, icons: icons)
    }

    @IBAction func onBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        performSegue(withIdentifier: "showSearchInputVC", sender: SearchData(criteria: nil,
                                                                             codes: nil,
                                                                             mode: .nearMeSearch))
    }
    
    @IBAction func listViewAction(_ sender: Any) {
        mode = .list
        if let resultListVC = resultNavigationVC.viewControllers.first as? SearchResultListViewController {
            resultListVC.result = result
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
        viewMapVC.searchData = data
        viewMapVC.mapDelegate = self
    }
    
    // MARK: - Navigation

    @IBAction func unwindToSearchResultViewController(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
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
                if let desVC = segue.destination as? HCPFullCardViewController,
                   let activity = sender as? ActivityResult {
                    desVC.activityID = activity.activity.id
                }
            case "showSearchInputVC":
                if let desVC = segue.destination as? SearchInputViewController,
                   let data = sender as? SearchData {
                    desVC.data = data
                }
            case "showNoResultVC":
                if let desVC = segue.destination as? NoSearchResultViewController {
                    noResultVC = desVC
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
                                                                                      mode: .nearMeSearch))
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
        searchResultViewModel?.perform(action: SearchResultViewModel.SearchAction(isNearMeSearch: false,
                                                                                  address: nil,
                                                                                  coordinate: location,
                                                                                  distance: kDefaultSearchAddressDistance,
                                                                                  country: nil))
    }
    
    func startNewNearMeSearchFrom(view: SearchResultMapViewController) {
        searchResultViewModel?.showLoadingOn(view: bodyWrapper)
        searchResultViewModel?.perform(action: SearchResultViewModel.SearchAction(isNearMeSearch: true,
                                                                                  address: nil,
                                                                                  coordinate: nil,
                                                                                  distance: kDefaultSearchNearMeDistance,
                                                                                  country: nil))
    }
}
