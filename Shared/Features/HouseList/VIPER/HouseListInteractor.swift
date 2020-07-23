import Combine
import Foundation

protocol HouseListInteractorProtocol {
    var pageSize: Int { get }
    var allHousesLoaded: Bool { get set }
    func getNextHouses() -> AnyPublisher<[HouseDataModel], Error>
	func getCurrentHouses() -> AnyPublisher<[HouseDataModel], Error>
}

final class HouseListInteractor {
    private let dependencies: HouseListInteractorDependenciesProtocol
    private var currentPage: Int
    
    let pageSize: Int
    var allHousesLoaded: Bool
    
    init(dependencies: HouseListInteractorDependenciesProtocol) {
        self.dependencies = dependencies
        currentPage = 1
        pageSize = 50
        allHousesLoaded = false
    }
}

extension HouseListInteractor: HouseListInteractorProtocol {
    func getNextHouses() -> AnyPublisher<[HouseDataModel], Error> {
        currentPage += 1
        
        return self.dependencies.apiService.getHouses(page: currentPage, pageSize: pageSize)
            .tryCompactMap { houseResponseModels in
                return try houseResponseModels.compactMap { try $0.houseDataModel() }
            }.eraseToAnyPublisher()
    }
    
    func getCurrentHouses() -> AnyPublisher<[HouseDataModel], Error> {
        return self.dependencies.apiService.getHouses(page: currentPage, pageSize: pageSize)
            .tryCompactMap { houseResponseModels in
                return try houseResponseModels.compactMap { try $0.houseDataModel() }
            }.eraseToAnyPublisher()
    }
}
