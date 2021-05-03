//
//  ViewController.swift
//  HealthCareLocatorSDKDemo
//
//  Created by Truong Le on 11/6/20.
//

import UIKit
import Lottie
import HealthCareLocatorSDK

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buggerMenuAnimationView: AnimationView!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var homeWrapper: UIView!
    
    var homeNavigationController: UINavigationController!
    
    var isMenuShowing = false {
        didSet {
            let from: AnimationProgressTime = isMenuShowing ? 0 : 1
            let to: AnimationProgressTime = isMenuShowing ? 1 : 0
            buggerMenuAnimationView.play(fromProgress: from, toProgress: to, loopMode: .none, completion: nil)
            animateMenuTable(isShow: isMenuShowing == true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "HealthCareLocator Demo Home"
        configBuggerMenu(menu: buggerMenuAnimationView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeNavigationController.popToRootViewController(animated: true)
    }
    
    private func configBuggerMenu(menu: AnimationView) {
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.clipsToBounds = false
        let animation = Animation.named("burger-menu")
        menu.animation = animation
        menu.animationSpeed = 2.0
    }
    
    private func animateMenuTable(isShow: Bool) -> Void {
        UIView.animate(withDuration: 0.2) {
            self.homeWrapper.alpha = isShow ? 0 : 1
            self.menuContainer.alpha = isShow ? 1 : 0
            self.menuContainer.isUserInteractionEnabled = isShow
        }
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        isMenuShowing = !isMenuShowing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EmbedMenuTableView":
                if let menuVC = segue.destination as? MenuTableViewController {
                    menuVC.delegate = self
                    menuVC.menus = [MenuSection(title: nil, menus: Menu.allMainMenus)]
                }
            case "embedHomeNavigationVC":
                if let desVC = segue.destination as? UINavigationController {
                    homeNavigationController = desVC
                }
            default:
                return
            }
        }
    }
}

extension HomeViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        isMenuShowing = false
        switch menu {
        case .textMenu(let title, _):
            switch title {
            case kMenuHomeTitle:
                homeNavigationController.popToRootViewController(animated: true)
            case kMenuNewSearchTitle:
                handleStartNewSearch(config: HCLSearchConfigure(country: AppSettings.countries))
            case kMenuFindDentistNearMeTitle:
                startQuickDentistSearch()
            case kMenuFindCardiologistNearMeTitle:
                startQuickCardilogySearch()
           case kMenuSettingsTitle:
                showSettingsScreen()
            default:
                return
            }
        default:
            return
        }
    }
    
    private func handleStartNewSearch(config: HCLSearchConfigure? = nil) {
        if let searchVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            searchVC.config = config
            isMenuShowing = false
            if let index = homeNavigationController.viewControllers.firstIndex(where: { (vc) -> Bool in
                return vc is SearchViewController
            }) {
                homeNavigationController.setViewControllers([homeNavigationController.viewControllers.first!, searchVC], animated: true)
            } else {
                homeNavigationController.pushViewController(searchVC, animated: true)
            }
        }
    }
    
    private func showSettingsScreen() {
        buggerMenuAnimationView.stop()
        performSegue(withIdentifier: "showSettingsVC", sender: nil)
    }
    
    private func startQuickCardilogySearch() {
        handleStartNewSearch(config: HCLSearchConfigure(entry: .nearMe, speciality: "1SP.0800", country: AppSettings.countries))
    }
    
    private func startQuickDentistSearch() {
        handleStartNewSearch(config: HCLSearchConfigure(entry: .nearMe, speciality: "1SP.7500", country: AppSettings.countries))
    }
    
    @IBAction func unwindToHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
