
import Foundation
struct GdOrganization : Codable {
    var rel : String?
    var primary : String?
    var orgTitle : String?
    
    enum OrganizationKeys: String, CodingKey {
        case rel = "rel"
        case primary = "primary"
        case orgTitle = "gd$orgTitle"
    }
    
    enum OrgTitleKeys: String, CodingKey {
        
        case post = "$t"
    }
    
    init(from decoder: Decoder) throws {
        if let organizationContainer = try? decoder.container(keyedBy: OrganizationKeys.self){
            rel = try organizationContainer.decodeIfPresent(String.self, forKey: .rel)
            primary = try organizationContainer.decodeIfPresent(String.self, forKey: .primary)
            if let orgTitleContainer = try? organizationContainer.nestedContainer(keyedBy: OrgTitleKeys.self,
                                                                                 forKey: .orgTitle){
                self.orgTitle = try orgTitleContainer.decodeIfPresent(String.self, forKey: .post)
                
            }
            
        }
    }
    
}
