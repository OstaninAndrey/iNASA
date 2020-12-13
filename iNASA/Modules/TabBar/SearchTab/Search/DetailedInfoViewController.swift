//
//  DetailedInfoViewController.swift
//  iNASA
//
//  Created by Андрей Останин on 11.12.2020.
//

import Foundation
import UIKit

class DetailedInfoViewController: UIViewController {
    
    private var itemVM: ItemViewModel
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let dateCreatedLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let saveButton = CustomButton()
    
    init(itemVM: ItemViewModel) {
        self.itemVM = itemVM
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(article: Article) {
        self.init(itemVM: ItemViewModel(article: article))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        title = itemVM.title
        
        setupScrollView()
        setupElements()
        
        fillElements()
        styleElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func setupElements() {
        scrollView.addSubview(imageView)
        scrollView.addSubview(stackView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width - 40),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15),
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateCreatedLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(saveButton)
    }
    
    private func fillElements() {
        itemVM.loadImage { (image) in
            DispatchQueue.main.async {
                if let safeImage = image {
                    self.imageView.image = safeImage
                }
                else {
                    self.imageView.image = UIImage()
                }
            }
        }
        
        imageView.contentMode = .scaleAspectFit
        titleLabel.text = itemVM.title
        dateCreatedLabel.text = itemVM.dateCreated
        descriptionLabel.text = itemVM.description
        
        saveButton.setTitle(K.ButtonTitle.save, for: .normal)
        saveButton.addTarget(self, action: #selector(self.saveButtonPressed), for: .touchUpInside)
        saveButton.isHidden = itemVM.buttonHiddenState()
    }
    
    private func styleElements() {
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: K.FontSize.large, weight: .heavy)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        dateCreatedLabel.textColor = .gray
        dateCreatedLabel.font = UIFont.systemFont(ofSize: K.FontSize.small, weight: .light)
    }
    
    @objc private func saveButtonPressed() {
        DatabaseHelper.shared.saveLocalArticle(with: itemVM, image: imageView.image!)
        saveButton.isHidden = itemVM.buttonHiddenState()
    }
}
