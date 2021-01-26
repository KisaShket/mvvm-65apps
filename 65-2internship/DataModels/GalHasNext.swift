
import Foundation
struct GalHasNext : Codable {
	let t : String?

	enum CodingKeys: String, CodingKey {
		case t = "$t"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		t = try values.decodeIfPresent(String.self, forKey: .t)
	}

}
