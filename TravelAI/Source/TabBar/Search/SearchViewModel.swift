//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by Bo-Young PARK on 2021/09/09.
//

import RxSwift
import RxCocoa
import UIKit

struct SearchViewModel {
    let disposeBag = DisposeBag()
    
    let searchBarViewModel = SearchBarViewModel()
    let blogListViewModel = BlogListViewModel()
    
    let alertActionTapped = PublishRelay<SearchViewController.AlertAction>()
    let shouldPresentAlert: Signal<SearchViewController.Alert>
    
    init(model: SearchModel = SearchModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog)
            .share()
        
        Logger().Log_Y("blogResult:\(blogResult)")
        
        //print("blogReult:\(blogResult)")
        
        let blogValue = blogResult
            .map(model.getBlogValue)
            .filter { $0 != nil }
        
        Logger().Log_Y("blogvalue:\(blogValue)")
        
        let blogError = blogResult
            .map(model.getBlogError)
            .filter { $0 != nil }
        
        Logger().Log_Y("blogError:\(blogError)")
        //네트워크를 통해 가져온 값을 CellData로 변환
        let cellData = blogValue
            .map(model.getBlogListCellData)
        
        //FilterView를 선택했을 때 나오는 alertsheet를 선택했을 때 type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title)
        
        //MainViewController -> ListView
        Observable
            .combineLatest(
                sortedType,
                cellData,
                resultSelector: model.sort
            )
            .bind(to: blogListViewModel.blogListCellData)
            .disposed(by: disposeBag)
        
        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> SearchViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .do(onNext: { message in
                print("error: \(message ?? "")")
            })
                .map { _ -> SearchViewController.Alert in
                    return (
                        title: "앗!",
                        message: "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요.",
                        actions: [.confirm],
                        style: .alert
                    )
                }
        
        self.shouldPresentAlert = Observable
            .merge(
                alertSheetForSorting,
                alertForErrorMessage
            )
            .asSignal(onErrorSignalWith: .empty())
    }
}
