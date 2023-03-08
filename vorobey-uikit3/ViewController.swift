//
//  ViewController.swift
//  vorobey-uikit3
//
//  Created by Павел Бубликов on 08.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let slider: UISlider = {
        var slider = UISlider()
        return slider
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    let box: UIView = {
        let box = UIView(frame: .zero)
        box.backgroundColor = .systemMint
        box.layer.cornerRadius = 5
        return box
    }()

    var animator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.addSubview(slider)
        stackView.addSubview(box)
        
        setupLayout()
        
        slider.addTarget(self, action: #selector(sliderCancel), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderCancel), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(sliderTouch), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        
        animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [unowned self, box] in
            box.center.x = self.stackView.frame.width - 60
            box.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 1.5, y: 1.5)
        }
        // Do any additional setup after loading the view.
    }
    
    private func setupLayout() {
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        slider.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        box.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor).isActive = true
        
        slider.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        
        box.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 70).isActive = true
        box.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        box.widthAnchor.constraint(equalToConstant: 80).isActive = true
        box.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    @objc func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func sliderCancel(_ sender: UISlider) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            sender.setValue(sender.maximumValue, animated: true)
        })
        animator.continueAnimation(withTimingParameters: self.animator.timingParameters, durationFactor: 0.4)
        animator.pausesOnCompletion = true
    }
    
    @objc func sliderTouch(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }

}

