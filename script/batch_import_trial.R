scan(file="data/pdb_files/1rp0.pdb.gz")

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
