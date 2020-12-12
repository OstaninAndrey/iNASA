//
//  LoadingsViewController.swift
//  iNASA
//
//  Created by Андрей Останин on 08.12.2020.
//

// MARK: - TableView

import Foundation
import UIKit

class DownloadsViewController: UIViewController {
    
    private let cacheVM = CacheViewModel()
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        cacheVM.loadCache {
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                style: .plain)
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.SavedCell.nibName, bundle: nil), forCellReuseIdentifier: K.SavedCell.reuseID)
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cacheVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.SavedCell.reuseID, for: indexPath) as! SavedTableViewCell
        
        if let art = cacheVM.getElem(index: indexPath.row) {
            cell.configure(item: art)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let article = cacheVM.getElem(index: indexPath.row) {
            let vc = DetailedInfoViewController(article: article)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        tableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            print("trying to delete")
            if cacheVM.removeAtIndex(indexPath.row) {
                tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            }
            
         }
    }
    
}
