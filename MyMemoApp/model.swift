//
//  model.swift
//  MyMemoApp
//
//  Created by 혜리 on 2022/07/27.
//

import Foundation
import UIKit

class Memo {
    var content: String // 새로운 메모
    var insertDate: Date // 메모 저장 날짜
    var img: UIImage? // 삽입할 이미지
    
    init(content: String) {
        self.content = content
        insertDate = Date()
        img = UIImage()
    }
    
    static var MemoList = [
        Memo(content: "1")
    ]
}
