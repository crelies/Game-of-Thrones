import SwiftUI

protocol HouseDetailViewProtocol: HouseDetailProtocol {
    
}

struct HouseDetailView: View {
    @ObservedObject private var presenter = HouseDetailWireframe.makePresenter()
    
    weak var delegate: HouseDetailDelegateProtocol?
    let url: URL
    
    var body: some View {
        List {
            HouseFactsView(name: presenter.viewModel.name,
                           region: presenter.viewModel.region,
                           coatOfArms: presenter.viewModel.coatOfArms,
                           words: presenter.viewModel.words,
                           currentLord: presenter.viewModel.currentLord,
                           heir: presenter.viewModel.heir,
                           overlord: presenter.viewModel.overlord,
                           founded: presenter.viewModel.founded,
                           founder: presenter.viewModel.founder,
                           diedOut: presenter.viewModel.diedOut)
            
            Section {
                HouseTitlesView(titles: presenter.viewModel.titles)
            }
            
            Section {
                HouseSeatsView(seats: presenter.viewModel.seats)
            }
            
            Section {
                HouseAncestralWeaponsView(ancestralWeapons: presenter.viewModel.ancestralWeapons)
            }
            
            Section {
                HouseCadetBranchesView(cadetBranches: presenter.viewModel.cadetBranches)
            }
            
            Section {
                HouseSwornMembersView(swornMembers: presenter.viewModel.swornMembers)
            }
        }
        .navigationBarTitle(Text(presenter.viewModel.name), displayMode: .inline)
        .listStyle(GroupedListStyle())
        .onAppear {
            self.presenter.didReceiveEvent(.viewAppears(houseURL: self.url))
        }
    }
}

extension HouseDetailView: HouseDetailViewProtocol {
    
}

extension HouseDetailView: HouseDetailProtocol {
    
}

#if DEBUG
struct HouseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://www.anapioficeandfire.com/api/houses/1")!
        return HouseDetailView(url: url)
    }
}
#endif