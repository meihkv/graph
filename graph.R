# library(igraph)
# library(tidyverse)
# 
# nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
# 
# links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)
# 
# links <- aggregate(links[,3], links[,-3], sum)
# 
# links <- links[order(links$from, links$to),]
# 
# colnames(links)[4] <- "weight"
# 
# rownames(links) <- NULL
# 
# net <- graph_from_data_frame(d=links, vertices=nodes, directed=T) 
# 
# mean(distances(net, v=V(net)[media==x], to=V(net), weights=NA))
# 
# test = nodes %>% 
#   mutate(mean_dist = unlist(map(media,
#                          function(x) mean(distances(net, v=V(net)[media==x], to=V(net), weights=NA)))
#   ))
# 
# 

# test = test %>% distinct()
# nodes1 = data.frame(id = as.character(unique(c(test$X1,test$X0))))
# 
# links1 = data.frame(to = as.character(test$X0),
#                    from = as.character(test$X1))
# 
# net1 <- graph_from_data_frame(d=links1, vertices=nodes1, directed=F) 
# 
# 
# plot(net1)
# 
# test1 = nodes1 %>% 
#   mutate(mean_dist = unlist(map(id,
#                                 function(x) mean(distances(net1, v=V(net1)[id==x], to=V(net1), weights=NA)))
#   ))

df = read.csv('facebook_combined.txt',sep = ' ')

preprocess_nodes = function (df){
  require(tidyverse)
  require(igraph)
  df = df %>% distinct()
  nodes = data.frame(id = as.character(unique(c(df[,1], df[,2]))),
                     name = as.character(unique(c(df[,1], df[,2]))))
  links = data.frame(to = as.character(df[,1]),
                      from = as.character(df[,2]))
  net <- graph_from_data_frame(d=links, vertices=nodes, directed=F) 
}

net = preprocess_nodes(df)

mean_dist = function(x){
  mean(distances(net, v=V(net)[name==x], to=V(net), weights=NA))
}

mean_dist('1')

nodes = data.frame(id = as.character(unique(c(df[,1], df[,2]))),
                   name = as.character(unique(c(df[,1], df[,2]))))
nodes = nodes %>% 
  mutate(mean_distance = unlist(map(id, mean_dist)))
