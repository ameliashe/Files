//
//  MainViewController.swift
//  Files
//
//  Created by Amelia Romanova on 2/25/25.
//

import UIKit

class MainViewController: UIViewController {

	private let fileManagerService: FileManagerServiceProtocol = FileManagerService()
	private var contents: [ContentItem] = []
	private var currentPath: String


	//MARK: UI Elements
	private var docsTable = UITableView(frame: .zero, style: .plain)


	//MARK: Init
	init(path: String) {
		self.currentPath = path
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	//MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		navigationBarSetup()

		docsTable.dataSource = self
		docsTable.delegate = self

		addSubviews()
		setupConstraints()
		loadContents()
	}



	//MARK: UI setup
	func addSubviews() {
		view.addSubview(docsTable)
	}

	func setupConstraints() {
		docsTable.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			docsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			docsTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			docsTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			docsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}

	func loadContents() {
		contents = fileManagerService.contentsOfDirectory(at: currentPath)
		docsTable.reloadData()
	}

	func navigationBarSetup() {
		navigationController?.navigationBar.prefersLargeTitles = true

		let createFolder = UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(didTapCreateFolder))
		let createFile = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(didTapFileButton))
		navigationItem.rightBarButtonItems = [createFile, createFolder]

		navigationItem.title = (currentPath as NSString).lastPathComponent
	}


	//MARK: Interaction Methods
	@objc private func didTapCreateFolder() {
		let alert = UIAlertController(title: "New Folder", message: "Enter folder name", preferredStyle: .alert)
		alert.addTextField {textField in
			textField.placeholder = "Folder title"
		}
		let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
			guard let title = alert.textFields?.first?.text, !title.isEmpty else { return }
			self?.fileManagerService.createDirectory(named: title, at: self?.currentPath ?? "")
			self?.loadContents()
		}
		alert.addAction(createAction)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
		present(alert, animated: true)
	}

	@objc private func didTapFileButton() {
		let imagePicker = UIImagePickerController()
		imagePicker.sourceType = .photoLibrary
		imagePicker.delegate = self
		present(imagePicker, animated: true)
	}

}


//MARK: TableView extensions
extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contents.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		var config = UIListContentConfiguration.cell()
		config.text = contents[indexPath.row].name
		cell.contentConfiguration = config
		cell.accessoryType = contents[indexPath.row].type == .folder ? .disclosureIndicator : .none
		return cell
	}
}

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = contents[indexPath.row]

		if item.type == .folder {
			let vc = MainViewController(path: currentPath + "/" + item.name)
			navigationController?.pushViewController(vc, animated: true)
		} else {

		}
	}

	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			fileManagerService.removeContent(at: currentPath + "/" + contents[indexPath.row].name)
			loadContents()
		}
	}
}


//MARK: ImagePicker extension
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let image = info[.originalImage] as? UIImage,
		   let imageData = image.jpegData(compressionQuality: 0.8) {

			let fileName = "Image_\(Date().timeIntervalSince1970).jpg"
			fileManagerService.createFile(named: fileName, imageData: imageData, at: currentPath)
			loadContents()
		}

		picker.dismiss(animated: true)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true)
	}
}

