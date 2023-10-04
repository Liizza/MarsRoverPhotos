//
//  DataPickerViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import UIKit
import RxSwift

class DatePickerViewController: UIViewController, Storyboarded {
    var viewModel: DatePickerViewModelProtocol?
    private let disposeBag = DisposeBag()

    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var chooseButton: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bind()
        addShowAnimation()
    }
    
    func setUpUI() {
        self.modalPresentationStyle = .overFullScreen
        popUpView.backgroundColor = .backgroundOne
        popUpView.layer.cornerRadius = 50
        popUpView.addShadow(width: 0, height: 16, color: .shadowColor(alpha: 0.08), radius: 16)
        mainLabel.font = .titleTwoFont
        mainLabel.text = "Date"
        self.view.backgroundColor = .layerOne.withAlphaComponent(0.4)
    }
    func bind() {
        guard let viewModel else { return }
        datePicker.date = viewModel.date
        addShowAnimation()
        cancelButton.rx.tap.asObservable().subscribe({ [weak self] _ in
            self?.dismiss()
        }).disposed(by: disposeBag)
        chooseButton.rx.tap.asObservable().bind(onNext: { [weak self] in
            guard let self else { return }
            self.viewModel?.chooseButtonPressed.asObserver().onNext(self.datePicker.date)
            self.dismiss()
        }).disposed(by: disposeBag)
    }
    func addShowAnimation() {
        self.view.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.2) { [weak self] in
            self?.view.alpha = 1
        }
    }
    func dismiss() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.view.alpha = 0.0
       }) { [weak self] _ in
           self?.dismiss(animated: false)
           self?.removeFromParent()
       }
    }
}
