import UIKit
import MobileCoreServices

class AddNewItemController: UITableViewController {
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var memberField: UITextField!
    
    private enum Constants {
        static let title = "Add member"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func save(_ sender: Any) {
        if let newMember = memberField.text, let newName = nameField.text {
            FamilyMembers.data.append(FamilyMembers(name: newName, member: newMember))
       
            navigationController?.popViewController(animated: true)
        }
    }
}
