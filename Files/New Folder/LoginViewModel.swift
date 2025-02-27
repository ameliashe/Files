//
//  LoginViewModel.swift
//  Files
//
//  Created by Amelia Romanova on 2/27/25.
//

import Foundation

enum PasswordError: LocalizedError {
	case tooShort
	case invalid

	var errorDescription: String? {
		switch self {
		case .tooShort:
			return "Password should be at least 4 characters long."
		case .invalid:
			return "Invalid password."
		}
	}
}

final class LoginViewModel {

	private let store = PasswordStore()

	func isRegistered() -> Bool {
		return store.load() != nil
	}

	func checkPassword(entered: String) throws -> Bool {
		guard let savedPassword = store.load() else {
			throw PasswordError.invalid
		}
		if entered == savedPassword {
			return true
		} else {
			throw PasswordError.invalid
		}
	}

	func getPassword() throws -> String {
		guard let savedPassword = store.load() else {
			throw PasswordError.invalid
		}
		return savedPassword
	}

	func savePassword(entered: String) {
		store.save(password: entered)
	}

	func isValidPassword(entered: String) throws -> Bool {
		let minLength = 4
		if entered.count < minLength {
			throw PasswordError.tooShort
		} else {
			return true
		}
	}
}
