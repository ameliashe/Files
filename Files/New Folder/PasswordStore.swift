//
//  UserDefaultsService.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import Foundation
import KeychainSwift

final class PasswordStore {

	func load() -> String? {
		if let password = KeychainSwift().getData("userPassword") {
			return decode(data: password)
		} else {
			return nil
		}
	}

	func save(password: String) {
		if let password = encode(password: password) {
			KeychainSwift().set(password, forKey: "userPassword")
		}
	}

	private func decode(data: Data) -> String? {
		return (try? JSONDecoder().decode(String.self, from: data)) ?? nil
	}

	private func encode(password: String) -> Data? {
		return try? JSONEncoder().encode(password)
	}
}
