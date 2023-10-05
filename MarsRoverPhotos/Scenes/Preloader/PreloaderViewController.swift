//
//  PreloaderViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 05.10.2023.
//

import UIKit
import Lottie

class PreloaderViewController: UIViewController {
    
    lazy var loadingView: LottieAnimationView = {
        let view = LottieAnimationView(name: "Loader")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var orangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .accentOne
        view.layer.cornerRadius = 30
        view.addShadow(width: 0, height: 20, color: .shadowColor(alpha: 0.2), radius: 55)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingView.play()
    }
    func addSubviews() {
        self.view.backgroundColor = .backgroundOne
        self.view.addSubview(loadingView)
        self.view.addSubview(orangeView)
    }
    func addConstraints() {
        let orangeWidth = orangeView.widthAnchor.constraint(equalToConstant: 123)
        let orangeHeight = orangeView.heightAnchor.constraint(equalToConstant: 123)
        let orangeCenterX = orangeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let orangeCenterY = orangeView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        //let orangeBottom = orangeView.bottomAnchor.constraint(equalTo: loadingView.topAnchor, constant: -217)
        let animationTop = loadingView.topAnchor.constraint(greaterThanOrEqualTo: orangeView.bottomAnchor, constant: 50)
        let animationCenterX = loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let animationHeight = loadingView.heightAnchor.constraint(equalToConstant: 200)
        let animationBottom = loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -7)
        let animationWidth = loadingView.widthAnchor.constraint(equalTo: orangeView.widthAnchor)
        NSLayoutConstraint.activate([orangeWidth, orangeHeight, orangeCenterX, orangeCenterY, /*animationTop,*/ animationCenterX, animationHeight, animationWidth, animationBottom])
    }
    
}
