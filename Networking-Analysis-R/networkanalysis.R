# ---
# title: "Basic Network Analysis Using R (workshop material)"
# author: "Justin Ho"
# last updated: "27/05/2021"
# ---


# =================================== Setting Up =======================================

# Installing the packages
install.packages("igraph")
install.packages("ggnetwork")
install.packages("visNetwork")

# Loading the necessary packages
library(igraph)

# =================================== Reading networks  =======================================

# Networks are usually stored as one of the two forms: edge list and adjacency_matrix

# Edge List
# Below you can find a toy example of a edge list, it is stored as a two-column matrix, each row defines one edge.
# The left hand side is the starting vertex and the right hand side is the ending vertex.
friend_edges<- rbind(c("Thomas","Arthur"),
                     c("Thomas","John"),
                     c("Thomas","Grace"),
                     c("Arthur","John"),
                     c("Arthur","Polly"),
                     c("John","Polly"),
                     c("John","Esme"))
g <- graph_from_edgelist(friend_edges, directed = FALSE)
plot(g)

# Below is another way of stroing a network, adjacency matrix.
# It is a square matrix with each row/column represents one vertex.
# The number in the "cell" represents the edges, 1 means there is an edge, 0 means otherwise.
friend_matrix <-matrix(c(0,1,1,0,1,0,
                         1,0,1,1,0,0,
                         1,1,0,1,0,1,
                         0,1,1,0,0,0,
                         1,0,0,0,0,0,
                         0,0,1,0,0,0),
                       nrow = 6, ncol = 6, byrow = TRUE)
rownames(friend_matrix) <-c("Thomas","Arthur","John","Polly","Grace","Esme")
colnames(friend_matrix) <-c("Thomas","Arthur","John","Polly","Grace","Esme")

g <- graph_from_adjacency_matrix(friend_matrix, mode = "undirected")

# You can call the object to see some basic information
g

# =================================== Basic Visualisation  =======================================
plot(g)

#Add vertex attribute
V(g)$gender <- c("M","M","M","F","F","F")
g

# Change the colour
# Note: the ifelse() function
V(g)$color <- c("red","red","red","green","green","green")
plot(g)

# Another way to change the colour
V(g)$color[c(3,5)] <- "grey"
plot(g)

# Plotting parameters
# NODES	 
# vertex.color          Node color
# vertex.frame.color	  Node border color
# vertex.shape	        One of “none”, “circle”, “square”, “csquare”, “rectangle”
#                       “crectangle”, “vrectangle”, “pie”, “raster”, or “sphere”
# vertex.size	          Size of the node (default is 15)
# vertex.size2          The second size of the node (e.g. for a rectangle)
# vertex.label          Character vector used to label the nodes
# vertex.label.family   Font family of the label (e.g.“Times”, “Helvetica”)
# vertex.label.font     Font: 1 plain, 2 bold, 3, italic, 4 bold italic, 5 symbol
# vertex.label.cex      Font size (multiplication factor, device-dependent)
# vertex.label.dist     Distance between the label and the vertex
# vertex.label.degree   The position of the label in relation to the vertex,
#                       where 0 right, “pi” is left, “pi/2” is below, and “-pi/2” is above
# EDGES	 
# edge.color	          Edge color
# edge.width	          Edge width, defaults to 1
# edge.arrow.size	      Arrow size, defaults to 1
# edge.arrow.width	    Arrow width, defaults to 1
# edge.lty	            Line type, could be 0 or “blank”, 1 or “solid”, 2 or “dashed”,
#                       3 or “dotted”, 4 or “dotdash”, 5 or “longdash”, 6 or “twodash”
# edge.label            Character vector used to label edges
# edge.label.family     Font family of the label (e.g.“Times”, “Helvetica”)
# edge.label.font	      Font: 1 plain, 2 bold, 3, italic, 4 bold italic, 5 symbol
# edge.label.cex        Font size for edge labels
# edge.curved	          Edge curvature, range 0-1 (FALSE sets it to 0, TRUE to 0.5)
# arrow.mode            Vector specifying whether edges should have arrows,
#                       possible values: 0 no arrow, 1 back, 2 forward, 3 both
# OTHER	 
# margin                Empty space margins around the plot, vector with length 4
# frame                 if TRUE, the plot will be framed
# main                  If set, adds a title to the plot
# sub                   If set, adds a subtitle to the plot
# Source: https://kateto.net/networks-r-igraph
plot(g, layout = layout_with_fr, edge.arrow.size=.5, 
     vertex.color="orange", vertex.size=15, 
     vertex.frame.color="white", vertex.label.color="black", 
     vertex.label.cex=0.8, edge.curved=0.2) 

# Or if you want to go fancy...
# install.packages("visNetwork")
library(visNetwork)
visIgraph(g, layout = "layout_with_fr") 

# =================================== Network Descriptives  =======================================

# Edge count
ecount(g)

# Vertex count
vcount(g)

# A network diameter is the longest geodesic distance (length of the shortest path between two nodes) in the network.
diameter(g, directed=F, weights=NA)

# The length of all the shortest paths
distances(g)
mean_distance(g)

# The ratio of the number of edges and the number of possible edges.
edge_density(g)

# ratio of triangles (direction disregarded) to connected triples.
transitivity(g, type="global")

# Calculating centrality

# Degree: number of edges
deg <- degree(g)
plot(g, vertex.size=deg*10)

# Closeness: distance to others in the graph
closeness <- closeness(g)
plot(g, vertex.size=closeness*100)

# Betweenness: centrality based on a broker position connecting others
betweenness <- betweenness(g)
plot(g, vertex.size=betweenness*10)

# Page Rank
page_rank <- page_rank(g)
plot(g, vertex.size=page_rank$vector*100)


# =================================== Reading networks  =======================================

# This dataset contains the corporate interlocks in Scotland in the beginning of the twentieth century (1904-5). 
# In the nineteenth century, joint stock companies were established to raise capital for heavy industry and textile industry.
# Joint stock companies are owned by the shareholders, who are represented by a board of directors.
# This opens up the possibility of interlocking directorates. By the end of the nineteenth century, 
# joint stock companies had become the predominant form of business enterprise at the expense of private family businesses. 
# Families, however, still exercised control through ownership and directorships.

# The data are taken from the book The Anatomy of Scottish Capital by John Scott and Michael Hughes. 
# The vertices are the directors of the largest joint stock companies in Scotland in 1904-5.
# The edges represent co-directorates (ie. if they are shareholders of the same company)

# Reading the data
scotland_edgelist <- read.csv("data/scotland_edgelist.csv")
g <- graph_from_data_frame(scotland_edgelist, directed = F)

# Vertex count
vcount(g)

# Edge count
ecount(g)

# A network diameter is the longest geodesic distance (length of the shortest path between two nodes) in the network.
diameter(g, directed=F, weights=NA)

# The length of all the shortest paths
distances(g)
mean_distance(g)

# The ratio of the number of edges and the number of possible edges.
edge_density(g)

# ratio of triangles (direction disregarded) to connected triples.
transitivity(g, type="global")

# Degree: number of edges
V(g)$degree <- degree(g)

# Closeness: distance to others in the graph
V(g)$closeness <- closeness(g)

# Betweenness: centrality based on a broker position connecting others
V(g)$betweenness <- betweenness(g)

# Page Rank
page_rank <- page_rank(g)
V(g)$page_rank <- page_rank$vector


# What if I want to find the vertices with highest degree?
# Export as dataframe
vertex_df <- igraph::as_data_frame(g, "vertices")

# Use dplyr method to get the top 5
vertex_df %>% dplyr::slice_max(degree, n = 5)

# =================================== Network Visualisation (con't)  =======================================

# V(g)$name[degree(g) > 20]

# Let's see...
plot(g)

# How about removing labels?
plot(g, vertex.label = "")

plot(g, layout = layout_with_fr, vertex.label = "", edge.arrow.size=.5, 
     vertex.color="orange", vertex.size=6, 
     vertex.frame.color="white", edge.curved=0.2)

# Introducing layouts

# layouts available in igraph:
# "layout_as_bipartite"  "layout_as_star"       "layout_as_tree"       "layout_components"    "layout_in_circle"    
# "layout_nicely"        "layout_on_grid"       "layout_on_sphere"     "layout_randomly"      "layout_with_dh"      
# "layout_with_drl"      "layout_with_fr"       "layout_with_gem"      "layout_with_graphopt" "layout_with_kk"      
# "layout_with_lgl"      "layout_with_mds"      "layout_with_sugiyama"
# Note: some of them are useful for some cases, some aren't!

layout <- layout_on_grid(g, width = 50)
plot(g, layout = layout, vertex.label = "", vertex.color="orange", vertex.size=6, 
     vertex.frame.color="white", edge.curved=0.2)

layout <- layout_in_circle(g)
plot(g, layout = layout, vertex.label = "", vertex.color="orange", vertex.size=6, 
     vertex.frame.color="white", edge.curved=0.2)

plot(g, layout = layout, vertex.label = "", vertex.color="orange", vertex.size=6, 
     vertex.frame.color="white", edge.curved=0.2, edge.color = adjustcolor("SkyBlue2", alpha.f = .3),
     edge.width = 5)

layout <- layout_with_mds(g)
plot(g, layout = layout, vertex.label = NA, vertex.color="orange", vertex.size=6, 
     vertex.frame.color="white", edge.curved=0.2)

# Better, but still limiting
# It would be great if we could use grammar of graphics, isn't it?
# Introducing ggnetwork!

library(ggplot2)
library(ggnetwork)

# Once you load the package, you can pass a igraph object to ggplot()
ggplot(g, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges() + # Add a edges layer
  geom_nodes() + # Add a nodes layer
  theme_blank()

# And you can build on that:
ggplot(g, layout = with_fr(), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50", alpha = 0.5) +
  geom_nodes(aes(size = degree), alpha = 0.8, color = "skyblue") +
  theme_blank()

# Adding label, but only for certain vertices
ggplot(g, layout = with_fr(), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50", alpha = 0.5, curvature = 0.2) +
  geom_nodes(aes(size = degree, color = ifelse(betweenness > 500, "broker", "other")), alpha = 0.8) +
  geom_nodelabel_repel(aes(label = ifelse(betweenness > 500, name, NA)), alpha = 0.8) +
  theme_blank()


ggplot(g, layout = with_fr(), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50", alpha = 0.5) +
  geom_nodes(aes(size = degree, color = ifelse(betweenness > 500, "broker", "other")), alpha = 0.8) +
  geom_nodelabel_repel(aes(label = ifelse(betweenness > 500, name, NA)), alpha = 0.8) +
  theme_blank()

# Or, go fancy again?
visIgraph(g) %>%
  visOptions(highlightNearest = list(enabled = TRUE,
                                     hover = TRUE),
             nodesIdSelection = list(enabled = TRUE))

# See https://datastorm-open.github.io/visNetwork/ for documentation

# =================================== Community Detection =======================================

# A community is a group of vertices that are tightly connected within the group
# and loosely connected with vertices outside the group.

# Let's look at this example:
demo <- rbind(c("A","B"),
              c("A","C"),
              c("B","C"),
              c("D","E"),
              c("D","F"),
              c("E","F"),
              c("A","D"))
demo_graph <- graph_from_edgelist(demo, directed = FALSE)
plot(demo_graph)

# Modularity: the number of edges falling within groups minus 
# the expected number in an equivalent network with edges placed at random.
# Modularity ranges from ‐1 to 1. 
# Positive number means edges inside the group are more than expected.

# Let's compare our demo to a random graph
random_graph <- erdos.renyi.game(n = vcount(demo_graph), 
                                 p.or.m = edge_density(demo_graph), 
                                 type = "gnp")
plot(random_graph)

cluster_louvain(demo_graph)

# One popular method for detecting community is call the Louvain algorithm.
communities_louvain <- cluster_louvain(g)
communities_louvain

# To get the membership of each vertices
membership(communities_louvain)

# Or we can store it as a vertex attribute
V(g)$membership <- membership(communities_louvain)

# Let's colour them by membership
ggplot(g, layout = with_fr(), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50", alpha = 0.5,  curvature = 0.2) +
  geom_nodes(aes(size = betweenness, color = factor(membership)), alpha = 0.8) +
  theme_blank()

# We can also create subgraphs from community
g_sub <- induced_subgraph(g, V(g)$membership == 8)
ggplot(g_sub, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50", alpha = 0.5, curvature = 0.2) +
  geom_nodes(aes(size = degree), alpha = 0.8) +
  geom_nodelabel_repel(aes(label = name, alpha = 0.8)) +
  theme_blank()


# Let's try another algoritrm: Walktrap
communities_walktrap <- cluster_walktrap(g)
V(g)$membership <- membership(communities_walktrap)

ggplot(g, layout = with_fr(), aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_edges(color = "grey50", alpha = 0.5,  curvature = 0.2) +
  geom_nodes(aes(size = betweenness, color = factor(membership)), alpha = 0.8) +
  theme_blank()
