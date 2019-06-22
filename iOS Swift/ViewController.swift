//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ProjectorPageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let frameViewController = FrameViewController()
        frameViewController.imageName = imageNames.first
        
        let viewControllers = [frameViewController]
        setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
    }
    
    let imageNames = ["test0", "test1", "test2"]
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let currentImageName = (viewController as! FrameViewController).imageName
        let currentIndex = imageNames.index(of: currentImageName!)
        
        if currentIndex! < imageNames.count - 1 {
            let frameViewController = FrameViewController()
            frameViewController.imageName = imageNames[currentIndex! + 1]
            return frameViewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let currentImageName = (viewController as! FrameViewController).imageName
        let currentIndex = imageNames.index(of: currentImageName!)
        
        if currentIndex! > 0 {
            let frameViewController = FrameViewController()
            frameViewController.imageName = imageNames[currentIndex! - 1]
            return frameViewController
        }
        return nil
    }
    
}


class FrameViewController: UIViewController {
    
    var imageName: String?{
        didSet{
            imageView.image = UIImage(named: imageName!)
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "test0")
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        imageView.fillSuperview()
    }
    
}


