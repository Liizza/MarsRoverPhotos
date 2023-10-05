//
//  HistoryViewController.swift
//  MarsRoverPhotos
//
//  Created by Liza on 04.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController, Storyboarded {
    var viewModel: HistoryViewModelProtocol?
    private let disposeBag = DisposeBag()
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var historyEmptyLabeL: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureTableView()
        bind()

    }
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    func setUpUI() {
        topView.addShadow(width: 0, height: 5, color: .shadowColor(alpha: 0.12), radius: 12)
        topView.backgroundColor = .accentOne
        titleLabel.font = .largeTitleFont
        titleLabel.text = "History"
        historyEmptyLabeL.font = .bodyFont
        historyEmptyLabeL.textColor = .layerTwo
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(goBack))
        backItem.tintColor = .layerOne
        self.navigationItem.leftBarButtonItem = backItem
    }
    func configureTableView() {
        historyTableView.dataSource = nil
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
    }
    func bind() {
        guard let viewModel else { return }
        viewModel.isNotEmpty.drive(emptyView.rx.isHidden).disposed(by: disposeBag)
        viewModel.items
            .drive(historyTableView.rx
            .items(cellIdentifier: "HistoryTableViewCell", cellType: HistoryTableViewCell.self)) { _, item, cell in
                cell.configure(with: HistoryCellViewModel(filterModel: item))
        }.disposed(by: disposeBag)
        historyTableView.rx.itemSelected.asObservable().subscribe(onNext: { [weak self] indexPath in
            self?.showAlertViewController() { action in
                switch action {
                case .destructive:
                    viewModel.itemDeleted.asObserver().onNext(indexPath)
                case .default:
                    viewModel.itemSelected.asObserver().onNext(indexPath)
                case .cancel:
                    return
                @unknown default:
                    return
                }
            }
        }).disposed(by: disposeBag)
    }
    func showAlertViewController(completionHandler: @escaping (UIAlertAction.Style) -> ()) {
        let alertVC = UIAlertController(title: "Menu Filter", message: nil, preferredStyle: .actionSheet)
        let useAction = UIAlertAction(title: "Use", style: .default) { action in
            completionHandler(action.style)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            completionHandler(action.style)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertVC.addAction(useAction)
        alertVC.addAction(deleteAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }

}
