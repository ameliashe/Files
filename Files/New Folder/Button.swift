//
//  Button.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import Foundation
import UIKit

final class CustomButton: UIButton {

	init(title: String) {
		super.init(frame: .zero)
		setup(title: title)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setup(title: String) {
		self.setTitle(title, for: .normal)
		self.setTitleColor(.white, for: .normal)
		self.backgroundColor = .orange
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 10
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
