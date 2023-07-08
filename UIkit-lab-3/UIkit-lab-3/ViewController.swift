//
//  ViewController.swift
//  UIkit-lab-3
//
//  Created by Iliya Rahozin on 08.07.2023.
//

import UIKit


class ViewController: UIViewController {

    let slider: UISlider = {
        var slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()

    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        return containerView
    }()

    let box: UIView = {
        let box = UIView(frame: .zero)
        box.backgroundColor = .systemBlue
        box.layer.cornerRadius = 10
        box.translatesAutoresizingMaskIntoConstraints = false

        return box
    }()

    var animator: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubviews(box, slider)

        setupLayout()

        slider.addTarget(self, action: #selector(sliderCancel), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouch), for: .valueChanged)


        animator = UIViewPropertyAnimator(duration: 0.8, curve: .easeInOut) { [unowned self, box] in
            box.center.x = self.containerView.frame.width - 60
            box.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
        animator.pausesOnCompletion = true
    }

    private func setupLayout() {
        viewRespectsSystemMinimumLayoutMargins = false
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            containerView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            
            box.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 70),
            box.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            box.widthAnchor.constraint(equalToConstant: 80),
            box.heightAnchor.constraint(equalToConstant: 80),

            slider.topAnchor.constraint(equalTo: box.bottomAnchor, constant: 50),
            slider.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            slider.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

    }

    @objc func sliderCancel(_ sender: UISlider) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            sender.setValue(sender.maximumValue, animated: true)
        })
        self.animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    }

    @objc func sliderTouch(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }

}


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
