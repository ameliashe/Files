//
//  Field.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import Foundation
import UIKit

final class CustomField: UITextField {

	init(title: String) {
		super.init(frame: .zero)
		setup(title: title)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup(title: String) {
		self.placeholder = title
		self.borderStyle = .roundedRect
		self.backgroundColor = .systemGray6
		self.tintColor = .black
		self.isSecureTextEntry = true
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
