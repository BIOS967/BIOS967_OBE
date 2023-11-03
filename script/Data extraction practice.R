install.packages("Rpdb")
library(Rpdb)
??Rpdb
Resolution1 = searchPDB(resolution = "0.5")
x = read.pdb(system.file("examples/PCBM_ODCB.pdb", package = "Rpdb"))
## Visualize the PDB file
visualize(x, mode=NULL)

## From Cartesian to fractional coordinates and Vice versa
x = xyz2abc(x)
basis(x)
natom(x, x$atoms$resid)
range(x)
centres(x)
x = abc2xyz(x)
basis(x)
natom(x, x$atoms$resid)
range(x)
centres(x)

## Split and unsplit
F = x$atoms$resid
x = split(x, F)
x = unsplit(x, F)
x
head(x)

install.packages("rentrez")
library(rentrez)
??rentrez
# Search for PDB entries based on a specific keyword
pdb_entries <- pdbfetch(keyword = "7RKO", format = "xml")
entrez_dbs()
entrez_db_summary("structure")
entrez_db_searchable("sra")
library(devtools)

##Installing and loading bio3d package
install.packages("bio3d", dependencies = TRUE)
library(bio3d)
pdb1=read.pdb("data/pdb_files/Plasmodium/1a3o.pdb")
str(pdb1)
pdb1

#to find attributes of a pdb file
attributes(pdb1)

#to access specific attribute
pdb1$remark
head(pdb1$atom)

#other packages needed
library(ggplot2)
install.packages("ggrepe1")
install.packages("devtools")
install.packages("BiocManager")
BiocManager::install("msa")
a
devtools::install_bitbucket("Grantlab/bio3d-view")
maleria = get.seq("1a3o_A")
maleria
#blast or hmmer search
maleria_blast = blast.pdb(maleria)

#plotting the summary search result of the above. Note this generated a cuttoff based on the e-value. This will remove duplicated structures to our query structure. We can use attributes(hits$pdb.id) to know if we have duplicate
hits = plot(maleria_blast)

hits = NULL
attributes(hits$pdb.id)

#downloading related pdb files. Note that download all the blast structures, save them in path = pdbs and unzip them
files = get.pdb(hits$pdb.id, path = "pdbs", split = TRUE, gzip = TRUE)

#align and superpose structure using pdbaln
#align related structures
pdbs =pdbaln(files, fit = TRUE, exefile="msa" )

#selecting vectors containing PDB codes for figure axis
ids = basename.pdb(pdbs$id)
ids

#draw schematic alignment view. The white represent where there is no alignment while the gray represent areas that are aligned and the red bar represent conserved region in the aligned sequences.
plot(pdbs, labels = ids)

#viewing superposed structures using  bio3d.view()
library(Rpdb)
library(rgl)
visualize(pdbs)
view3d(pdbs)
view(pdbs)
