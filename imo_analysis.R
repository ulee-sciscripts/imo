library(ggplot2)

gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}

its_level2 <- read.csv("level-2_ITS.csv")
all_metadat <- read.csv("metadata_all.tsv", sep="\t")
all_metadat <- all_metadat[-1,]
all_metadat[,"imo_num"] <- as.numeric(all_metadat[,"imo_num"])
its_metadat <- all_metadat[match(its_level2[,1], all_metadat[,1]),]

its_level2 <- its_level2[-1:-2,]
its_metadat <- its_metadat[-1:-2,]



its_metadat$imo_stage <- factor(its_metadat$imo_stage, levels=c("soil", "imo1", "imo2_d3", "imo2_d7"))

rownames(its_level2) <- its_level2[,1]
its_level2 <- its_level2[,-1]

its_level2_frac <- t(apply(its_level2, 1, function(x) x/sum(x)))

its_comb <- cbind(its_metadat, its_level2_frac)


its_comb_raw <- its_comb[its_comb[,4] == "raw",]
its_comb_sterile <- its_comb[its_comb[,4] == "sterile",]

imo_stag <- factor(c("soil", "imo1", "imo2_d3", "imo2_d7"))

png("oryzae_raw.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(its_comb_raw, aes(imo_stage, k__Fungi.p__Mucoromycota, fill=imo_stage)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE)+ coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("R. oryzae over time (raw)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("oryzae_raw_orig.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(its_comb_raw, aes(imo_stage, k__Fungi.p__Mucoromycota, fill=location)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("R. oryzae over time (raw)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("oryzae_raw_scp.png", width=2400*0.75, height=2400, res=600, pointsize=3)

ggplot(its_comb_raw[its_comb_raw$location == "SCP",], aes(imo_stage, k__Fungi.p__Mucoromycota, fill=location)) + geom_boxplot(fill=gg_color_hue(3)[3]) + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) + geom_line(aes(group=location_detail)) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("R. oryzae over time (SCP)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("oryzae_sterile.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(its_comb_sterile, aes(imo_stage, k__Fungi.p__Mucoromycota, fill=imo_stage)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) + geom_line(aes(group=location_detail)) + coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("R. oryzae over time (sterile)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

temp <- rbind(its_comb_raw[,1:6], its_comb_raw[,1:6])
temp$vals <- c(its_comb_raw[,10], its_comb_raw[,7])
temp$src <- c(rep("R. oryzae",30), rep("Ascomycota", 30))

png("rel_abundance_scp.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(temp[temp$location == "SCP",], aes(imo_stage, vals, fill=src)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Stuy. Cove Park") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("rel_abundance_mc.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(temp[temp$location == "MC",], aes(imo_stage, vals, fill=src)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Marshlands Cons.") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

i16s_level2 <- read.csv("level-2_16S.csv")
i16s_metadat <- all_metadat[match(i16s_level2[,1], all_metadat[,1]),]

i16s_level2 <- i16s_level2[-1:-2,]
i16s_metadat <- i16s_metadat[-1:-2,]



i16s_metadat$imo_stage <- factor(i16s_metadat$imo_stage, levels=c("soil", "imo1", "imo2_d3", "imo2_d7"))

rownames(i16s_level2) <- i16s_level2[,1]
i16s_level2 <- i16s_level2[,-1]

i16s_level2_frac <- t(apply(i16s_level2, 1, function(x) x/sum(x)))

i16s_comb <- cbind(i16s_metadat, i16s_level2_frac)


i16s_comb_raw <- i16s_comb[i16s_comb[,4] == "raw",]
i16s_comb_sterile <- i16s_comb[i16s_comb[,4] == "sterile",]


temp <- rbind(i16s_comb_raw[,1:6], i16s_comb_raw[,1:6])
temp$vals <- c(i16s_comb_raw[,"d__Bacteria.p__Proteobacteria"], i16s_comb_raw[,"d__Bacteria.p__Firmicutes"])
temp$src <- c(rep("Proteobacteria",nrow(i16s_comb_raw)), rep("Firmicutes", nrow(i16s_comb_raw)))

png("firmicutes_raw.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(i16s_comb_raw, aes(imo_stage, d__Bacteria.p__Firmicutes, fill=imo_stage)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE)+ coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Firmicutes over time (raw)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("rel_abundance_raw_prot_firm.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(temp, aes(imo_stage, vals, fill=src)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Raw") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

temp <- rbind(i16s_comb_sterile[,1:6], i16s_comb_sterile[,1:6])
temp$vals <- c(i16s_comb_sterile[,"d__Bacteria.p__Proteobacteria"], i16s_comb_sterile[,"d__Bacteria.p__Firmicutes"])
temp$src <- c(rep("Proteobacteria",nrow(i16s_comb_sterile)), rep("Firmicutes", nrow(i16s_comb_sterile)))

png("rel_abundance_sterile_prot_firm.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(temp, aes(imo_stage, vals, fill=src)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Sterile") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()


png("proteobacteria_raw.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(i16s_comb_raw, aes(imo_stage, d__Bacteria.p__Proteobacteria, fill=imo_stage)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE)+ coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Proteobac. over time (raw)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("proteobacteria_raw_orig.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(i16s_comb_raw, aes(imo_stage, d__Bacteria.p__Proteobacteria, fill=location)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Proteobac. over time (raw)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()


png("proteobacteria_raw_scp.png", width=2400*0.75, height=2400, res=600, pointsize=3)

ggplot(i16s_comb_raw[i16s_comb_raw$location == "SCP",], aes(imo_stage, d__Bacteria.p__Proteobacteria, fill=imo_stage)) + geom_boxplot(fill=gg_color_hue(3)[3]) + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) + geom_line(aes(group=location_detail)) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Proteobac. over time (SCP)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("proteobacteria_raw_mc.png", width=2400*0.75, height=2400, res=600, pointsize=3)

ggplot(i16s_comb_raw[i16s_comb_raw$location == "MC",], aes(imo_stage, d__Bacteria.p__Proteobacteria, fill=imo_stage)) + geom_boxplot(fill=gg_color_hue(3)[1]) + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) + geom_line(aes(group=location_detail)) +  coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Proteobac. over time (MC)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

png("proteobacteria_sterile.png", width=2400, height=2400, res=600, pointsize=3)

ggplot(i16s_comb_sterile, aes(imo_stage, d__Bacteria.p__Proteobacteria, fill=imo_stage)) + geom_boxplot() + scale_x_discrete("IMO stage", breaks=imo_stag, drop=FALSE) + geom_line(aes(group=location_detail)) + coord_cartesian(ylim=c(0, 1)) + ylab("Rel. Abundance") + xlab("Time") + ggtitle("Proteobac. over time (sterile)") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()







pair_dist_16s_soil <- read.csv("raw_dist_16s_soil.tsv", sep="\t")
pair_dist_16s_imo1 <- read.csv("raw_dist_16s_imo1.tsv", sep="\t")
pair_dist_16s_imo2_d3 <- read.csv("raw_dist_16s_imo2_d3.tsv", sep="\t")
pair_dist_16s_imo2_d7 <- read.csv("raw_dist_16s_imo2_d7.tsv", sep="\t")

get_matched_dist <- function(in_mtx, group_a, group_b){
	idx_matched <- intersect(which(in_mtx$Group1 == group_a), which(in_mtx$Group2 == group_b))
	return(in_mtx[idx_matched,])
}

dist_16s_soil_urb_nat <- get_matched_dist(pair_dist_16s_soil, "SOIL_URB", "SOIL_NAT")
dist_16s_soil_urb_urb <- get_matched_dist(pair_dist_16s_soil, "SOIL_URB", "SOIL_URB")
dist_16s_soil_nat_nat <- get_matched_dist(pair_dist_16s_soil, "SOIL_NAT", "SOIL_NAT")

dist_16s_imo1_urb_nat <- get_matched_dist(pair_dist_16s_imo1, "IMO_URB", "IMO_NAT")
dist_16s_imo1_urb_ster <- get_matched_dist(pair_dist_16s_imo1, "IMO_URB", "IMO_STER")
dist_16s_imo1_urb_urb <- get_matched_dist(pair_dist_16s_imo1, "IMO_URB", "IMO_URB")
dist_16s_imo1_nat_ster <- get_matched_dist(pair_dist_16s_imo1, "IMO_NAT", "IMO_STER")
dist_16s_imo1_nat_nat <- get_matched_dist(pair_dist_16s_imo1, "IMO_NAT", "IMO_NAT")
dist_16s_imo1_ster_ster <- get_matched_dist(pair_dist_16s_imo1, "IMO_STER", "IMO_STER")

dist_16s_imo2_d3_urb_nat <- get_matched_dist(pair_dist_16s_imo2_d3, "IMO_URB", "IMO_NAT")
dist_16s_imo2_d3_urb_ster <- get_matched_dist(pair_dist_16s_imo2_d3, "IMO_URB", "IMO_STER")
dist_16s_imo2_d3_urb_urb <- get_matched_dist(pair_dist_16s_imo2_d3, "IMO_URB", "IMO_URB")
dist_16s_imo2_d3_nat_ster <- get_matched_dist(pair_dist_16s_imo2_d3, "IMO_NAT", "IMO_STER")
dist_16s_imo2_d3_nat_nat <- get_matched_dist(pair_dist_16s_imo2_d3, "IMO_NAT", "IMO_NAT")
dist_16s_imo2_d3_ster_ster <- get_matched_dist(pair_dist_16s_imo2_d3, "IMO_STER", "IMO_STER")

dist_16s_imo2_d7_urb_nat <- get_matched_dist(pair_dist_16s_imo2_d7, "IMO_URB", "IMO_NAT")
dist_16s_imo2_d7_urb_ster <- get_matched_dist(pair_dist_16s_imo2_d7, "IMO_URB", "IMO_STER")
dist_16s_imo2_d7_urb_urb <- get_matched_dist(pair_dist_16s_imo2_d7, "IMO_URB", "IMO_URB")
dist_16s_imo2_d7_nat_ster <- get_matched_dist(pair_dist_16s_imo2_d7, "IMO_NAT", "IMO_STER")
dist_16s_imo2_d7_nat_nat <- get_matched_dist(pair_dist_16s_imo2_d7, "IMO_NAT", "IMO_NAT")
dist_16s_imo2_d7_ster_ster <- get_matched_dist(pair_dist_16s_imo2_d7, "IMO_STER", "IMO_STER")

dist_16s_time_urb_nat <- data.frame(
	stage=c(rep("Soil", nrow(dist_16s_soil_urb_nat)), rep("IMO1", nrow(dist_16s_imo1_urb_nat)), rep("IMO2_D3", nrow(dist_16s_imo2_d3_urb_nat)), rep("IMO2_D7", nrow(dist_16s_imo2_d7_urb_nat))), 
	dist=c(dist_16s_soil_urb_nat$Distance, dist_16s_imo1_urb_nat$Distance, dist_16s_imo2_d3_urb_nat$Distance, dist_16s_imo2_d7_urb_nat$Distance))

dist_16s_time_urb_nat$stage <- factor(dist_16s_time_urb_nat$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))
imo_stag_ord <- factor(c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_16s_time_urb_urb <- data.frame(
	stage=c(rep("Soil", nrow(dist_16s_soil_urb_urb)), rep("IMO1", nrow(dist_16s_imo1_urb_urb)), rep("IMO2_D3", nrow(dist_16s_imo2_d3_urb_urb)), rep("IMO2_D7", nrow(dist_16s_imo2_d7_urb_urb))), 
	dist=c(dist_16s_soil_urb_urb$Distance, dist_16s_imo1_urb_urb$Distance, dist_16s_imo2_d3_urb_urb$Distance, dist_16s_imo2_d7_urb_urb$Distance))

dist_16s_time_urb_urb$stage <- factor(dist_16s_time_urb_urb$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_16s_time_nat_nat <- data.frame(
	stage=c(rep("Soil", nrow(dist_16s_soil_nat_nat)), rep("IMO1", nrow(dist_16s_imo1_nat_nat)), rep("IMO2_D3", nrow(dist_16s_imo2_d3_nat_nat)), rep("IMO2_D7", nrow(dist_16s_imo2_d7_nat_nat))), 
	dist=c(dist_16s_soil_nat_nat$Distance, dist_16s_imo1_nat_nat$Distance, dist_16s_imo2_d3_nat_nat$Distance, dist_16s_imo2_d7_nat_nat$Distance))

dist_16s_time_nat_nat$stage <- factor(dist_16s_time_nat_nat$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_16s_time_ster_ster <- data.frame(
	stage=c(rep("IMO1", nrow(dist_16s_imo1_ster_ster)), rep("IMO2_D3", nrow(dist_16s_imo2_d3_ster_ster)), rep("IMO2_D7", nrow(dist_16s_imo2_d7_ster_ster))), 
	dist=c(dist_16s_imo1_ster_ster$Distance, dist_16s_imo2_d3_ster_ster$Distance, dist_16s_imo2_d7_ster_ster$Distance))

dist_16s_time_ster_ster$stage <- factor(dist_16s_time_ster_ster$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_16s_time_comp <- rbind(rbind(rbind(dist_16s_time_ster_ster, dist_16s_time_urb_urb), dist_16s_time_nat_nat), dist_16s_time_urb_nat)
dist_16s_time_comp$comp <- c(rep("STER-STER", nrow(dist_16s_time_ster_ster)), rep("URB-URB", nrow(dist_16s_time_urb_urb)), rep("NAT-NAT", nrow(dist_16s_time_nat_nat)), rep("URB-NAT", nrow(dist_16s_time_urb_nat)))


dist_16s_time_comp_ingroup <- rbind(rbind(dist_16s_time_ster_ster, dist_16s_time_urb_urb), dist_16s_time_nat_nat)
dist_16s_time_comp_ingroup$comp <- c(rep("STER-STER", nrow(dist_16s_time_ster_ster)), rep("URB-URB", nrow(dist_16s_time_urb_urb)), rep("NAT-NAT", nrow(dist_16s_time_nat_nat)))

dist_16s_time_comp_ingroup$comp <- factor(dist_16s_time_comp_ingroup$comp, levels=c("NAT-NAT", "URB-URB", "STER-STER"))

png("unifrac_dist_16s_within.png", width=2400*1.75, height=2400, res=600, pointsize=3)

ggplot(dist_16s_time_comp_ingroup) + geom_boxplot(aes(x=stage, y=dist, fill=comp), width=0.6, position=position_dodge(preserve="single", width=0.75)) + ylab("Unweighted UniFrac Distance")  + coord_cartesian(ylim=c(0.35, 0.8)) + xlab("Time") + ggtitle("(16S) Within-group comparisons") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

dist_16s_time_comp <- rbind(rbind(dist_16s_time_urb_urb, dist_16s_time_nat_nat), dist_16s_time_urb_nat)
dist_16s_time_comp$comp <- c(rep("URB-URB", nrow(dist_16s_time_urb_urb)), rep("NAT-NAT", nrow(dist_16s_time_nat_nat)), rep("URB-NAT", nrow(dist_16s_time_urb_nat)))

dist_16s_time_comp$comp <- factor(dist_16s_time_comp$comp, levels=c("NAT-NAT", "URB-URB", "URB-NAT"))

png("unifrac_dist_16s_between.png", width=2400*1.75, height=2400, res=600, pointsize=3)

ggplot(dist_16s_time_comp) + geom_boxplot(aes(x=stage, y=dist, fill=comp), width=0.6, position=position_dodge(preserve="single", width=0.75)) + ylab("Unweighted UniFrac Distance") + coord_cartesian(ylim=c(0.35, 0.8)) + xlab("Time") + ggtitle("(16S) Between-group comparison") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()




pair_dist_its_soil <- read.csv("raw_dist_its_soil.tsv", sep="\t")
pair_dist_its_imo1 <- read.csv("raw_dist_its_imo1.tsv", sep="\t")
pair_dist_its_imo2_d3 <- read.csv("raw_dist_its_imo2_d3.tsv", sep="\t")
pair_dist_its_imo2_d7 <- read.csv("raw_dist_its_imo2_d7.tsv", sep="\t")

get_matched_dist <- function(in_mtx, group_a, group_b){
	idx_matched <- intersect(which(in_mtx$Group1 == group_a), which(in_mtx$Group2 == group_b))
	return(in_mtx[idx_matched,])
}

dist_its_soil_urb_nat <- get_matched_dist(pair_dist_its_soil, "SOIL_URB", "SOIL_NAT")
dist_its_soil_urb_urb <- get_matched_dist(pair_dist_its_soil, "SOIL_URB", "SOIL_URB")
dist_its_soil_nat_nat <- get_matched_dist(pair_dist_its_soil, "SOIL_NAT", "SOIL_NAT")

dist_its_imo1_urb_nat <- get_matched_dist(pair_dist_its_imo1, "IMO_URB", "IMO_NAT")
dist_its_imo1_urb_ster <- get_matched_dist(pair_dist_its_imo1, "IMO_URB", "IMO_STER")
dist_its_imo1_urb_urb <- get_matched_dist(pair_dist_its_imo1, "IMO_URB", "IMO_URB")
dist_its_imo1_nat_ster <- get_matched_dist(pair_dist_its_imo1, "IMO_NAT", "IMO_STER")
dist_its_imo1_nat_nat <- get_matched_dist(pair_dist_its_imo1, "IMO_NAT", "IMO_NAT")
dist_its_imo1_ster_ster <- get_matched_dist(pair_dist_its_imo1, "IMO_STER", "IMO_STER")

dist_its_imo2_d3_urb_nat <- get_matched_dist(pair_dist_its_imo2_d3, "IMO_URB", "IMO_NAT")
dist_its_imo2_d3_urb_ster <- get_matched_dist(pair_dist_its_imo2_d3, "IMO_URB", "IMO_STER")
dist_its_imo2_d3_urb_urb <- get_matched_dist(pair_dist_its_imo2_d3, "IMO_URB", "IMO_URB")
dist_its_imo2_d3_nat_ster <- get_matched_dist(pair_dist_its_imo2_d3, "IMO_NAT", "IMO_STER")
dist_its_imo2_d3_nat_nat <- get_matched_dist(pair_dist_its_imo2_d3, "IMO_NAT", "IMO_NAT")
dist_its_imo2_d3_ster_ster <- get_matched_dist(pair_dist_its_imo2_d3, "IMO_STER", "IMO_STER")

dist_its_imo2_d7_urb_nat <- get_matched_dist(pair_dist_its_imo2_d7, "IMO_URB", "IMO_NAT")
dist_its_imo2_d7_urb_ster <- get_matched_dist(pair_dist_its_imo2_d7, "IMO_URB", "IMO_STER")
dist_its_imo2_d7_urb_urb <- get_matched_dist(pair_dist_its_imo2_d7, "IMO_URB", "IMO_URB")
dist_its_imo2_d7_nat_ster <- get_matched_dist(pair_dist_its_imo2_d7, "IMO_NAT", "IMO_STER")
dist_its_imo2_d7_nat_nat <- get_matched_dist(pair_dist_its_imo2_d7, "IMO_NAT", "IMO_NAT")
dist_its_imo2_d7_ster_ster <- get_matched_dist(pair_dist_its_imo2_d7, "IMO_STER", "IMO_STER")

dist_its_time_urb_nat <- data.frame(
	stage=c(rep("Soil", nrow(dist_its_soil_urb_nat)), rep("IMO1", nrow(dist_its_imo1_urb_nat)), rep("IMO2_D3", nrow(dist_its_imo2_d3_urb_nat)), rep("IMO2_D7", nrow(dist_its_imo2_d7_urb_nat))), 
	dist=c(dist_its_soil_urb_nat$Distance, dist_its_imo1_urb_nat$Distance, dist_its_imo2_d3_urb_nat$Distance, dist_its_imo2_d7_urb_nat$Distance))

dist_its_time_urb_nat$stage <- factor(dist_its_time_urb_nat$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))
imo_stag_ord <- factor(c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_its_time_urb_urb <- data.frame(
	stage=c(rep("Soil", nrow(dist_its_soil_urb_urb)), rep("IMO1", nrow(dist_its_imo1_urb_urb)), rep("IMO2_D3", nrow(dist_its_imo2_d3_urb_urb)), rep("IMO2_D7", nrow(dist_its_imo2_d7_urb_urb))), 
	dist=c(dist_its_soil_urb_urb$Distance, dist_its_imo1_urb_urb$Distance, dist_its_imo2_d3_urb_urb$Distance, dist_its_imo2_d7_urb_urb$Distance))

dist_its_time_urb_urb$stage <- factor(dist_its_time_urb_urb$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_its_time_nat_nat <- data.frame(
	stage=c(rep("Soil", nrow(dist_its_soil_nat_nat)), rep("IMO1", nrow(dist_its_imo1_nat_nat)), rep("IMO2_D3", nrow(dist_its_imo2_d3_nat_nat)), rep("IMO2_D7", nrow(dist_its_imo2_d7_nat_nat))), 
	dist=c(dist_its_soil_nat_nat$Distance, dist_its_imo1_nat_nat$Distance, dist_its_imo2_d3_nat_nat$Distance, dist_its_imo2_d7_nat_nat$Distance))

dist_its_time_nat_nat$stage <- factor(dist_its_time_nat_nat$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_its_time_ster_ster <- data.frame(
	stage=c(rep("IMO1", nrow(dist_its_imo1_ster_ster)), rep("IMO2_D3", nrow(dist_its_imo2_d3_ster_ster)), rep("IMO2_D7", nrow(dist_its_imo2_d7_ster_ster))), 
	dist=c(dist_its_imo1_ster_ster$Distance, dist_its_imo2_d3_ster_ster$Distance, dist_its_imo2_d7_ster_ster$Distance))

dist_its_time_ster_ster$stage <- factor(dist_its_time_ster_ster$stage, levels=c("Soil", "IMO1", "IMO2_D3", "IMO2_D7"))

dist_its_time_comp <- rbind(rbind(rbind(dist_its_time_ster_ster, dist_its_time_urb_urb), dist_its_time_nat_nat), dist_its_time_urb_nat)
dist_its_time_comp$comp <- c(rep("STER-STER", nrow(dist_its_time_ster_ster)), rep("URB-URB", nrow(dist_its_time_urb_urb)), rep("NAT-NAT", nrow(dist_its_time_nat_nat)), rep("URB-NAT", nrow(dist_its_time_urb_nat)))


dist_its_time_comp_ingroup <- rbind(rbind(dist_its_time_ster_ster, dist_its_time_urb_urb), dist_its_time_nat_nat)
dist_its_time_comp_ingroup$comp <- c(rep("STER-STER", nrow(dist_its_time_ster_ster)), rep("URB-URB", nrow(dist_its_time_urb_urb)), rep("NAT-NAT", nrow(dist_its_time_nat_nat)))

dist_its_time_comp_ingroup$comp <- factor(dist_its_time_comp_ingroup$comp, levels=c("NAT-NAT", "URB-URB", "STER-STER"))

png("unifrac_dist_its_within.png", width=2400*1.75, height=2400, res=600, pointsize=3)

ggplot(dist_its_time_comp_ingroup) + geom_boxplot(aes(x=stage, y=dist, fill=comp), width=0.6, position=position_dodge(preserve="single", width=0.75)) + ylab("Unweighted UniFrac Distance")  + coord_cartesian(ylim=c(0.45, 0.87)) + xlab("Time") + ggtitle("(ITS) Within-group comparisons") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()

dist_its_time_comp <- rbind(rbind(dist_its_time_urb_urb, dist_its_time_nat_nat), dist_its_time_urb_nat)
dist_its_time_comp$comp <- c(rep("URB-URB", nrow(dist_its_time_urb_urb)), rep("NAT-NAT", nrow(dist_its_time_nat_nat)), rep("URB-NAT", nrow(dist_its_time_urb_nat)))

dist_its_time_comp$comp <- factor(dist_its_time_comp$comp, levels=c("NAT-NAT", "URB-URB", "URB-NAT"))

png("unifrac_dist_its_between.png", width=2400*1.75, height=2400, res=600, pointsize=3)

ggplot(dist_its_time_comp) + geom_boxplot(aes(x=stage, y=dist, fill=comp), width=0.6, position=position_dodge(preserve="single", width=0.75)) + ylab("Unweighted UniFrac Distance") + coord_cartesian(ylim=c(0.45, 0.87)) + xlab("Time") + ggtitle("(ITS) Between-group comparison") + theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

dev.off()


