//
//  CalendarController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 09/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

import UIKit
import LBTATools

struct CalendarDay {
    let day: Int
    var isSelected = false
    var isStartSelection = false
    var isEndSelection = false
}

class DayCell: LBTAListCell<CalendarDay> {
    
    let label = UILabel(text: "Day", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .center)
    
    override var item: CalendarDay! {
        didSet {
            label.text = "\(item.day ?? 0)"
            
            if item.isSelected {
                backgroundColor = .yellow
            } else {
                backgroundColor = .white
            }
            
            if item.isStartSelection {
                backgroundColor = .red
            }
            
            if item.isEndSelection {
                backgroundColor = .blue
            }
            
        }
    }
    
//    override var isSelected: Bool {
//        didSet {
//            backgroundColor = self.isSelected ? .yellow : .white
//        }
//    }
    
    override func setupViews() {
        super.setupViews()
        
        stack(label)
    }
    
}

class CalendarController: LBTAListController<DayCell, CalendarDay>, UICollectionViewDelegateFlowLayout {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Calendar Attempt"
        
        collectionView.allowsMultipleSelection = true
        collectionView.alwaysBounceVertical = true
        
        let days = (1..<31).map { return CalendarDay(day: $0) }
        
        self.items = days
    }
    
    var startIndexPath: IndexPath?
    var endIndexPath: IndexPath?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if endIndexPath != nil {
            startIndexPath = indexPath
            endIndexPath = nil
            (0..<items.count).forEach { i in
                items[i].isSelected = false
                items[i].isStartSelection = false
                items[i].isEndSelection = false
            }
            
            collectionView.reloadData()
            return
        }
        
        if startIndexPath == nil {
            startIndexPath = indexPath
            return
        } else {
            endIndexPath = indexPath
        }
        
        (startIndexPath!.item...endIndexPath!.item).forEach { i in
//            print($0)
            self.items[i].isSelected = true
        }
        
        self.items[startIndexPath!.item].isStartSelection = true
        self.items[endIndexPath!.item].isEndSelection = true
        
        self.collectionView.reloadData()
        
//        let indexPath = IndexPath(item: 1, section: 0)
//        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 7
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
