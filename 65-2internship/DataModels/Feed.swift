
import Foundation
struct Feed : Codable {
	let link : [Link]?
	let openSearchTotalResults : OpenSearchTotalResults?
	let galSyncToken : GalSyncToken?
	let galHasNext : GalHasNext?
	let entry : [Entry]?

	enum FeedKeys: String, CodingKey {
		case title = "title"
		case link = "link"
		case openSearchTotalResults = "openSearch$totalResults"
		case galSyncToken = "gal$syncToken"
		case galHasNext = "gal$hasNext"
		case entry = "entry"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: FeedKeys.self)
		link = try values.decodeIfPresent([Link].self, forKey: .link)
		openSearchTotalResults = try values.decodeIfPresent(OpenSearchTotalResults.self, forKey: .openSearchTotalResults)
		galSyncToken = try values.decodeIfPresent(GalSyncToken.self, forKey: .galSyncToken)
		galHasNext = try values.decodeIfPresent(GalHasNext.self, forKey: .galHasNext)
		entry = try values.decodeIfPresent([Entry].self, forKey: .entry)
	}

}
