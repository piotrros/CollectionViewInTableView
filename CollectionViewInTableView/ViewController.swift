import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var foos:[Foo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 188
        
        for i in stride(from: 1, to: 10, by: 1) {
            let foo = Foo()
            foo.title = "Item \(i)"
            foo.description = "Description \(i)"
            foos.append(foo)
        }
    }

}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foo = foos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FooTableViewCell
        
        cell.titleLabel.text = foo.title
        cell.descriptionLabel.text = foo.description
        cell.iconsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        cell.iconsCollectionView.loadIcons()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foos.count
    }
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
