import Foundation

protocol HouseDetailInteractorDependenciesProtocol: APIServiceProvider {
    
}

struct HouseDetailInteractorDependencies: HouseDetailInteractorDependenciesProtocol {
    let apiService: APIService
    
    init() {
        apiService = APIService()
    }
}
