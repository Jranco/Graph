//
//  GraphBase.swift
//  Graph
//
//  Created by Thomas Segkoulis on 15.10.23.
//

import Foundation

class GraphBase<VerticeType: Vertice, EdgeType: Edge>: Graph {
	var direction: GraphDirection
	var adjacency: [VerticeType: [VerticeType : EdgeType]] = [:]
	var verticeDictionary: [VerticeType: VerticeType] = [:]
	var verticeArray: [VerticeType] = []

	init(direction: GraphDirection) {
		self.direction = direction
	}
}
