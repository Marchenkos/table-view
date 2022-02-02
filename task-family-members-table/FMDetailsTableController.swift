import Foundation
import UIKit

class FamilyDetailViewController: UITableViewController {
    var member: FamilyMembers?
    let cellIdentifier = "FMDelailsCell"
    
    enum DetailsRow: Int, CaseIterable {
            case birthday
            case phoneNumber

            func displayText(for member: FamilyMembers?) -> String? {
                switch self {
                case .birthday:
                    return member?.birthday.description
                case .phoneNumber:
                    return member?.phoneNumber?.description
                }
            }

            var cellImage: UIImage? {
                switch self {
                case .birthday:
                    return UIImage(systemName: "calendar.circle")
                case .phoneNumber:
                    return nil
                }
            }
    }

    func configure(with member: FamilyMembers) {
        self.member = member
    }
}

extension FamilyDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailsRow.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyDelailsCellIdentifier", for: indexPath)
        let familyMember = FamilyMembers.data[indexPath.row]

        let row = DetailsRow(rawValue: indexPath.row)
        cell.textLabel?.text = row?.displayText(for: familyMember)
        cell.imageView?.image = row?.cellImage
        
        return cell
    }
}
