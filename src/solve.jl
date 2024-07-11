include("maze.jl")

# task 5
# function: to find a path in labyrinth with the right hand rule
# input: Maze; output: Maze with .path
function solve(maze::Maze)::Maze

    track=2                                 # heading positions: 0 up, 1 right, 2 down, 3 left; beginn facing downwards (2)
    result=Vector{Node}()                   # neighbors: 1 upper, 2 right, 3 lower, 4 left
    width = size(maze.nodes)[2]
    height = size(maze.nodes)[1] 
    start=rand(1:length(maze.nodes))        # randomize start-point
    #start=
    ende=rand(1:length(maze.nodes))         # randomize end-point
    #ende=
    node_index_map = Dict{Int, Int}(i=>-1 for i=1:width*height)         # dictionary to track first occurrence index of each node key

    while start!=ende
        if node_index_map[start]==-1                # not visited yet
            push!(result, maze.nodes[start])
            node_index_map[start]=length(result)    
        else                                        # already visited
            index=node_index_map[start]
            result=result[1:index]                  # delete the entries after the first occurence of current start
        end
            
        if track==2         #current direction: facing downwards
            if maze.nodes[start].neighbors[4].key !=[0] && maze.nodes[start].neighbors[4].key !=[-1]    	# go left start - width > 0 && 
                track=3         # turn heading position (to left)
                start-=height    # going to the (left) neighbor

            elseif maze.nodes[start].neighbors[3].key !=[0] && maze.nodes[start].neighbors[3].key !=[-1]    # go down start % width != 0 && 
                start+=1

            elseif maze.nodes[start].neighbors[2].key !=[0] && maze.nodes[start].neighbors[2].key !=[-1]    # go right start + width <= length(maze.nodes) && 
                track=1
                start+=height

            elseif maze.nodes[start].neighbors[1].key !=[0] && maze.nodes[start].neighbors[1].key !=[-1]    # go up start % width != 1 && 
                track=0
                start-=1
            end

        elseif track==3     #current direction: facing left
            if maze.nodes[start].neighbors[1].key !=[0] && maze.nodes[start].neighbors[1].key !=[-1]    	# go up
                track=0
                start-=1

            elseif maze.nodes[start].neighbors[4].key !=[0] && maze.nodes[start].neighbors[4].key !=[-1]    # go left
                start-=height

            elseif maze.nodes[start].neighbors[3].key !=[0] && maze.nodes[start].neighbors[3].key !=[-1]    # go down
                track=2
                start+=1

            elseif maze.nodes[start].neighbors[2].key !=[0] && maze.nodes[start].neighbors[2].key !=[-1]    # go right
                track=1
                start+=height
            end

        elseif track==1     #current direction: facing right
            if maze.nodes[start].neighbors[3].key !=[0] && maze.nodes[start].neighbors[3].key !=[-1]        # go down
                track=2
                start+=1

            elseif maze.nodes[start].neighbors[2].key !=[0] && maze.nodes[start].neighbors[2].key !=[-1]    # go right
                start+=height

            elseif maze.nodes[start].neighbors[1].key !=[0] && maze.nodes[start].neighbors[1].key !=[-1]    # go up
                track=0
                start-=1

            elseif maze.nodes[start].neighbors[4].key  !=[0] && maze.nodes[start].neighbors[4].key !=[-1]   # go left
                track=3
                start-=height
            end

        elseif track==0     #current direction: facing upwards
            if maze.nodes[start].neighbors[2].key !=[0] && maze.nodes[start].neighbors[2].key !=[-1]        # go right
                track=1
                start+=height

            elseif maze.nodes[start].neighbors[1].key !=[0] && maze.nodes[start].neighbors[1].key !=[-1]    # go up
                start-=1

            elseif maze.nodes[start].neighbors[4].key !=[0] && maze.nodes[start].neighbors[4].key !=[-1]    # go left
                track=3
                start-=height

            elseif maze.nodes[start].neighbors[3].key !=[0] && maze.nodes[start].neighbors[3].key !=[-1]    # go down
                track=2
                start+=1
            end
        end
    end

    push!(result, maze.nodes[start])
    m=Maze(maze.nodes, maze.visual,result)     # return Maze with maze.path= result
    return m
end