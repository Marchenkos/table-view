import UIKit

class FMTableViewCell: UITableViewCell {
    @IBOutlet private var labelMember: UILabel!
    @IBOutlet private var labelName: UILabel!
    @IBOutlet private var cellImage: UIImageView!
    
    var nameText: String = "" {
        willSet(newText) {
            labelName.text = newText
        }
    }
    
    var memberText: String = "" {
        willSet(newText) {
            labelMember.text = newText
        }
    }
    
    var imageValue: UIImage? {
        willSet(newValue) {
            cellImage.image = newValue
        }
    }
}
