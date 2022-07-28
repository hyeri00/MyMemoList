//
//  model.swift
//  MyMemoApp
//
//  Created by 혜리 on 2022/07/27.
//

import Foundation

class Memo {
    var content: String // 새로운 메모
    var insertDate: Date // 메모 저장 날짜
    
    init(content: String) {
        self.content = content
        insertDate = Date()
    }
    
    static var MemoList = [
        Memo(content: "1"),
        Memo(content: "2")
    ]
}
