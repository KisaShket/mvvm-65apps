
import Foundation
struct Entry : Codable {
    
    var link : [Link]?
    var gdOrganization : [GdOrganization]?
    var gdEmail : [GdEmail]?
    var gdPhoneNumber : [GdPhoneNumber]?
    
    var id : String?
    var fullName : String?
    var profileType : String?
    
    enum EntryKeys: String, CodingKey {
        case id = "id"
        case fullName = "title"
        case link = "link"
        case profileType = "gal$type"
        case gdName = "gd$name"
        case gdWhere = "gd$where"
        case gdOrganization = "gd$organization"
        case gdEmail = "gd$email"
        case gdPhoneNumber = "gd$phoneNumber"
    }
    
    enum IdKeys: String, CodingKey {
        case id = "$t"
    }
    
    enum NameKeys: String, CodingKey {
        case fullName = "$t"
    }
    
    enum LinkKeys: String, CodingKey {
        case rel = "rel"
        case type = "type"
        case href = "href"
    }
    
    enum ProfileTypeKeys: String, CodingKey {
        case type = "type"
    }
    
    init(from decoder: Decoder) throws {
        
        if let entryContainer = try? decoder.container(keyedBy: EntryKeys.self){
            
            link = try entryContainer.decodeIfPresent([Link].self, forKey: .link)
            gdOrganization = try entryContainer.decodeIfPresent([GdOrganization].self, forKey: .gdOrganization)
            gdEmail = try entryContainer.decodeIfPresent([GdEmail].self, forKey: .gdEmail)
            gdPhoneNumber = try entryContainer.decodeIfPresent([GdPhoneNumber].self, forKey: .gdPhoneNumber)
            
            //MARK: - Flattening nested Json
            if let idContainer = try? entryContainer.nestedContainer(keyedBy: IdKeys.self,
                                                                     forKey: .id){
                self.id = try idContainer.decodeIfPresent(String.self, forKey: .id)
            }
            
            if let titleContainer = try? entryContainer.nestedContainer(keyedBy: NameKeys.self,
                                                                        forKey: .fullName){
                self.fullName = try titleContainer.decodeIfPresent(String.self, forKey: .fullName)
            }
            
            if let profileTypeContainer = try? entryContainer.nestedContainer(keyedBy:ProfileTypeKeys.self,
                                                                              forKey: .profileType){
                self.profileType = try profileTypeContainer.decodeIfPresent(String.self, forKey: .type)
            }
        }
    }
    
}
