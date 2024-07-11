include("Node.jl")

mutable struct MazeViz                  # not used in our project, unneccessary
    output::Union{String,Nothing}
end

mutable struct Maze
    nodes::Matrix{Node}
    visual::Union{MazeViz,Nothing}
    path::Union{Vector{Node},Nothing}
end

# Task 4
function visualize(matrix::Matrix{Node}, Path::Union{Vector{Node},Nothing}) # Funktion zur visualisierung
    width = size(matrix)[2]
    height = size(matrix)[1]
    wall = "██"
    path = "░░"
    blank = "  "
    output = ""
    if Path===nothing
        s=[]
    else
        s=Vector{Int}[node.key for node in Path] # um in späterer abfrage den Path zu erstellen
    end

    n=Vector{Union{Vector{Int},Nothing}}[[node.neighbors[i].key for i=1:4] for node in matrix] # Alle Nodes
    for node in n # geht alle Nodes durch
        for i=1:4
            if node[i]==[0] || node[i]==[-1] # Falls Nodes keine Nachbarn haben -> setzt auf Nothing
                node[i]=nothing  
            end
        end
    end
    
    for i=1:2*width+1 # obere Wand
        output *= wall
    end
    output*="\n" # Zeilenumbruch
    
    for i=1:height # geht jede Zeile durch
        for k=1:2 # macht immer zwei Dinge
            output*=wall
            if k==1 # das erste geht die ungeraden Felder durch
                for j=1:width # prüft ob Feld ein Path, Wand oder frei ist
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

            else # das zweite geht die geraden Felder durch
                for j=1:width # prüft für jedes Feld ob path, wand oder frei
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

function Base.show(io::IO, maze::Maze)          # automatic visualization of Maze's with IO-Buffer
    print(visualize(maze.nodes,maze.path))
end
