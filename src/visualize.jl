include("Node.jl")

MazeViz=Nothing

mutable struct Maze
    nodes::Matrix{Node}
    visual::Union{MazeViz,Nothing}
    path::Union{Vector{Node},Nothing}
end

# Task 4
function visualize(matrix::Matrix{Node}, Path::Union{Vector{Node},Nothing})
    width = size(matrix)[2]
    height = size(matrix)[1]
    wall = "██"
    path = "░░"
    blank = "  "
    output = ""
    s=Vector{Int}[node.key for node in Path]

    n=Vector{Union{Vector{Int},Nothing}}[[node.neighbors[i].key for i=1:4] for node in matrix]
    for node in n
        for i=1:4
            if node[i]==[0] || node[i]==[-1]
                node[i]=nothing  
            end
        end
    end
    
    for i=1:2*width+1
        output *= wall
    end
    output*="\n"
    
    for i=1:height
        for k=1:2
            output*=wall
            if k==1
                for j=1:width
                    if [j,i] in s
                        output*=path
                    else
                        output*=blank
                    end
                    if n[i,j][2]===nothing
                        output*=wall
                    elseif (n[i,j][2] in s) & ([j,i] in s)
                        output*=path
                    else
                        output*=blank
                    end   
                end
                output*="\n"

            else
                for j=1:width
                    if n[i,j][3]===nothing
                        output*=wall
                    elseif (n[i,j][3] in s) & ([j,i] in s)
                        
                        output*=path
                    else
                        output*=blank
                    end
                    output*=wall
                end

            end 
        end         
        output*="\n"
    end

    return output
end

function Base.show(io::IO, maze::Maze)
    print(visualize(maze.nodes,maze.path))
end
