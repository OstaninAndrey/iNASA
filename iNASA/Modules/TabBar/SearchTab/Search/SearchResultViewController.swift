//
//  SearchResultViewController.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation
import UIKit

class SearchResultViewController: UIViewController {
    
    private var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private var collectionVM: CollectionViewModel
    private let quiery: String
    
    init(viewModel: CollectionViewModel, quiery: String) {
        collectionVM = viewModel
        self.quiery = quiery
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = quiery
        
        setupColletion()
        collectionVM.fetchNewPage(for: quiery) {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupConstraints()
    }
    
    private func setupColletion() {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 2 - 10
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = .black
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: K.ThumbCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: K.ThumbCell.reuseID)
    }
    
    private func setupConstraints() {
    
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ThumbCell.reuseID, for: indexPath) as! ThumbCell
        
        if let vm = collectionVM.getElementVM(index: indexPath.item) {
            cell.configure(itemVM: vm)
        }
        
        if collectionVM.lastElement(is: indexPath.item) {
            collectionVM.fetchNewPage(for: nil) {
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let vm = collectionVM.getElementVM(index: indexPath.item) else {
            return
        }
        let vc = DetailedInfoViewController(itemVM: vm)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
