
import Foundation
struct GdEmail : Codable {
	let address : String?
    let primary : String?
	let rel : String?

	enum CodingKeys: String, CodingKey {
		case address = "address"
        case primary = "primary"
		case rel = "rel"
      
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
        primary = try values.decodeIfPresent(String.self, forKey: .primary)
		rel = try values.decodeIfPresent(String.self, forKey: .rel)
	}

}
