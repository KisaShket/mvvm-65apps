
import Foundation
struct GdPhoneNumber : Codable {
	let rel : String?
	let uri : String?
	let phoneNumber : String?

	enum CodingKeys: String, CodingKey {

		case rel = "rel"
		case uri = "uri"
		case phoneNumber = "$t"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rel = try values.decodeIfPresent(String.self, forKey: .rel)
		uri = try values.decodeIfPresent(String.self, forKey: .uri)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
	}

}
