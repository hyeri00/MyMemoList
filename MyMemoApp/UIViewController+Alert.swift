//
//  UIViewController+Alert.swift
//  MyMemoApp
//
//  Created by 혜리 on 2022/07/27.
//

import UIKit

// UIViewController를 상속하는 모든 class에서 이용 가능하도록 extension 사용
extension UIViewController {
    // 경고창 표시
    func alert (title: String = "알림", message: String) {
        // alert view
        let alert = UIAlertController(title: title, message: "메모가 입력되지 않았습니다.", preferredStyle: .alert)
        // 경고창에 표시되는 버튼
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // 경고창을 화면에 표시
        present(alert, animated: true, completion: nil)
        
    }
}
