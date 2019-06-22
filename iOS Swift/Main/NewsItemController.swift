import UIKit

class NewsItemController: UITableViewController {
    
    let cellId = "cellId"
    let items = [
        "As a developer whose first programming language is Swift, I've taken online courses from major platforms.",
        "However, I have been frustrated by a lack of detailed explanations from instructors. They tend to focus on final products, thus missing out the fundamentals. I was confused by which design principles to follow, and why.",
        "After I've been blogging for the last 5 months, I've discovered this isn't the only problem of mine.",
        "I've received hundreds of emails and questions regarding how to write code that does not violate principles such as DRY, modularity, and readability. As a result, I've decided to create this course dedicated for my younger self. I believe it all comes down to the fundamentals which I lacked in the beginning."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = .init(top: 16, left: 0, bottom: 0, right: 0)
        
//        collectionView.backgroundColor = .white
//        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.item]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NewsCell
//        cell.label.text = items[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return .init(width: view.frame.width, height: 100)
//    }
    
}

class NewsCell: UICollectionViewCell {
    
    let label: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18)
        l.numberOfLines = 0
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
