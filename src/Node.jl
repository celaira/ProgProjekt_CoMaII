mutable struct Node     
    key::Vector{Int}
    neighbors::Vector{Union{Node,Nothing}}      # order: up, right, down, left 
    last::Union{Node,Nothing}                   # used in maze()
end

function neighbors(node::Node)::Vector{Union{Node,Nothing}} # already usable because of struct Node, unneccessary
    return node.neighbors
end