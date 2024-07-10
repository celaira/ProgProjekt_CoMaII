mutable struct Node
    key::Vector{Int}
    neighbors::Vector{Union{Node,Nothing}}
    last::Union{Node,Nothing}
end

function neighbors(node::Node)::Vector{Union{Node,Nothing}}
    return node.neighbors
end