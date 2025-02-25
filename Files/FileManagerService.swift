//
//  FileManagerService.swift
//  Files
//
//  Created by Amelia Romanova on 2/25/25.
//

import Foundation


protocol FileManagerServiceProtocol {
	func contentsOfDirectory(at path: String) -> [ContentItem]
	func createDirectory(named name: String, at path: String)
	func createFile(named name: String, imageData: Data, at path: String)
	func removeContent(at path: String)
}

final class FileManagerService: FileManagerServiceProtocol {

	func contentsOfDirectory(at path: String) -> [ContentItem] {
		let items = (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []

		return items.map { item in
			let itemPath = path + "/" + item
			var isDirectory: ObjCBool = false
			FileManager.default.fileExists(atPath: itemPath, isDirectory: &isDirectory)

			let type: ContentItem.ContentType = isDirectory.boolValue ? .folder : .image
			return ContentItem(name: item, type: type)
		}
	}

	func createDirectory(named name: String, at path: String) {
		let newDirectoryPath = path + "/" + name
		try? FileManager.default.createDirectory(atPath: newDirectoryPath, withIntermediateDirectories: false)
	}

	func createFile(named name: String, imageData: Data, at path: String) {
		let filePath = path + "/" + name
		FileManager.default.createFile(atPath: filePath, contents: imageData)
	}

	func removeContent(at path: String) {
		try? FileManager.default.removeItem(atPath: path)
	}

}
