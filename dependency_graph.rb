require "bundler"
require "graphviz"

graph = GraphViz.new(:G, type: :digraph)

Bundler.load.specs.each do |spec|
  gem_node = graph.add_nodes(spec.name)
  spec.dependencies.each do |dep|
    dep_node = graph.add_nodes(dep.name)
    graph.add_edges(gem_node, dep_node)
  end
end

graph.output(png: "gem_dependency_graph.png")
puts "Graph saved as gem_dependency_graph.png"
