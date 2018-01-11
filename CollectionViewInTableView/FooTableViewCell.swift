import UIKit

class FooTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconsCollectionView: IconsCollectionView!
    
    override func awakeFromNib() {
        iconsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        iconsCollectionView.initFlowLayout(superviewWidth: self.frame.width)
        iconsCollectionView.loadIconsSync()
        iconsCollectionView.setNeedsLayout()
    }
    
}
