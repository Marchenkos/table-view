import UIKit
import MobileCoreServices

class AddNewItemController: UITableViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var memberField: UITextField!

    var addMember: ((_ member: FamilyMembers)->Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add member"
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }

    @IBAction func save(_ sender: Any) {
        if let newMember = memberField.text, let newName = nameField.text {
            addMember(FamilyMembers(name: newName, member: newMember))
       
            navigationController?.popViewController(animated: true)
        }
    }
}
