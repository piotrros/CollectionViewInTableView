
import UIKit

class IconsCollectionView: DynamicCollectionView {
    
    var bars:[Bar] = []
    
    var columnLayout:ColumnFlowLayout?
    
    override func awakeFromNib() {
        dataSource = self
        delegate = self
    }
    
    func initFlowLayout(selfWidth:CGFloat) {
        let layout = ColumnFlowLayout(
            cellsPerRow: 4,
            selfWidth: selfWidth,
            minimumInteritemSpacing: 0,
            minimumLineSpacing: 0,
            sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        )
        columnLayout = layout
        collectionViewLayout = layout
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
//            self.invalidateIntrinsicContentSize()
//        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard let columnLayout = columnLayout else { return CGSize(width: 0, height: 0) }
        let itemSize = columnLayout.itemSize
        // Tthis is the critical part - you are using bars.count to calculate the size, but
        // in fact you are using bars.count + 1 in numberOfItemsInSection
        // This can result in situation were the + icon will need another row
        let rows = ceil(Double(bars.count + 1) / Double(columnLayout.cellsPerRow))
        let w = columnLayout.selfWidth
//        let w = itemSize.width * CGFloat(columnLayout.cellsPerRow)
//        let w = superview?.bounds.width ?? 0
        let h = itemSize.height * CGFloat(rows)
        
        
        print("itemSize: \(itemSize.width), \(itemSize.height), intrinsicContentSize: \(w), \(h); rows = \(rows)")
        
        return CGSize(width: w, height: h)
    }
    
    func loadIconsAsync() {
        //simulate sending a query to the server by waiting a bit
        bars.removeAll()
        reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let iconsCount = Utils.rnd(3, 8)
            for _ in stride(from: 1, to: iconsCount, by: 1) {
                self.bars.append(self.getRandomItem())
            }
            // Just a note here - you will have to tell the tableview here that
            // it should update its view, see my answer here: https://stackoverflow.com/a/47963680/2912282
            self.reloadData()
        }
    }
    
    func loadIconsSync() {
        bars.removeAll()
        let iconsCount = Utils.rnd(3, 8)
        for _ in stride(from: 1, to: iconsCount, by: 1) {
            bars.append(self.getRandomItem())
        }
        reloadData()
    }
    
    func getRandomItem() -> Bar {
        let randomIndex = Utils.rnd(1, 10)
        let bar = Bar()
        bar.imageName = "icon_\(randomIndex).png"
        return bar
    }

}

extension IconsCollectionView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bars.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! BarCollectionViewCell
        
        let row = indexPath.row
        if(row >= bars.count) {
            cell.iconImageView.image = UIImage(named: "add.png")
            return cell
        } else {
            let bar = bars[row]
            cell.iconImageView.image = UIImage(named: bar.imageName)
            return cell
        }
    }
    
}

extension IconsCollectionView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deselectItem(at: indexPath, animated: true)
        if(indexPath.row >= bars.count) { //it's a plus button
            bars.append(getRandomItem())
            reloadData()
        }
    }
    
}
