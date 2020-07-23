import SwiftUI

struct HouseDetailScreen: View {
    @ObservedObject var viewModel: HouseDetailViewModel
    let url: URL

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    HouseFactsView(
                        name: viewModel.model.name,
                        region: viewModel.model.region,
                        coatOfArms: viewModel.model.coatOfArms,
                        words: viewModel.model.words,
                        currentLord: viewModel.model.currentLord,
                        heir: viewModel.model.heir,
                        overlord: viewModel.model.overlord,
                        founded: viewModel.model.founded,
                        founder: viewModel.model.founder,
                        diedOut: viewModel.model.diedOut
                    )
                    
                    Section(header: Text("Titles")) {
                        HouseTitlesView(titles: viewModel.model.titles)
                    }
                    
                    Section(header: Text("Seats")) {
                        HouseSeatsView(seats: viewModel.model.seats)
                    }
                    
                    Section(header: Text("Ancestral Weapons")) {
                        HouseAncestralWeaponsView(ancestralWeapons: viewModel.model.ancestralWeapons)
                    }
                    
                    Section(header: Text("Cadet Branches")) {
                        HouseCadetBranchesView(cadetBranches: viewModel.model.cadetBranches)
                    }
                    
                    Section(header: Text("Sworn Members")) {
                        HouseSwornMembersView(swornMembers: viewModel.model.swornMembers)
                    }
                }
                .listStyle(SidebarListStyle())
            }
        }
        .navigationTitle(Text(viewModel.model.name))
        .onAppear {
            viewModel.loadHouse(atURL: url)
        }
    }
}

#if DEBUG
struct HouseDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        HouseDetailScreen(viewModel: .init(), url: URL(string: "https://duckduckgo.com")!)
    }
}
#endif
