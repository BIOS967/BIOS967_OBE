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
