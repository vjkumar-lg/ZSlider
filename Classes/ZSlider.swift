//
//  ZSlider.swift
//  Pods-ZSlider_Example
//
//  Created by vijay-pt5416 on 31/05/22.
//

import UIKit
import Foundation

public struct ZSliderViewModel {
    
    public init (isContinuous:Bool, steps:Int?, labelValues:[String]?, activeLabelTextColor:UIColor?,
                 activeLabelBackgroundColor:UIColor?) {
        self.isContinuous = isContinuous
        self.steps = steps
        self.labelValues = labelValues
        self.activeLabelTextColor = activeLabelTextColor
        self.activeLabelBackgroundColor = activeLabelBackgroundColor
    }
    
    let isContinuous: Bool
    let steps:Int?
    let labelValues: [String]?
    let activeLabelTextColor:UIColor?
    let activeLabelBackgroundColor:UIColor?
}

public final class ZSliderView :UIView {
    
    public lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }()
    
    public lazy var labelStack: UIStackView={
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    private var viewModel:ZSliderViewModel?
    
//    private var labelValues:[String]?
//    var steps:Int?
    public var activeLabelValue:String
    public var allLabels : [UILabel]?
    
    private func configure() {
        self.setSliderConstraints()
        self.addLabels()
        self.setLabelStackConstraints()
        if self.allLabels != nil && allLabels!.count>0 {
            guard let viewModel = viewModel else {
                return
            }
            self.activeLabelValue = allLabels![0].text!
            if let bgColor = viewModel.activeLabelBackgroundColor{
                allLabels![0].backgroundColor = bgColor
            }
            if let textColor = viewModel.activeLabelTextColor {
                allLabels![0].textColor = textColor
            }
        }
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider ) {
        guard let data = self.viewModel else {
            return
        }
         
        guard let steps = data.steps else {
            print(sender.value)
            sender.value += 1
            return
        }
        
        if  steps>1 {
            let roundedStep = roundf(sender.value/Float(steps) * Float(steps))
            sender.value = roundedStep
            updateLabels(val: Int(roundedStep))
            }
    }
    
    public func configureSlider(with viewModel:ZSliderViewModel ){
        slider.isContinuous = viewModel.isContinuous
        self.viewModel = viewModel
        slider.minimumValue = 1
        guard let steps = viewModel.steps else{
            self.configure()
            return
        }
        slider.maximumValue = Float(steps)
        self.configure()
    }
    
    private func setSliderConstraints() {
        self.addSubview(slider)
        slider.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    private func setLabelStackConstraints() {
        self.addSubview(labelStack)
        labelStack.topAnchor.constraint(equalTo:self.centerYAnchor,constant: 20).isActive = true
        labelStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 7).isActive = true
        labelStack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -7).isActive = true
    }
    
    private func updateLabels(val:Int) {
        guard let data = self.viewModel else {
            return
        }
         
        guard let steps = data.steps else {
            return
        }
        
        if allLabels == nil {
            return
        }
        
        if  steps>1 {
            let roundedStep = val
            for i in 0...steps-1 {
                if #available(iOS 13.0, *) {
                    allLabels![i].backgroundColor = .systemBackground
                } else {
                    allLabels![i].backgroundColor = .white
                }
            }
            
            if let bgColor = self.viewModel?.activeLabelBackgroundColor{
                allLabels![Int(roundedStep)-1].backgroundColor = bgColor
            }
            
            for i in 0...steps-1 {
                if #available(iOS 13.0, *) {
                    allLabels![i].textColor = .secondaryLabel
                } else {
                    allLabels![i].textColor = .lightGray
                }
            }
            self.activeLabelValue = allLabels![roundedStep-1].text!
            if let textColor = self.viewModel?.activeLabelTextColor{
                allLabels![Int(roundedStep)-1].textColor = textColor
            }
        }
    }
    
    func addLabels() {
        guard let data = viewModel else {
            return
        }
        guard let values = data.labelValues else {
            return
        }
        guard let steps = data.steps else {
            return
        }
        
        if( allLabels == nil) {
            allLabels = []
        }
      
        for i in 1...steps {
            let label:UILabel = {
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                if(values.count > i-1){
                    label.text = values[i-1]
                }
                else {
                    label.text = " "
                }
                if #available(iOS 13.0, *) {
                    label.textColor = .secondaryLabel
                } else {
                    label.textColor = .lightGray
                }
                return label
            }()
            allLabels?.append(label)
            labelStack.addArrangedSubview(label)
        }
    }
    
    override public init(frame: CGRect) {
        activeLabelValue = ""
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        activeLabelValue = ""
        super.init(coder: coder)
        
    }
}


