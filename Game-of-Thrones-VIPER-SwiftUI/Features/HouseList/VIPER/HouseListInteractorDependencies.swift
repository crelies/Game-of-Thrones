import Foundation

protocol HouseListInteractorDependenciesProtocol: APIServiceProvider {
    
}

struct HouseListInteractorDependencies: HouseListInteractorDependenciesProtocol {
    let apiService: APIService
    
    init() {
        apiService = APIService()
    }
}
