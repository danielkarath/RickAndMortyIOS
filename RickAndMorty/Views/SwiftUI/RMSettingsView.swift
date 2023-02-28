//
//  RMSettingsView.swift
//  RickAndMorty
//
//  Created by Daniel Karath on 2/28/23.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List(viewModel.cellViewModels) { viewModel in
                HStack {
                    if let image = viewModel.image,
                       let backgroundColor = viewModel.iconContainerColor
                    {
                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(9)
                            .background(Color(backgroundColor))
                            .cornerRadius(6)
                            .padding(.trailing, 6)
                    }
                    Text("\(viewModel.title)")
                }
                .padding(4)
            }
        }
    }
}

struct RMSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingsView(
            viewModel: .init(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    return RMSettingsCellViewModel(type: $0)
                })
            )
        )
    }
}
