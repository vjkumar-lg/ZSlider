//
//  ViewController.swift
//  ZSlider
//
//  Created by vjkumar-lg on 05/31/2022.
//  Copyright (c) 2022 vjkumar-lg. All rights reserved.
//import Foundation


import ZSlider

import UIKit
import Pods_ZSlider_Example


class ViewController: UIViewController {
    
    lazy var sliderView: ZSliderView = {
        let slider = ZSliderView()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        }
        super.viewDidLoad()
   
        sliderView.configureSlider(with: ZSliderViewModel(isContinuous: true, steps: 10, labelValues: ["1","2","3","4","5","6","7","8","9","10"], activeLabelTextColor: .blue, activeLabelBackgroundColor: nil))
        
        view.addSubview(sliderView)
        addConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addConstraints() {
        sliderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sliderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        sliderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        sliderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}

