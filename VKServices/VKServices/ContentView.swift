import SwiftUI

struct ContentView: View {
		
		@StateObject private var webService = WebService()
		
    var body: some View {
				VStack {
						Text("Сервисы")
								.font(.headline.bold())
						ScrollView(showsIndicators: false) {
								ForEach(webService.services, id: \.name) { service in
										ServiceCard(service: service)
								}
						}
				}
				.task {
						do {
								try await webService.fetchServices()
						} catch {
								print(error)
						}
				}
    }
		
}

struct ServiceCard: View {
		
		@Environment(\.openURL) private var openURL
		
		private var service: ServiceModel
		init(service: ServiceModel){
				self.service = service
		}
		
		var body: some View {
				Link(destination: URL(string: service.link)!) {
						HStack {
								AsyncImage(url: URL(string: service.icon_url)) { image in
										image.resizable()
								} placeholder: {
										ProgressView()
								}
								.padding(4)
								.frame(width: 84, height: 84)
								VStack(alignment: .leading) {
										Text(service.name)
												.font(.headline)
										Text(service.description)
												.font(.subheadline)
												.multilineTextAlignment(.leading)
								}
								Spacer()
								Image(systemName:"chevron.right")
										.font(Font.system(.headline))
										.foregroundColor(Color(.tertiaryLabel))
						}
				}
				.buttonStyle(.plain)
		}
}
