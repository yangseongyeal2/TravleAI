//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by Bo-Young PARK on 2021/09/09.
//

import RxSwift
import RxCocoa

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    let blogListCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        Logger().Log_Y("BlogListViewModel Init")
        self.cellData = blogListCellData
            .asDriver(onErrorJustReturn: [])
    }
}
