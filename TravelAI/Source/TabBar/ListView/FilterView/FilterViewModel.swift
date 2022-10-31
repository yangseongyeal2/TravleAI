//
//  FilterViewModel.swift
//  SearchDaumBlog
//
//  Created by Bo-Young PARK on 2021/09/09.
//

import RxSwift
import RxCocoa

struct FilterViewModel {
    let sortButtonTapped = PublishRelay<Void>()
    let shouldUpdateType: Observable<Void>
    
    init() {
        self.shouldUpdateType = sortButtonTapped
            .asObservable()
    }
}
