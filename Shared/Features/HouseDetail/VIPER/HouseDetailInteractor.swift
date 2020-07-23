import Combine
import Foundation

protocol HouseDetailInteractorProtocol {
    func getHouse(atURL url: URL) -> AnyPublisher<HouseDataModel, Error>
}

final class HouseDetailInteractor {
    private let dependencies: HouseDetailInteractorDependenciesProtocol
    
    init(dependencies: HouseDetailInteractorDependenciesProtocol) {
        self.dependencies = dependencies
    }
}

extension HouseDetailInteractor: HouseDetailInteractorProtocol {
    func getHouse(atURL url: URL) -> AnyPublisher<HouseDataModel, Error> {
        return dependencies.apiService.getHouse(atURL: url)
            .tryMap { houseResponseModel in
                return try houseResponseModel.houseDataModel()
            }.eraseToAnyPublisher()
    }
}
