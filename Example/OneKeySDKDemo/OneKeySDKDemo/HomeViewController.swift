//
//  ViewController.swift
//  OneKeySDKDemo
//
//  Created by Truong Le on 11/6/20.
//

import UIKit
import Lottie

class HomeViewController: UIViewController {
    
    @IBOutlet weak var buggerMenuAnimationView: AnimationView!
    @IBOutlet weak var menuContainer: UIView!
    @IBOutlet weak var introduceWrapper: UIStackView!
    
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
        navigationController?.navigationBar.topItem?.title = "OneKey Demo Home"
        configBuggerMenu(menu: buggerMenuAnimationView)
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
            self.introduceWrapper.alpha = isShow ? 0 : 1
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
            default:
                return
            }
        }
    }
}

extension HomeViewController: MenuTableViewControllerDelegate {
    func didSelect(menu: Menu) {
        switch menu {
        case .textMenu(let title, _):
            switch title {
            case "New Search":
                handleStartNewSearch()
            case "Settings":
                showSettingsScreen()
            default:
                return
            }
        default:
            return
        }
    }
    
    private func handleStartNewSearch() {
        performSegue(withIdentifier: "showSearchVC", sender: nil)
    }
    
    private func showSettingsScreen() {
        performSegue(withIdentifier: "showSettingsVC", sender: nil)
    }
    
    @IBAction func unwindToHomeViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
