//
//  detailViewController.swift
//  MyMemoApp
//
//  Created by 혜리 on 2022/07/27.
//

import UIKit

class detailViewController: UIViewController {
    
    var memo: Memo? // 이전 화면에서 전달받은 정보를 추가
    var token: NSObjectProtocol? // notification token 저장
    
    @IBOutlet weak var memoTableView: UITableView!
    
    @IBAction func Share(_ sender: Any) {
        guard let memo = memo?.content else { return }
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        present(vc, animated: true, completion: nil) // 화면에 ActivityViewController 띄우기
    }
    
    @IBAction func deleteMemo(_ sender: Any) {
        let alert = UIAlertController(title: "경고", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제", style: .destructive) {
            [weak self] (action) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        let cancerAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancerAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    let formatter: DateFormatter = {
        let f = DateFormatter ()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "ko_kr")
        return f
    } ()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? composeViewController {
            vc.editTarget = memo // memo가 composeViewController로 전달됨
        }
    }
    
    // observer 해제
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token = NotificationCenter.default.addObserver(forName: composeViewController.MemoDidChange, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in self?.memoTableView.reloadData() // observer 추가
        })
    }
}

extension detailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // 표시할 셀의 개수
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 표시할 셀의 종류
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
            cell.textLabel?.text = memo?.content // memo 표시하기
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath)
            cell.textLabel?.text = formatter.string(for: memo?.insertDate)
            return cell
        default:
            fatalError()
        }
    }
}
