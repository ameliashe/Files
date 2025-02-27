//
//  SettingsTableViewController.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemBackground
		navigationItem.title = "Settings"
		navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source


	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			let cell = UITableViewCell()
			var config = UIListContentConfiguration.cell()
			config.text = "Sort in Ascending Order"
			cell.contentConfiguration = config
			let sortingSwitch = UISwitch()
			sortingSwitch.tag = indexPath.row
			sortingSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
			sortingSwitch.isOn = Settings.shared.sortingABC
			cell.accessoryView = sortingSwitch

			return cell
		}
		if indexPath.row == 1 {
			let cell = UITableViewCell()
			var config = UIListContentConfiguration.cell()
			config.text = "Change Password"
			cell.contentConfiguration = config
			cell.accessoryType = .detailDisclosureButton
			return cell
		}
		else {
			let cell = UITableViewCell()
			return cell
		}
    }

	@objc private func switchToggled() {
		Settings.shared.sortingABC.toggle()
	}


	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.row == 0 {
			tableView.deselectRow(at: indexPath, animated: true)
			return
		}

		if indexPath.row == 1 {
			let loginVC = LogInViewController()
			loginVC.areCredentialsValid = false
			loginVC.isPresentedModally = true
			present(loginVC, animated: true)
		}
	}

	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		if indexPath.row == 0 {
			return false
		}
		return true
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
