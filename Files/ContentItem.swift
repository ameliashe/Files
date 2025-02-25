//
//  ContentItem.swift
//  Files
//
//  Created by Amelia Romanova on 2/25/25.
//

import Foundation

struct ContentItem {
	enum ContentType {
		case image
		case folder
	}

	let name: String
	let type: ContentType
}
