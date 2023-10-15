//
//  Graph.swift
//  Graph
//
//  Created by Thomas Segkoulis on 15.10.23.
//

public protocol Graph: AnyObject {
	associatedtype VerticeType: Vertice
	associatedtype EdgeType: Edge

	// MARK: - Properties

	var adjacency: [VerticeType: [VerticeType: EdgeType]] { get set }
	var verticeDictionary: [VerticeType: VerticeType] { get set }
	var direction: GraphDirection { get set }
}

public extension Graph {

	var verticeArray: [VerticeType] {
		Array(verticeDictionary.keys)
	}

	func addEdge(from lhs: VerticeType, to rhs: VerticeType, edge: EdgeType) {
		var updatedAdjacency: [VerticeType: EdgeType] = adjacency[lhs] ?? [:]
		updatedAdjacency[rhs] = edge
		adjacency[lhs] = updatedAdjacency
		addVertices(vertices: [lhs, rhs])
	}
	
	func existsEdge(from lhs: VerticeType, to rhs: VerticeType) -> Bool {
		adjacency[lhs]?[rhs] != nil
	}
	
	func existsVertice(vertice: VerticeType) -> Bool {
		verticeDictionary[vertice] != nil
	}

	func addVertice(vertice: VerticeType) {
		verticeDictionary[vertice] = vertice
	}

	func addVertices(vertices: [VerticeType]) {
		vertices.forEach {
			addVertice(vertice: $0)
		}
	}
}
