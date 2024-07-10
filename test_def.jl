include("src/solve.jl")             # immport solve.jl
using Test                          # import julia's test module

@testset "Struct Tests" begin                                    # STRUCT TESTS

    @testset "Node" begin                                        # testing NodeStruct
        node = Node([1, 2], [nothing for _ in 1:4], nothing)
        @test node.key == [1, 2]
        @test length(node.neighbors) == 4
        @test node.last === nothing
    end

    @testset "Maze" begin                                        # testing MazeStruct
        maze_nodes = Matrix{Node}(undef, 3, 4)
        maze = Maze(maze_nodes, nothing, nothing)
        
        @test size(maze.nodes) == (3, 4)
        @test maze.visual === nothing
        @test maze.path === nothing
    end
end

@testset "Function Tests" begin                                         # FUNCTION TESTS

    @testset "maze" begin                                               # testing maze
        maze1 = maze(11,8)
        @test size(maze1.nodes) == (11,8)
    end

    @testset "solve" begin                                              # testing solve
        solved_maze = solve(maze(8,7))
        @test length(solved_maze.path) > 0
        @test unique(solved_maze.path) == solved_maze.path              # all nodes in path only once
    end

    @testset "visualize" begin                                          # testing visualize
        maze1 = maze(5, 7)
        output=visualize(maze1.nodes,maze1.path)

        # output should contain ██
        @test occursin("██", output)
    end
end