//
//  GraphBase.swift
//  Graph
//
//  Created by Thomas Segkoulis on 15.10.23.
//

import Foundation

public class GraphBase<VerticeType: Vertice, EdgeType: Edge>: Graph {
	public var direction: GraphDirection
	public var adjacency: [VerticeType: [VerticeType : EdgeType]] = [:]
	public var verticeDictionary: [VerticeType: VerticeType] = [:]
	public var verticeArray: [VerticeType] = []

	public init(direction: GraphDirection) {
		self.direction = direction
	}
}
