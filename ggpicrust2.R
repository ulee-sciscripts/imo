library(readr)
library(ggpicrust2)
library(tibble)
library(tidyverse)
library(ggprism)
library(patchwork)


abundance_file <- "ko_metagenome.biom_koabun.tsv"

metadata <- read_delim(
    "metadata_all_16s_control_test.tsv",
    delim = "\t",
    escape_double = FALSE,
    trim_ws = TRUE
)

metadata1 <- metadata[-1,]

metadata1$imo_stage <- factor(metadata1$imo_stage, levels=c("control", "soil", "imo1", "imo2_d3", "imo2_d7"))

abundance_data <- read_delim(abundance_file, delim = "\t", col_names = TRUE, trim_ws = TRUE)

kegg_abundance <- ko2kegg_abundance(data=abundance_data)

ident_nat <- metadata1[which(metadata1$location_detail %in% c("nybg_b", "mc_a", "mc_b", "mc_c")),]
ident_urb <- metadata1[which(metadata1$location_detail %in% c("scp_a", "scp_b", "scp_c")),]
ident_ster <- metadata1[which(metadata1$sterility == "sterile"),]
ident_nosyn <- metadata1[which(! metadata1$location == "control"),]

ka_nat <- kegg_abundance[,ident_nat$`sample-id`]
ka_urb <- kegg_abundance[,ident_urb$`sample-id`]
ka_ster <- kegg_abundance[,ident_ster$`sample-id`]
ka_nosyn <- kegg_abundance[,ident_nosyn$`sample-id`]

metadata1_nat <- metadata1[metadata1$`sample-id` %in% ident_nat$`sample-id`,]
metadata1_urb <- metadata1[metadata1$`sample-id` %in% ident_urb$`sample-id`,]
metadata1_ster <- metadata1[metadata1$`sample-id` %in% ident_ster$`sample-id`,]
metadata1_nosyn <- metadata1[metadata1$`sample-id` %in% ident_nosyn$`sample-id`,]




daa_results_df <- pathway_daa(abundance = kegg_abundance, metadata = metadata1[ident_nosyn$`sample-id`,], group = "imo_stage", daa_method = "ALDEx2", select = NULL, reference = NULL)

daa_results_df_nat <- pathway_daa(abundance = ka_nat, metadata = metadata1_nat, group = "imo_stage", daa_method = "LinDA", select = NULL, reference = "soil")
daa_results_df_urb <- pathway_daa(abundance = ka_urb, metadata = metadata1_urb, group = "imo_stage", daa_method = "LinDA", select = NULL, reference = "soil")
daa_results_df_ster <- pathway_daa(abundance = ka_ster, metadata = metadata1_ster, group = "imo_stage", daa_method = "LinDA", select = NULL, reference = "soil")
daa_results_df_nosyn <- pathway_daa(abundance = ka_nosyn, metadata = metadata1_nosyn, group = "imo_stage", daa_method = "LinDA", select = NULL, reference = "soil")



daa_sub_method_results_df <- daa_results_df[daa_results_df$method == "ALDEx2_Kruskal-Wallace test", ]
daa_annotated_sub_method_results_df <- pathway_annotation(pathway = "KO", daa_results_df = daa_sub_method_results_df, ko_to_kegg = TRUE)

daa_sub_nat <- daa_results_df_nat[daa_results_df_nat$method == "LinDA", ]
daa_sub_urb <- daa_results_df_urb[daa_results_df_urb$method == "LinDA", ]
daa_sub_ster <- daa_results_df_ster[daa_results_df_ster$method == "LinDA", ]
daa_sub_nosyn <- daa_results_df_nosyn[daa_results_df_nosyn$method == "LinDA", ]


daa_annotated_sub_nat <- pathway_annotation(pathway = "KO", daa_results_df = daa_sub_nat, ko_to_kegg = TRUE)
daa_annotated_sub_urb <- pathway_annotation(pathway = "KO", daa_results_df = daa_sub_urb, ko_to_kegg = TRUE)
daa_annotated_sub_ster <- pathway_annotation(pathway = "KO", daa_results_df = daa_sub_ster, ko_to_kegg = TRUE)
daa_annotated_sub_nosyn <- pathway_annotation(pathway = "KO", daa_results_df = daa_sub_nosyn, ko_to_kegg = TRUE)


# daa_annotated_sub_method_results_df$p_adjust <- round(daa_annotated_sub_method_results_df$p_adjust,5)

# low_p_feature <- daa_annotated_sub_method_results_df[order(daa_annotated_sub_method_results_df$p_adjust), ]$feature[1:20]

ret_pathways <- c("Cellular Processes; Cell growth and death"
, "Cellular Processes; Cell motility"
, "Cellular Processes; Cellular community - prokaryotes"
, "Cellular Processes; Transport and catabolism"
, "Environmental Information Processing; Membrane transport"
, "Environmental Information Processing; Signal transduction"
, "Environmental Information Processing; Signaling molecules and interaction"
, "Genetic Information Processing; Folding, sorting and degradation"
, "Genetic Information Processing; Transcription"
, "Metabolism; Amino acid metabolism"
, "Metabolism; Biosynthesis of other secondary metabolites"
, "Metabolism; Carbohydrate metabolism"
, "Metabolism; Energy metabolism"
, "Metabolism; Glycan biosynthesis and metabolism"
, "Metabolism; Lipid metabolism"
, "Metabolism; Metabolism of cofactors and vitamins"
, "Metabolism; Metabolism of other amino acids"
, "Metabolism; Metabolism of terpenoids and polyketides"
, "Metabolism; Xenobiotics biodegradation and metabolism")

daa_annot_ret_df <- daa_annotated_sub_method_results_df[which(daa_annotated_sub_method_results_df$pathway_class %in% ret_pathways),]

daa_annot_ret_nat <- daa_annotated_sub_nat[which(daa_annotated_sub_nat$pathway_class %in% ret_pathways),]
daa_annot_ret_urb <- daa_annotated_sub_urb[which(daa_annotated_sub_urb$pathway_class %in% ret_pathways),]
daa_annot_ret_ster <- daa_annotated_sub_ster[which(daa_annotated_sub_ster$pathway_class %in% ret_pathways),]
daa_annot_ret_nosyn <- daa_annotated_sub_nosyn[which(daa_annotated_sub_nosyn$pathway_class %in% ret_pathways),]

daa_annot_ret_nosyn <- daa_annot_ret_nosyn[which(!grepl("yeast|fly|animal|Wnt|Notch", daa_annot_ret_nosyn$pathway_name)),]
daa_annot_ret_nat <- daa_annot_ret_nat[which(!grepl("yeast|fly|animal|Wnt|Notch", daa_annot_ret_nat$pathway_name)),]
daa_annot_ret_urb <- daa_annot_ret_urb[which(!grepl("yeast|fly|animal|Wnt|Notch", daa_annot_ret_urb$pathway_name)),]
daa_annot_ret_ster <- daa_annot_ret_ster[which(!grepl("yeast|fly|animal|Wnt|Notch", daa_annot_ret_ster$pathway_name)),]


metadata1$imo_stage <- factor(metadata1$imo_stage, levels=c("control", "soil", "imo1", "imo2_d3", "imo2_d7"))


pdf("picrust2_nosyn.pdf", width=24, height=8)
temp <- daa_annot_ret_nosyn$group2 == "imo1"

daa_annot_ret_nosyn$p_adjust <- round(daa_annot_ret_nosyn$p_adjust,5)

low_p_feature <- daa_annot_ret_nosyn[order(daa_annot_ret_nosyn$p_adjust), ]$feature[1:20]


pathway_errorbar(
  abundance = ka_nosyn,
  daa_results_df = daa_annot_ret_nosyn[temp,],
  Group = metadata1_nosyn$imo_stage,
  p_values_threshold = 0.05,
  select = low_p_feature,
  order = "group",
  ko_to_kegg = TRUE,
  p_value_bar = TRUE,
  colors = NULL,
)
dev.off()


pdf("picrust2_nat.pdf", width=24, height=8)

temp <- daa_annot_ret_nat$group2 == "imo1"

daa_annot_ret_nat$p_adjust <- round(daa_annot_ret_nat$p_adjust,5)

low_p_feature <- daa_annot_ret_nat[order(daa_annot_ret_nat$p_adjust), ]$feature[1:20]


pathway_errorbar(
  abundance = ka_nat,
  daa_results_df = daa_annot_ret_nat[temp,],
  Group = metadata1_nat$imo_stage,
  p_values_threshold = 0.05,
  select = low_p_feature,
  order = "group",
  ko_to_kegg = TRUE,
  p_value_bar = TRUE,
  colors = NULL,
)
dev.off()


pdf("picrust2_urb.pdf", width=24, height=8)

temp <- daa_annot_ret_urb$group2 == "imo1"

daa_annot_ret_urb$p_adjust <- round(daa_annot_ret_urb$p_adjust,5)

low_p_feature <- daa_annot_ret_urb[order(daa_annot_ret_urb$p_adjust), ]$feature[1:20]


pathway_errorbar(
  abundance = ka_urb,
  daa_results_df = daa_annot_ret_urb[temp,],
  Group = metadata1_urb$imo_stage,
  p_values_threshold = 0.05,
  select = low_p_feature,
  order = "group",
  ko_to_kegg = TRUE,
  p_value_bar = TRUE,
  colors = NULL,
)
dev.off()

pdf("picrust2_ster.pdf", width=24, height=8)

temp <- daa_annot_ret_ster$group2 == "imo1"

daa_annot_ret_ster$p_adjust <- round(daa_annot_ret_ster$p_adjust,5)

low_p_feature <- daa_annot_ret_ster[order(daa_annot_ret_ster$p_adjust), ]$feature[1:20]


pathway_errorbar(
  abundance = ka_ster,
  daa_results_df = daa_annot_ret_ster[temp,],
  Group = metadata1_ster$imo_stage,
  p_values_threshold = 0.05,
  select = low_p_feature,
  order = "group",
  ko_to_kegg = TRUE,
  p_value_bar = TRUE,
  colors = NULL,
)

dev.off()
