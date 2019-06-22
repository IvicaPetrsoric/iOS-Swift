//
//  SwipingController.swift
//  autolayout_X
//
//  Created by Ivica Petrsoric on 16/10/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    let pages = [
        Page(imageName: "bear_first", headerText: "Join us today n our fun abd games!", bodyText: "Are yxou ready for loads and loasd od fun? Don't waint any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subsrcie and get coupons on our daily events", bodyText: "Get notified of saving immediately when we announe them on our website. ake sure to alo give us anny Feed back!"),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: ""),
        Page(imageName: "bear_first", headerText: "Join us today n our fun abd games!", bodyText: "Are yxou ready for loads and loasd od fun? Don't waint any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subsrcie and get coupons on our daily events", bodyText: "Get notified of saving immediately when we announe them on our website. ake sure to alo give us anny Feed back!"),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .mainPink
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        collectionView?.backgroundColor = .white
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    fileprivate func setupBottomControls(){
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    @objc private func handlePrev(){
        print("Prev page")
        let nextIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
        
    @objc private func handleNext(){
        print("Next page")
        let nextIndex = min(pageControl.currentPage + 1, pages.count  - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        print(x, view.frame.width, x / view.frame.width)
    }
    
}
