import Foundation

enum NetworkError: Error {
		case badURL
}

@MainActor
class WebService: ObservableObject {
		
		@Published var services: [ServiceModel] = [ServiceModel]()
		
		func fetchServices() async throws {
				services = try await loadServices()
		}
		
		func loadServices() async throws -> [ServiceModel] {
				guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else {
						throw NetworkError.badURL
				}
				
				let (data, _) = try await URLSession.shared.data(from: url)
				
				let response = try? JSONDecoder().decode(ServicesModel.self, from: data)
				
				return response?.body.services ?? [ServiceModel]()
		}
}
