//
//  AlgorithmsTests.swift
//  
//
//  Created by Thomas Segkoulis on 15.10.23.
//

import XCTest
import Graph

@testable import Algorithms

final class AlgorithmsTests: XCTestCase {

	func test_BellmanFord() throws {
		let graph = GraphBase<VerticeMock, EdgeMock>(direction: .directed)

		graph.addEdge(from: .init(name: "A"),
					  to: .init(name: "B"),
					  edge: .init(weight: 5.0))
		
		graph.addEdge(from: .init(name: "A"),
					  to: .init(name: "C"),
					  edge: .init(weight: 9.0))
		
		graph.addEdge(from: .init(name: "B"),
					  to: .init(name: "D"),
					  edge: .init(weight: 4.0))
		
		graph.addEdge(from: .init(name: "B"),
					  to: .init(name: "C"),
					  edge: .init(weight: 1.0))
		
		graph.addEdge(from: .init(name: "C"),
					  to: .init(name: "E"),
					  edge: .init(weight: 1.0))
		
		graph.addEdge(from: .init(name: "E"),
					  to: .init(name: "D"),
					  edge: .init(weight: 1.0))
		
		graph.addEdge(from: .init(name: "D"),
					  to: .init(name: "F"),
					  edge: .init(weight: 2.0))
		
		graph.addEdge(from: .init(name: "F"),
					  to: .init(name: "E"),
					  edge: .init(weight: 3.0))
		
		let distances = try BellmanFord(graph: graph, source: .init(name: "A")).execute()
		distances.forEach {
			print("-> \($0.key) = \($0.value)")
		}
		print("distances: \(distances)")
		
		let dfs = BFS.init(graph: graph)
		
		dfs.execute(parent: .init(name: "A")) { vertice in
			print("-- \(vertice.name)")
		}
		
//		-> VerticeMock(name: "E") = 14.0
//		-> VerticeMock(name: "C") = 9.0
//		-> VerticeMock(name: "D") = 9.0
//		-> VerticeMock(name: "A") = 0.0
//		-> VerticeMock(name: "B") = 5.0
//		-> VerticeMock(name: "F") = 11.0
	}

}

struct VerticeMock: Vertice {
	static func < (lhs: VerticeMock, rhs: VerticeMock) -> Bool {
		lhs.name > rhs.name
	}
	
	var name: String
}

struct EdgeMock: WeightedEdge {
	var weight: Double
	
	init(weight: Double) {
		self.weight = weight
	}
	
	static func < (lhs: EdgeMock, rhs: EdgeMock) -> Bool {
		lhs.weight < rhs.weight
	}
}
