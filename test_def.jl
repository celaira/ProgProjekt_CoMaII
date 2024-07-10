include("src/MazeGeneration.jl")  # path to our module

using .MazeGeneration               # import our module
using Test                          # import julia's test module

@testset "Struct Tests" begin                                    # STRUCT TESTS

    @testset "Node" begin                                        # testing NodeStruct
        node = Node([1, 2], [nothing for _ in 1:4], nothing)
        @test node.key == [1, 2]
        @test length(node.neighbors) == 4
        @test node.last === nothing
    end

    @testset "Maze" begin                                        # testing MazeStruct
        maze_nodes = Matrix{Node}(undef, 3, 3)
        maze = Maze(maze_nodes, nothing, nothing)
        
        @test size(maze.nodes) == (3, 3)
        @test maze.visual === nothing
        @test maze.path === nothing
    end
end

@testset "Function Tests" begin                                         # FUNCTION TESTS

    @testset "maze" begin                                               # testing maze
        maze_large = maze(11,8)
        @test size(maze_large.nodes) == (11,8)
    end

    @testset "solve" begin                                              # testing solve
        solved_maze = solve(maze(8,7))
        @test length(solved_maze.path) > 0
        @test unique(solved_maze.path) == solved_maze.path              # all nodes in path only once
    end

    @testset "visualize" begin                                          # testing visualize
        maze_small = maze(5, 5)
        solved_maze_small = solve(maze_small)
        
        # capture output
        stdout = stdout                     # standard output stream.
        redirect_stdout()                   # Any printed-output will be redirected into buffer
        visualize(solved_maze_small)
        output = redirect_stdout(stdout)    # redirect it back for printing the output
        
        # output should contain ██ and ░░
        @test occursin("██", output)
        @test occursin("░░", output)
    end