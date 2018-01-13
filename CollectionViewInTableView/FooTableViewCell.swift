import UIKit

class FooTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconsCollectionView: IconsCollectionView!
    
    override func awakeFromNib() {
        iconsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        // In fact the contentView is superview of the iconsCollectionView, so lets use its bounds
        // and lets subtract 16 points (8 from left, 8 from right), because that will be a result of your
        // constraints from Main.storyboard
        iconsCollectionView.initFlowLayout(selfWidth: self.contentView.bounds.width - 16)
        iconsCollectionView.loadIconsSync()
        iconsCollectionView.setNeedsLayout()
    }
    
}
