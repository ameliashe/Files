//
//  TabBar.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import UIKit

class TabBar: UITabBarController {

	private lazy var mainVC: MainViewController = {
		let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
		let vc = MainViewController(path: documentsPath)
		return vc
	}()

	let settingsVC = SettingsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

		setupTabBar()
    }

	func setupTabBar() {
		let mainNC = UINavigationController(rootViewController: mainVC)
		let settingsNC = UINavigationController(rootViewController: settingsVC)
		mainNC.tabBarItem = UITabBarItem(title: "Files", image: UIImage(systemName: "folder"), tag: 0)
		settingsNC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
		let items = [mainNC, settingsNC]
		self.viewControllers = items
		self.tabBar.isTranslucent = false
		self.selectedIndex = 0
	}
}
