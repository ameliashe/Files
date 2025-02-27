//
//  Settings.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import Foundation

final class Settings {
	static let shared = Settings()

	var sortingABC: Bool {
		get {
			return UserDefaults.standard.object(forKey: "sortABC") as? Bool ?? true
		}
		set {
			UserDefaults.standard.set(newValue, forKey: "sortABC")
		}
	}
}
