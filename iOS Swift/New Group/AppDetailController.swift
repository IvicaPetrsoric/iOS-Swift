//
//  AppDetailController.swift
//  AppStoreDemo
//
//  Created by Ivica Petrsoric on 05/12/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
   
    var service = Service()
    
    var app: App? {
        didSet{
            
            if app?.Screenshots != nil{
                return
            }
            
            if let id = app?.Id{
                service.fetchAppDetails(id: "\(Int(id))", completion: { (details) in
                    self.app = details
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                })
            }
        }
    }
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    private let descriptionCellId = "descriptionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
//        navigationController?.navigationBar.isHidden = true
        // header
        collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
   
        // cell
        collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(AppDetailsDescriptionCell.self, forCellWithReuseIdentifier: descriptionCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellId, for: indexPath) as! AppDetailsDescriptionCell
            
            cell.textView.attributedText = descriptionAttributedText()
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotsCell
        cell.app = app
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // drugo polje s description
        if indexPath.item == 1{
            
            let size = CGSize(width: view.frame.width - 16, height: 1000)
            let rect = descriptionAttributedText().boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesLineFragmentOrigin), context: nil)
            
            return CGSize(width: view.frame.width, height: rect.height + 34)
        }
        
        return CGSize(width: view.frame.width, height: 170)
    }
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppDetailHeader
        header.app = app
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    
    // attributed text
    private func descriptionAttributedText() -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "Description\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        
        let range = NSMakeRange(0, attributedText.string.count)
        attributedText.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: range)
        
        if let desc = app?.description{
            attributedText.append(NSAttributedString(string: desc, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11), NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        }
        
        return attributedText
    }
}




