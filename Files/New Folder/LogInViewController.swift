//
//  LogInViewController.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import UIKit

class LogInViewController: UIViewController {

	let viewModel = LoginViewModel()
	public lazy var areCredentialsValid: Bool = viewModel.isRegistered()
	public var isPresentedModally = false

	private let passwordTextField = CustomField(title: "Password")

	private lazy var confirmTextField: CustomField = {
		let field = CustomField(title: "Confirm Password")
		field.isHidden = areCredentialsValid ? true : false
		return field
	}()

	private lazy var loginButton = CustomButton(title:(areCredentialsValid ? "Enter Password" : "Create Password"))

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		view.backgroundColor = .systemBackground

		addSubviews()
		setupLayout()
		setupButton()
		configureTextFields()
    }

	func addSubviews() {
		view.addSubview(passwordTextField)
		view.addSubview(confirmTextField)
		view.addSubview(loginButton)
	}

	func setupLayout() {
		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
			passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			passwordTextField.heightAnchor.constraint(equalToConstant: 50),

			confirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
			confirmTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			confirmTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			confirmTextField.heightAnchor.constraint(equalToConstant: 50),

			loginButton.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 16),
			loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			loginButton.heightAnchor.constraint(equalToConstant: 50),

		])
	}

	func setupButton() {
		if areCredentialsValid {
			loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		} else {
			loginButton.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
		}
	}

	func configureTextFields() {
		confirmTextField.addTarget(self, action: #selector(confirmTextFieldEditingBegan), for: .editingDidBegin)
	}

	@objc func loginButtonTapped() {
		guard let entered = passwordTextField.text, !entered.isEmpty else {
			showAlert(message: "Please enter your password.")
			return
		}
		do {
			if try viewModel.checkPassword(entered: entered) {
				navigateToNextScreen()
			}
		} catch {
			showAlert(message: error.localizedDescription)
		}
	}

	@objc func regButtonTapped() {

		guard let password1 = passwordTextField.text, let password2 = confirmTextField.text else {
			showAlert(message: "Please fill in both fields.")
			return
		}
		if password1 == password2 {
			viewModel.savePassword(entered: password1)
			if isPresentedModally == false {
				navigateToNextScreen()
			}
			else {
				dismiss(animated: true)
			}
		} else {
			showAlert(message: "Passwords do not match. Try again.")
			resetFields()
		}
	}

	@objc func confirmTextFieldEditingBegan() {
		loginButton.setTitle("Repeat password", for: .normal)
	}

	func navigateToNextScreen() {
		let tabBar = TabBar()
		navigationController?.pushViewController(tabBar, animated: true)
	}

	func resetFields() {
		passwordTextField.text = ""
		confirmTextField.text = ""
	}

	func showAlert(message: String) {
			let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default))
			present(alert, animated: true)
		}
}
