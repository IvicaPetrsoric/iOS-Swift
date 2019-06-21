import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date {
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
    
    func reduceToMonthDayYear() -> Date {
        let calendar = Calendar.current
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        let year = calendar.component(.year, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: "\(month)/\(day)/\(year)") ?? Date()
    }
}

class HomeController: UITableViewController {
    
    fileprivate let cellId = "cellId"
    
//    let chatMessages = [
//        [
//            ChatMessage(text: "Here my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
//            ChatMessage(text: "Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018"))
//        ],
//        [
//            ChatMessage(text: "Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first messageHere my very first message", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
//            ChatMessage(text: "Yo Dog, whats up", isIncoming: false, date: Date.dateFromCustomString(customString: "089/15/2018")),
//            ChatMessage(text: "Here my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "09/15/2018")),
//        ],
//        [
//            ChatMessage(text: "Thir section message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2018")),
//            ChatMessage(text: "Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first messageHere my very first message", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2018"))
//        ]
//    ]
    
    let messagesFromServer = [
        ChatMessage(text: "Here my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first messageHere my very first message", isIncoming: false, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Yo Dog, whats up", isIncoming: false, date: Date.dateFromCustomString(customString: "089/15/2018")),
        ChatMessage(text: "Here my very first message", isIncoming: true, date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Thir section message", isIncoming: true, date: Date.dateFromCustomString(customString: "10/03/2018")),
        ChatMessage(text: "Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first message Here my very first messageHere my very first message", isIncoming: false, date: Date.dateFromCustomString(customString: "10/03/2018"))
    ]
    
    var chatMessages = [[ChatMessage]]()
    
    fileprivate func attempToAssembleGroupMessages() {
        let groupedMessages = Dictionary(grouping: messagesFromServer) { (element) -> Date in
            return element.date.reduceToMonthDayYear()
        }
        let sortedKeys = groupedMessages.keys.sorted()
        
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
        
//        groupedMessages.keys.forEach { (key) in
//            print(key)
//            let values = groupedMessages[key]
//            print(values ?? "")
//
//            chatMessages.append(values ?? [])
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attempToAssembleGroupMessages()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let firstMessageInSection = chatMessages[section].first {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yyyy"
//            let dateString = dateFormatter.string(from: firstMessageInSection.date)
//            return dateString
//        }
//
//        return "Section \(section)"
//    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = UIColor(red: 149/255, green: 239/255, blue: 200/255, alpha: 1)
            textColor = .black
            textAlignment = .center
            translatesAutoresizingMaskIntoConstraints = false
            font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
           
            let label = DateHeaderLabel()
            label.text = dateString
            
            let containerView = UIView()
            containerView.addSubview(label)
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            return containerView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }

}

