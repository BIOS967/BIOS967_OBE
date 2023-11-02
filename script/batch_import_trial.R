

install.packages("bio3d")
library(bio3d)

pdb1=read.pdb("data/pdb_files/1rp0.pdb.gz")
str(pdb1)
pdb1$remark
summary(pdb1)
str(summary(pdb1))
  #read multiple pdb files

files_to_import=list.files("data/pdb_files", full.names = T)
pdb_list=lapply(files_to_import, function(x) read.pdb(x))


#####
#you can read the pdb file just as a text file this way:
p1=scan(file="data/pdb_files/1rp0.pdb.gz", what="text")
p2=scan(file="data/pdb_files/7rk0.pdb.gz", what="text")

#this will read the file by each line and tab. So a lot of this will be just one word.
p1

#then, you can just search for "RESOLUTION." with the period at the end. The str_which() function will tell you which item in "p1" gives you the exact match.
library(stringr)
str_which(p1, "RESOLUTION.")

#The item that follows that is the the resolution, so you can look that up by using p1[ ], and adding one to the item number of "RESOLUTION." This should give you "1.60"
p1[str_which(p1, "RESOLUTION.")+1]

#so you just have to save that as a number
as.numeric(p1[str_which(p1, "RESOLUTION.")+1])

#This should then work on other pdb files, like the second one I imported above.
as.numeric(p2[str_which(p2, "RESOLUTION.")+1])

#With this, you should be able to scale up and batch import and process a bunch of pdb files. I'll leave that to you to try!
