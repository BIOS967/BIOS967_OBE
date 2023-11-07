

install.packages("bio3d")
library(bio3d)


#####
#you can read the pdb file just as a text file this way:
p1=scan(file="pdbs/1A00.pdb", what="text")


#this will read the file by each line and tab. So a lot of this will be just one word.
p1

#then, you can just search for "RESOLUTION." with the period at the end. The str_which() function will tell you which item in "p1" gives you the exact match.
library(stringr)
str_which(p1, "RESOLUTION.")

#The item that follows that is the the resolution, so you can look that up by using p1[ ], and adding one to the item number of "RESOLUTION." This should give you "1.60"
p1[str_which(p1, "RESOLUTION.")+1]

#so you just have to save that as a number
as.numeric(p1[str_which(p1, "RESOLUTION.")+1])


#now do as list
p1=scan(file="pdbs/1A00.pdb", what="text")
p2=scan(file="pdbs/1A3O.pdb", what="text")
p.list=list(p1, p2)
sapply(p.list, function(x) as.numeric(x[str_which(x, "RESOLUTION.")+1]))
