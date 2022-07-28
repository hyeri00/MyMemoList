//
//  composeViewController.swift
//  MyMemoApp
//
//  Created by 혜리 on 2022/07/27.
//

import UIKit

class composeViewController: UIViewController {
    
    var editTarget: Memo?
    var originalMemoContent: String? // 편집 이전의 메모 내용 저장
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func save(_ sender: Any) {
        guard let memo = memoTextView.text, memo.count > 0 else {
            alert(message: "Please enter a note.")
            return
        }
        
        if let target = editTarget {
            target.content = memo // 편집한 내용 저장
            NotificationCenter.default.post(name: composeViewController.MemoDidChange, object: nil)
        } else {
            // 새로운 메모 인스턴스 생성, 배열에 저장
            let newMemo = Memo(content: memo)
            Memo.MemoList.append(newMemo)
            NotificationCenter.default.post(name: composeViewController.newMemoDisInsert, object: nil)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let memo = editTarget {
            navigationItem.title = "Memo Editing"
            memoTextView.text = memo.content
            originalMemoContent = memo.content
        } else {
            navigationItem.title = "New Memo"
            memoTextView.text = ""
        }
        memoTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.presentationController?.delegate = self
        // 편집 화면 표시되기 전에 delegate 설정
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.presentationController?.delegate = nil
        // 편집 화면 사라지기 직전에 delegate 해제
    }
}

extension composeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let original = originalMemoContent, let edited = textView.text {
            isModalInPresentation = original != edited // modal 방식으로 동작할지를 결정
        }
    }
}

extension composeViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        let alert = UIAlertController(title: "NOTICE", message: "Would you like to save your edits?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            [weak self] (action) in self?.save(action)
        }
        
        alert.addAction(okAction)
        
        let cancerAction = UIAlertAction(title: "Cancel", style: .cancel) {
            [weak self] (action) in self?.close(action)
        }
        
        alert.addAction(cancerAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension composeViewController {
    // notification name
    static let newMemoDisInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let MemoDidChange = Notification.Name(rawValue: "MemoDidChange")
}




