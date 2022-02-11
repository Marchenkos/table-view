import Foundation

struct FamilyMembers: Codable {
    var name: String
    var member: String
}

extension FamilyMembers {
    static var data = [
        FamilyMembers(name: "Nika", member: "mother"),
        FamilyMembers(name: "Vlad", member: "father"),
        FamilyMembers(name: "David", member: "brother")
    ]
}
