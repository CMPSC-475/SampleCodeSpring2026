//
//  ViewController.swift
//  UIKitDemo
//
//  Created by Nader Alfares on 3/24/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let button : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Start Loading", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return btn
    }()
    
    
    private let activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    let buttonWidth : CGFloat = 200
    let buttonHeight : CGFloat = 50
    
    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button.frame = CGRect(
            x: (view.bounds.width - buttonWidth) / 2,
            y: (view.bounds.height - buttonWidth) / 2,
            width: buttonWidth,
            height: buttonHeight
        )
        
        activityIndicator.frame = CGRect(
            x: (view.bounds.width - buttonWidth) / 2,
            y: button.frame.maxY + 20,
            width: 50,
            height: 50
        )
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        
        self.view.addSubview(button)
        self.view.addSubview(activityIndicator)
    }
    
    
    @objc func buttonTapped() {
        isLoading.toggle()
        
        if isLoading {
            activityIndicator.startAnimating()
            button.setTitle("Stop Loading", for: .normal)
        } else {
            activityIndicator.stopAnimating()
            button.setTitle("Start Loading", for: .normal)
        }
    }


}

