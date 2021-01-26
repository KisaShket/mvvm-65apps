
import Foundation
struct Link : Codable {
	let rel : String?
	let type : String?
	let href : String?

	enum CodingKeys: String, CodingKey {
		case rel = "rel"
		case type = "type"
		case href = "href"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rel = try values.decodeIfPresent(String.self, forKey: .rel)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		href = try values.decodeIfPresent(String.self, forKey: .href)
	}

}
