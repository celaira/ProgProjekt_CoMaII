include("structs.jl")

# task 3
function maze(height::Int, width::Int)::Maze
    #=
    Input:  Höhe und Breite des zu generierenden Maze
    Output: Maze mit beschriebenen Feld nodes
    =#
    nodes = Array{Node}(undef,height,width)                                                                 #generiert leeres Array
    for i=1:length(nodes)                                                                                   #Füllt Array mit Nodes
        nodes[i]=Node([((i-1)÷height)+1,((i-1)%height)+1],[Node([-1],[nothing],nothing) for j=1:4],nothing) #keys in kartesischer Koordinatenform, unbeschriebende Nachbarn -1
    end

    for node in nodes                                                               #Setzt Randnachbarn der Nodes auf 0 um Ränder von Unbeschriebenem unterscheiden zu können
        if node.key[1]==1 node.neighbors[4]=Node([0],[nothing],nothing) end
        if node.key[1]==width node.neighbors[2]=Node([0],[nothing],nothing) end
        if node.key[2]==1 node.neighbors[1]=Node([0],[nothing],nothing) end
        if node.key[2]==height node.neighbors[3]=Node([0],[nothing],nothing) end
    end

    V=Vector{Int}[[0]]                  #Liste bereits besuchter Knoten
    node=nodes[rand(1:length(nodes))]   #Startpunkt der Evaluation

    while length(V)-1<length(nodes)                                             #while-Schleife iteriert bis alle Knoten besucht wurden
        next=[node.key-[1,0],node.key+[1,0],node.key-[0,1],node.key+[0,1]]      #Liste aus Umgebungsknoten des aktuellen Knotens

        for i=1:4                                                               #Ränder in Umgebungsknoten auf 0
            if 0 in next[i] || next[i][1]>width || next[i][2]>height
                next[i]=[0]
            end
        end

        b=true                                                                  #Boolsche Variable ob in Iteration schon ein Schritt gemacht wurde
        bool = [false for j=1:4]                                                #Richtungsvektor (oben,rechts,unten,links)
        bool[rand(1:4)]=true
        pos= (node.key[1]-1)*height+node.key[2]                                 #Kodierung der kartesischen Position in Int für Vektoraufruf

        if issubset(next,V)==false                                              #Wenn es noch unbesuchte Nachbarn des aktuellen Knotens gibt

            if  bool[1] & (node.key[2]>1) & b                                   #Wenn Reichtung 'oben' und noch kein Schritt getan wurde                                      
                if ((nodes[pos-1].key in V)==false)#oben                        #Wenn Knoten oberhalb noch nicht besucht wurde            
                    node.neighbors[1]=nodes[pos-1]                              #Setze oberen Nachbarn
                    if (node.key in V)==false                                   #Wenn Knoten nicht bereits besucht wurde
                        push!(V,node.key)                                       #Füge zu besuchten Knoten hinzu
                    end
                    node=nodes[pos-1]                                           #Schritt nach oben
                    pos= (node.key[1]-1)*height+node.key[2]                     #Positionsupdate
                    node.last=nodes[pos+1]                                      #Setze letzten Knoten um später Weg zurückverfolgen zu können
                    node.neighbors[3]=node.last                                 #Setze von neuem Knoten unteren Nachbarn
                    b=false                                                     #Ändere Boolsche Variable
                end
            end

            if bool[2] & (node.key[1]<width) & b                                #Analog zu den letzten 13 Zeilen
                if ((nodes[pos+height].key in V)==false)#rechts
                    node.neighbors[2]=nodes[pos+height]
                    if (node.key in V)==false
                        push!(V,node.key)
                    end
                    node=nodes[pos+height]
                    pos= (node.key[1]-1)*height+node.key[2]
                    node.last=nodes[pos-height]
                    node.neighbors[4]=node.last
                    b=false
                end
            end

            if bool[3] & (node.key[2]<height) & b
                if ((nodes[pos+1].key in V)==false)#unten
                    node.neighbors[3]=nodes[pos+1]
                    if (node.key in V)==false
                        push!(V,node.key)
                    end
                    node=nodes[pos+1]
                    pos= (node.key[1]-1)*height+node.key[2]
                    node.last=nodes[pos-1]
                    node.neighbors[1]=node.last
                    b=false
                end
            end

            if bool[4] & (node.key[1]>1) & b
                if ((nodes[pos-height].key in V)==false)#links
                    node.neighbors[4]=nodes[pos-height]
                    if (node.key in V)==false
                        push!(V,node.key)
                    end
                    node=nodes[pos-height]
                    pos= (node.key[1]-1)*height+node.key[2]
                    node.last=nodes[pos+height]
                    node.neighbors[2]=node.last
                    b=false
                end
            end

        else                                                                    #Wenn kein unbesuchter Knoten unter den Nachbarn
            if (node.key in V)==false                                           #Wenn aktueller Knoten noch nicht besucht
                push!(V,node.key)                                               #Füge zu Besuchte hinzu
            end
            node=node.last                                                      #Schritt zurück
        end
    end

    return Maze(nodes,nothing,nothing)

    #=
    n=Vector{Union{Vector{Int},Nothing}}[[node.neighbors[i].key for i=1:4] for node in nodes]
    for node in n
        for i=1:4
            if node[i]==[0] || node[i]==[-1]
                node[i]=nothing  
            end
        end
    end
    print(n)
    =#
end