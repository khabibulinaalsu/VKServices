import Foundation

struct ServicesModel: Decodable {
		let body: Body
		let status: Int
}

struct Body: Decodable {
		let services: [ServiceModel]
}

struct ServiceModel: Decodable {
		let name: String
		let description: String
		let link: String
		let icon_url: String
}
