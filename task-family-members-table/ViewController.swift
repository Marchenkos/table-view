import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private enum Constants {
        static let cellIdentifier = "FMTableViewCell"
        static let addNewItemControllerIdentifier = "AddNewItemController"
        static let title = "Family members"
    }

    @IBAction func addNew(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.addNewItemControllerIdentifier) as! AddNewItemController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.dragDelegate = self
        tableView.dropDelegate = self

        tableView.dragInteractionEnabled = true

        title = Constants.title
    }
}

extension ViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = FamilyMembers.data[indexPath.row]
        
        do {
            let data = try JSONEncoder().encode(item)
            let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: kUTTypePlainText as String)

            return [UIDragItem(itemProvider: itemProvider)]
        } catch {
            print(error)

            return []
        }
    }
}

extension ViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            guard let members = items as? [FamilyMembers] else { return }

            var indexPaths = [IndexPath]()

            for (index, member) in members.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)

                FamilyMembers.data.insert(member, at: indexPath.row)

                indexPaths.append(indexPath)
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {        
        FamilyMembers.data.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FamilyMembers.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier, for: indexPath) as! FMTableViewCell

        let familyMember = FamilyMembers.data[indexPath.row]

        cell.memberText = familyMember.member
        cell.nameText = familyMember.name
        cell.imageValue = UIImage(systemName: "person.circle")

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FamilyMembers.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
