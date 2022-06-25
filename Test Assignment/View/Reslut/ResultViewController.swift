//
//  ResultViewController.swift
//  Test Assignment
//
//  Created by Ahmed Serdah on 25/06/2022.
//

import UIKit
import RxCocoa
import RxSwift
import PullToRefresh

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    let resultTableViewCell = "ResultTableViewCell"
    var searchViewModel: SearchViewModel = .shared
    private let disposeBag = DisposeBag()
    private let refresher = PullToRefresh()
    private var page = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        subscribeToResponse()
        subscribeToLoading()
        resultsTableView.addPullToRefresh(PullToRefresh()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                //  self?.reloadAction()
                guard let self = self else { return }
                if (self.searchViewModel.loadMoreBehavior.value == false) {
                    self.searchViewModel.loadMoreBehavior.accept(true)
                }
                self.page = 1
                self.fetchData()
                self.resultsTableView?.endRefreshing(at: .top)
            }
        }
        
        resultsTableView.addPullToRefresh(PullToRefresh(position: .bottom)) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                guard let self = self else { return }
                if (self.searchViewModel.loadMoreBehavior.value == true) {
                    self.page = self.page + 1
                    self.fetchData()
                }
                self.resultsTableView?.endRefreshing(at: .bottom)
            }
        }
        fetchData()
    }
    
    func setupTableView() {
        
        resultsTableView.register(UINib(nibName: resultTableViewCell, bundle: nil), forCellReuseIdentifier: resultTableViewCell)
    }
    
    func subscribeToResponse() {
        self.searchViewModel.resultsModelObservable
            .bind(to: self.resultsTableView
                .rx
                .items(cellIdentifier: resultTableViewCell,
                       cellType: ResultTableViewCell.self)) { row, user, cell in
                
                cell.user = user
                cell.configCell()
            }
                       .disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        searchViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator()
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    
    private func fetchData() {
        
        searchViewModel.fetchUsers(page: page)
            .subscribe(onCompleted: { [weak self]  in
                guard let self = self else { return }
                
            }, onError: { [weak self] error in
                print("error")
                print(error)
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        resultsTableView.removeAllPullToRefresh()
    }
    
    
}
