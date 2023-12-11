library(ggplot2)
library(gapminder)
library(dplyr)
library(gifski)
library(gganimate)
library(patchwork)
library(bio3d)
library(msa)
library(bio3d.view)

pdb <- get.seq("1ca2")
blast <- blast.pdb(pdb)
plot.blast(blast)
hits <- plot(blast, cutoff = 500)
hits$pdb.id
head(hits$pdb.id)
# Retrieve data from PDB
files <- get.pdb(hits$pdb.id, path = "pdbs", split = TRUE, gzip = TRUE)
# Align structure files
pdbs <- pdbaln(files, fit=TRUE, exefile="msa")
# Visualize alignment
plot(pdbs, labels=ids)
# Visualize alignment
ids <- basename.pdb(pdbs$id)
plot(pdbs, labels=ids)
# calculate conserved domain
cons <- conserv(pdbs, method = "entropy22")
# SSE annotation
sse <- pdbs2sse(pdbs, ind = l, rm.gaps = FALSE)
# SSE annotation
sse <- pdbs2sse(pdbs, ind = 1, rm.gaps = FALSE)
plotb3(cons, sse = sse, ylab = "sequence entropy")
anno <- pdb.annotate(ids)
print(unique(anno$source))
# remove structure with missing residues
conn <- inspect.connectivity(pdbs, cut = 4.05)
trim <- trim.pdbs(pdbs, row.inds=which(conn))
# which structures were omitted?
which(!conn)
# to remove conformational redundant structures
rd <- filter.rmsd(trim$xyz, cutoff = 0.1, fit = TRUE)
trim <- trim.pdbs(trim, row.inds = rd$ind)
head(trim)
trim$id
# list of PDB codes of our final selection
#ca.ids <- unlist(strsplit(basename(ca.pdbs$id), split=".pdb"))
ids <- unlist(strsplit(basename(trim$id), split=".pdb"))
# Visualize my pdb data
print(trim, alignment = FALSE)
# locate invariant core
core <- core.find(trim)
# Now that we have determined the core, we can superimpose all structures to core
trim$xyz = pdbfit(trim, core$c0.5A.xyz)
pc.xray <- pca(trim)
# Now that we have determined the core, we can superimpose all structures to core
trim$xyz = pdbfit(trim, core$c0.5A.xyz)
# Identifying and removing gaps
gap.pos <- gap.inspect(trim$xyz)
gap.res <- gap.inspect(trim$ali)
# Perform PCA
pc.xray <- pca.xyz(trim$xyz[,gap.pos$f.inds])
plot(pc.xray)
# calculate RMSD
rd <- rmsd(trim)
# structure based clustering
hc.rd <- hclust(dist(rd))
grps.rd <- cutree(hc.rd, k=4)
plot(ca.xray$z[,1:2], col="gray50", pch=16, cex=1.3,
ylab="Pricipal Component 2", xlab="Principal Component 1")
points(pc.xray$z[,1:2], col=grps.rd, pch=16, cex=0.9)

plot(pc.xray$z[,2:3], col="gray50", pch=16, cex=1.3,
     ylab="Pricipal Component 2", xlab="Principal Component 3")
points(pc.xray$z[,2:3], col=grps.rd, pch=16, cex=0.9)
# left-click on a point to label and right-click to end
identify(pc.xray$z[, 1:2], labels=basename.pdb(trim$id))
# left-click on a point to label and right-click to end
identify(pc.xray$z[, 1:2], labels=basename.pdb(trim$id))
plot(pc.xray$z[,1:2], col="gray50", pch=16, cex=1.3,
ylab="Pricipal Component 2", xlab="Principal Component 1")
points(pc.xray$z[,1:2], col=grps.rd, pch=16, cex=0.9)
# left-click on a point to label and right-click to end
identify(pc.xray$z[, 1:2], labels=basename.pdb(trim$id))
# To visualize use
pc1 <- mktrj(pc.xray, pc=1, file="pc_1.pdb")
view(pc1)
library(ggplot2)
library(ggrepel)
# Labeling IDs to the plot for PC 1 and 2
df <- data.frame(x=pc.xray$z[,1], y=pc.xray$z[,2])
col <- as.factor(grps.rd)
# plot of PC2 against PC1
p <- ggplot(df, aes(x,y))+
geom_point(aes(col=col), size=2) +
xlab("Principal Component 1") +
ylab("Principal Component 2") +
scale_color_discrete(name="Clusters") +
geom_text_repel(aes(label=ids))
p
# Labeling IDs to the plot for PC 1 and 2
df <- data.frame(x=pc.xray$z[,2], y=pc.xray$z[,3])
col <- as.factor(grps.rd)
# plot of PC2 against PC1
q <- ggplot(df, aes(x,y))+
geom_point(aes(col=col), size=2) +
xlab("Principal Component 1") +
ylab("Principal Component 2") +
scale_color_discrete(name="Clusters") +
geom_text_repel(aes(label=ids))
q
# Labeling IDs to the plot for PC 1 and 2
df <- data.frame(x=pc.xray$z[,2], y=pc.xray$z[,3], ids=ids)
col <- as.factor(grps.rd)
# plot of PC2 against PC1
q <- ggplot(df, aes(x,y))+
geom_point(aes(col=col), size=2) +
xlab("Principal Component 1") +
ylab("Principal Component 2") +
scale_color_discrete(name="Clusters") +
geom_text_repel(aes(label=ids), max.overlaps = 20) +
theme(legend.position = "none")
q
# Labeling IDs to the plot for PC 1 and 2
df <- data.frame(x=pc.xray$z[,1], y=pc.xray$z[,2], ids=ids)
col <- as.factor(grps.rd)
# plot of PC2 against PC1
p <- ggplot(df, aes(x,y))+
geom_point(aes(col=col), size=2) +
xlab("Principal Component 1") +
ylab("Principal Component 2") +
scale_color_discrete(name="Clusters") +
geom_text_repel(aes(label=ids), max.overlaps = 20) +
theme(legend.position = "none")
p
# plot of PC2 against PC1
p <- ggplot(df, aes(x,y))+
geom_point(aes(col=col), size=2) +
xlab("Principal Component 1") +
ylab("Principal Component 2") +
scale_color_discrete(name="Clusters") +
geom_text_repel(aes(label=ids), max.overlaps = 10) +
theme(legend.position = "none")
p
mktrj(pc.xray, pc=1,
resno=trim$resno[1, gap.res$f.inds],
resid=trim$resid[1, gap.res$f.inds])
# clustering by conformation
pdbfit(trim.pdbs(ca.trim, row.inds = which(grps.psd==1)), outpath="grps1") ## closed
# clustering by conformation
pdbfit(trim.pdbs(trim, row.inds = which(grps.rd==1)), outpath="grps1") ## closed
modes <- nma(trim, rm.gaps=TRUE, ncore=4)
install.packages("bigmemory")
library(bigmemory)
modes <- nma(trim, rm.gaps=TRUE, ncore=4)
modes <- nma(trim, rm.gaps=TRUE, ncore=4, bigmem=TRUE)
modes <- nma(trim, rm.gaps=TRUE, ncore=1, bigmem=TRUE)
plot(modes)
print(modes)
plot(modes, pdbs=trim, col=grps.rd, label=NULL)
hc.nma <- hclust(as.dist(1-modes$rmsip))
grps.nma <- cutree(hc.nma, k=4)
heatmap(1-modes$rmsip, distfun = as.dist, labRow = ids, labCol = ids,
ColSideColors = as.character(grps.nma), RowSideColors = as.character(grps.nma))
cols <- grps.rd
cols[which(cols!=1 & cols!=2)]=NA
plot(modes, pdbs=trim, col=cols, signif=TRUE)
# Similarity of atomic fluctuations
sip <- sip(modes)
hc.sip <- hclust(as.dist(1-sip), method = "ward.D2")
grps.sip <- cutree(hc.sip, k=3)
# Similarity of atomic fluctuations
sip <- sip(modes)
hc.sip <- hclust(as.dist(1-sip), method = "ward.D2")
grps.sip <- cutree(hc.sip, k=4)
# Squared inner product (SIP) plot
hclustplot(hc.sip, k=4, colors = grps.rd, labels = ids, cex=0.7, main="SIP", fillbox = FALSE)
par(fig=c(.65, 1, .45, 1), new = TRUE)
plot(pc.xray$z[,1:2], col="grey50", pch=16, cex=1.1,
ylab="", xlab="", axes=FALSE, bg="red")
points(pc.xray$z[,1:2], col=grps.sip, pch=16, cex=0.9)
box()
# Root mean squared inner product (RMSIP)
rmsip <- rmsip(modes)
hc.rmsip <- hclust(dist(1-rmsip), method = "ward.D2")
grps.rmsip <- cutree(hc.rmsip, k=4)
hclustplot(hc.rmsip, k=4, colors = grps.rd, labels = ids, cex=0.7, main="RMSIP", fillbox = FALSE)
par(fig=c(.65, 1, .45, 1), new = TRUE)
plot(pc.xray$z[,1:2], col="grey50", pch=16, cex=1.1,
ylab="", xlab="", axes=FALSE, bg="red")
points(pc.xray$z[,1:2], col=grps.sip, pch=16, cex=0.9)
box()
# covariance overlap
co <- covsoverlap(modes, subset=200)
hc.co <- hclust(as.dist(1-co), method = "ward.D2")
grps.co <- cutree(hc.co, k=4)
hclustplot(hc.co, k=4, colors = grps.rd, labels = ids, cex=0.7, main="covariance overlap", fillbox = FALSE)
par(fig=c(.65, 1, .45, 1), new = TRUE)
plot(pc.xray$z[,1:2], col="grey50", pch=16, cex=1.1,
ylab="", xlab="", axes=FALSE, bg="red")
points(pc.xray$z[,1:2], col=grps.sip, pch=16, cex=0.9)
box()



