//
//  MainModel.swift
//  SearchDaumBlog
//
//  Created by Bo-Young PARK on 2021/09/09.
//

import RxSwift
import UIKit
//import Logger
struct SearchModel {
    let network = SearchBlogNetwork()
    
    func searchBlog(_ query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        
        //print("query\(query)")
        Logger().Log_Y("query\(query)")
        return network.searchBlog(query: query)
        
        //return "test"
    }
    
    func getBlogValue(_ result: Result<DKBlog, SearchNetworkError>) -> DKBlog? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getBlogError(_ result: Result<DKBlog, SearchNetworkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.message
    }
    
    func getBlogListCellData(_ value: DKBlog?) -> [BlogListCellData] {
        Logger().Log_Y("getBlogListCellData")
        guard let value = value else {
            return []
        }

        return value.documents
            .map {
                let thumbnailURL = URL(string: $0.thumbnail ?? "")
                Logger().Log_Y("CellData: \($0)")
                
                return BlogListCellData(
                    thumbnailURL: thumbnailURL,
                    name: $0.name,
                    title: $0.title,
                    datetime: $0.datetime
                )
            }
    }
    
    func sort(by type: SearchViewController.AlertAction, of data: [BlogListCellData]) -> [BlogListCellData] {
        switch type {
        case .title:
            return data.sorted { $0.title ?? "" < $1.title ?? "" }
        case .datetime:
            return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date() }
        case .cancel, .confirm:
            return data
        }
    }
}
