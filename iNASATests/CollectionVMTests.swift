//
//  iNASATests.swift
//  iNASATests
//
//  Created by Останин Андрей on 15.09.2024.
//

import XCTest
@testable import iNASA

final class CollectionVMTests: XCTestCase {

    var collectionVM: CollectionViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.collectionVM = CollectionViewModel(networkManager: NetworkManagerMock())
    }
    
    override func tearDownWithError() throws {
        // убираем объект из памяти после окончания теста, освобождая память для запуска следующих тестов
        collectionVM = nil
        try super.tearDownWithError()
    }
    
    func testPresenter() throws {
        var itemsCount = 0
        collectionVM.fetchMainScreen {
            itemsCount = NetworkManagerMock.collectionMockValue().items.count
        }
        
        XCTAssertEqual(
            itemsCount,
            NetworkManagerMock.collectionMockValue().items.count,
            "Данные успешно загрузились и доступны для отрисовки"
        )
    }
}

fileprivate class NetworkManagerMock: NetworkManager {
    static func collectionMockValue() -> CollectionModel {
        CollectionModel(
            version: "",
            metadata: .init(totalHits: 4),
            href: "",
            items: [
                .init(
                    links: [],
                    href: "",
                    data: []
                )
            ]
        )
    }
    
    override func getSearchResult(quiery: String, page: Int, completion: @escaping (CollectionModel?, String?) -> Void) {
        completion(NetworkManagerMock.collectionMockValue(), nil)
    }
}
