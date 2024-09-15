//
//  SearchViewController.swift
//  iNASA
//
//  Created by Андрей Останин on 08.12.2020.
//

// MARK: - Search & CollectionView

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    private var searchTextField = SearchTextField()
    private var searchButton = CustomButton()
    private var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    private let stackView = UIStackView()
    private let collectionVM = CollectionViewModel(networkManager: NetworkManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchElements()
        setupCollection()
        collectionVM.fetchMainScreen {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        collectionView.reloadData()
    }
    
    private func setupSearchElements() {
        
        searchTextField.delegate = self
        searchTextField.returnKeyType = UIReturnKeyType.done
        
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(searchTextField)
        stackView.addArrangedSubview(searchButton)
         
        stackView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.setTitle(K.ButtonTitle.search, for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupCollection() {
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 2 - 5
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: K.ThumbCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: K.ThumbCell.reuseID)
    }
    
    @objc private func searchButtonPressed() {
        let newVM = CollectionViewModel(networkManager: NetworkManager())
        let vc = SearchResultViewController(viewModel: newVM,
                                            quiery: searchTextField.text!)
        navigationController?.pushViewController(vc, animated: true)
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ThumbCell.reuseID, for: indexPath) as! ThumbCell
        
        if let vm = collectionVM.getElementVM(index: indexPath.item) {
            cell.configure(itemVM: vm)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vm = collectionVM.getElementVM(index: indexPath.item) else { return }
        
        let vc = DetailedInfoViewController(itemVM: vm)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
