
import Foundation
struct ContactsModel : Codable {
	let feed : Feed?

	enum ContactsKeys: String, CodingKey {
		case feed = "feed"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: ContactsKeys.self)
		feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
	}
}
