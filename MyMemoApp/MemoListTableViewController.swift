//
//  MemoListTableViewController.swift
//  MyMemoApp
//
//  Created by 혜리 on 2022/07/27.
//

import UIKit

class MemoListTableViewController: UITableViewController {
    
    let formatter: DateFormatter = {
        let f = DateFormatter ()
        f.dateStyle = .long
        f.timeStyle = .short
        f.locale = Locale(identifier: "ko_kr")
        return f
    } ()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData() // table view에게 목록 업데이트 하도록 알려줌
        print(#function) // 업로드 되었는지 확인
    }
    
    // observer 해제하기. token 이용
    var token: NSObjectProtocol?
    
    deinit { // 소멸자에서 해제함
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            if let vc = segue.destination as? detailViewController {
                vc.memo = Memo.MemoList[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observer 해제하기
        token = NotificationCenter.default.addObserver(forName: composeViewController.newMemoDisInsert, object: nil, queue: OperationQueue.main) {
            [weak self] (noti) in self?.tableView.reloadData() // tableView를 reload
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Memo.MemoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let target = Memo.MemoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = "\(target.insertDate)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 메모 삭제 코드
            tableView.deleteRows(at: [indexPath], with: .fade) // tableview에서 삭제 코드
        } else if editingStyle == .insert {
            
        }
    }
}


