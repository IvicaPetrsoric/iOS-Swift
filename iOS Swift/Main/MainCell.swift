import UIKit

class MainCell: UICollectionViewCell {
    
    let newsItemController = NewsItemController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let newsItemsView = newsItemController.view!
        addSubview(newsItemsView)
        newsItemsView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
