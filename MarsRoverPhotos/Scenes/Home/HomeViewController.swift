//
//  ViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 28.09.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, Storyboarded {
    var viewModel: HomeViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet var filterButtons: [UIButton]!
    @IBOutlet weak var roverFilterButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var cameraFilterButton: UIButton!
    @IBOutlet weak var saveFiltersButton: UIButton!
    
    @IBOutlet weak var photosTableView: UITableView!
    
    lazy var archiveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "archive"), for: .normal)
        button.setTitle("", for: .normal)
        button.backgroundColor = .accentOne
        button.layer.cornerRadius = 35
        button.addShadow(width: 0, height: 2, color: .shadowColor(alpha: 0.2), radius: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bind()
    }
    func setUpUI() {
        for button in filterButtons {
            button.titleLabel?.font = .titleTwoFont
            button.tintColor = .layerOne
            button.layer.cornerRadius = 10
            button.addShadow(width: 0, height: 4, color: .shadowColor(alpha: 0.1), radius: 10)
        }
        topView.addShadow(width: 0, height: 5, color: .shadowColor(alpha: 0.12), radius: 12)
        topView.backgroundColor = .accentOne
        dateLabel.font = .bodyTwoFont
        mainLabel.font = .largeTitleFont
        
        configureTableView()
        
        addArchiveButton()
    }
    func configureTableView() {
        photosTableView.dataSource = nil
        photosTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }
    func bind() {
        guard let viewModel else { return }
        viewModel.dateLabelText.drive(dateLabel.rx.text).disposed(by: disposeBag)
        roverFilterButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
            self?.showPickerController(viewModel: viewModel.viewModelForRoverPickerView())
            print("filterPressed")
        }).disposed(by: disposeBag)
        cameraFilterButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
            self?.showPickerController(viewModel: viewModel.viewModelForCameraPickerView())
            print("filterPressed")
        }).disposed(by: disposeBag)
        saveFiltersButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
            print("filterPressed")
        }).disposed(by: disposeBag)
        calendarButton.rx.tap.asObservable().subscribe(onNext: { [weak self] in
            self?.showDataPickerController(viewModel: viewModel.viewModelForDatPickerView())
        }).disposed(by: disposeBag)
        viewModel.photos
            .drive(photosTableView.rx
            .items(cellIdentifier: "PhotoTableViewCell", cellType: PhotoTableViewCell.self)) { _, item, cell in
                cell.configure(with: PhotoCellViewModel(photoModel: item))
        }.disposed(by: disposeBag)
        photosTableView.rx.itemSelected.asObservable().bind(to: viewModel.photoSelected.asObserver()).disposed(by: disposeBag)
        archiveButton.rx.tap.asObservable().bind(to: viewModel.archiveButtonPressed.asObserver()).disposed(by: disposeBag)
    }
    
    func addArchiveButton() {
        self.view.addSubview(archiveButton)
        NSLayoutConstraint.activate([
            archiveButton.widthAnchor.constraint(equalToConstant: 70),
            archiveButton.heightAnchor.constraint(equalToConstant: 70),
            archiveButton.trailingAnchor.constraint(equalTo: photosTableView.trailingAnchor, constant: -20),
            archiveButton.bottomAnchor.constraint(equalTo: photosTableView.bottomAnchor, constant: -21)
        ])
    }
    func showDataPickerController(viewModel: DatePickerViewModelProtocol) {
        var vc = DatePickerViewController.instantiate()
        vc.viewModel = viewModel
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    func showPickerController(viewModel: any PickerViewModelProtocol) {
        var vc = PickerViewController.instantiate()
        vc.viewModel = viewModel
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: false)
    }
    
}

