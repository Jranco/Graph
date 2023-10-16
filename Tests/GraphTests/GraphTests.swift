import XCTest
@testable import Graph

final class GraphTests: XCTestCase {
    func test_graphShouldBeInitiallyEmpty() throws {
		/// GIVEN: A new graph
		let graph = GraphBase<VerticeMock, EdgeMock>(direction: .directed)
		
		/// THEN: Graph should be empty
		XCTAssertEqual(graph.adjacency, [:])
		XCTAssertEqual(graph.verticeArray, [])
		XCTAssertEqual(graph.verticeDictionary, [:])
		XCTAssertEqual(graph.direction, .directed)
    }

	func test_shouldAddEdge_whenGraphIsEmpty() throws {
		/// GIVEN: A new graph
		let graph = GraphBase<VerticeMock, EdgeMock>(direction: .directed)

		/// AND: Vertices and edges to be added
		let verticeA: VerticeMock = .init(name: "A")
		let verticeB: VerticeMock = .init(name: "B")
		let edgeAB: EdgeMock = .init(weight: 2)

		/// WHEN: Add a new edge between two new vertices
		graph.addEdge(from: verticeA, to: verticeB, edge: edgeAB)
		
		/// THEN: Adjacency matrix should be adjusted
		XCTAssertEqual(try XCTUnwrap(graph.adjacency[verticeA]?[verticeB]), edgeAB)
		XCTAssertEqual(graph.verticeDictionary.count, 2)
		XCTAssertEqual(try XCTUnwrap(graph.verticeDictionary[verticeA]), verticeA)
		XCTAssertEqual(try XCTUnwrap(graph.verticeDictionary[verticeB]), verticeB)
	}
}

struct VerticeMock: Vertice {
	static func < (lhs: VerticeMock, rhs: VerticeMock) -> Bool {
		lhs.name < rhs.name
	}
	
	var name: String
}

struct EdgeMock: Edge {
	var weight: Int
}
