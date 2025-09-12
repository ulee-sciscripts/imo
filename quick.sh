#!/usr/bin/bash


cd /ru-auth/local/home/ulee/scratch_store/analysis/imo/

srun='srun -p zhao apptainer exec --cleanenv --bind /lustre/fs4/zhao_lab/scratch/ulee/analysis/imo/:/home --home /home/ /lustre/fs4/zhao_lab/scratch/ulee/docka/qiime2_amp.sif'


 
$srun qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences imo-16s-rep-seqs.qza \
  --o-alignment imo-16s-aligned-rep-seqs.qza \
  --o-masked-alignment imo-16s-masked-aligned-rep-seqs.qza \
  --o-tree imo-16s-unrooted-tree.qza \
  --o-rooted-tree imo-16s-rooted-tree.qza


$srun qiime diversity core-metrics-phylogenetic \
  --i-phylogeny imo-16s-rooted-tree.qza \
  --i-table table.qza \
  --p-sampling-depth 1103 \
  --m-metadata-file sample-metadata.tsv \
  --output-dir core-metrics-results
  
$srun qiime diversity core-metrics-phylogenetic \
  --i-phylogeny imo-16s-rooted-tree.qza \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-sampling-depth 280000 \
  --output-dir imo-16s-core-metrics-results  



$srun qiime feature-table summarize \
  --i-table imo-16s-table.qza \
  --o-visualization imo-16s-table.qzv \
  --m-sample-metadata-file metadata_all_16s_control.tsv
  
$srun qiime feature-table tabulate-seqs \
  --i-data imo-16s-rep-seqs.qza \
  --o-visualization imo-16s-rep-seqs.qzv


$srun qiime diversity core-metrics-phylogenetic \
  --i-phylogeny imo-16s-rooted-tree.qza \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-sampling-depth 280000 \
  --output-dir imo-16s-core-metrics-results  


  
$srun qiime diversity alpha-group-significance \
  --i-alpha-diversity imo-16s-core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --o-visualization imo-16s-core-metrics-results/faith-pd-group-significance.qzv

$srun qiime diversity alpha-group-significance \
  --i-alpha-diversity imo-16s-core-metrics-results/evenness_vector.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --o-visualization imo-16s-core-metrics-results/evenness-group-significance.qzv

$srun qiime diversity alpha-group-significance \
  --i-alpha-diversity imo-16s-core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata_all_16s_nocontrol_sterile.tsv \
  --o-visualization imo-16s-core-metrics-results/faith-pd-group-significance_sterile.qzv

$srun qiime diversity alpha-group-significance \
  --i-alpha-diversity imo-16s-core-metrics-results/evenness_vector.qza \
  --m-metadata-file metadata_all_16s_nocontrol_sterile.tsv \
  --o-visualization imo-16s-core-metrics-results/evenness-group-significance_sterile.qzv

$srun qiime diversity alpha-group-significance \
  --i-alpha-diversity imo-16s-core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata_all_16s_nocontrol_raw.tsv \
  --o-visualization imo-16s-core-metrics-results/faith-pd-group-significance_raw.qzv

$srun qiime diversity alpha-group-significance \
  --i-alpha-diversity imo-16s-core-metrics-results/evenness_vector.qza \
  --m-metadata-file metadata_all_16s_nocontrol_raw.tsv \
  --o-visualization imo-16s-core-metrics-results/evenness-group-significance_raw.qzv


$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --m-metadata-column sterility \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-sterility-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --m-metadata-column imo_stage \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo_stage-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --m-metadata-column location \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-location-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --m-metadata-column location_detail \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-location_detail-significance.qzv \
  --p-pairwise



$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_16s_soil.tsv \
  --m-metadata-column soil_raw \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-soil_raw-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_16s_soil.tsv \
  --m-metadata-column imo1_raw \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo1_raw-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_16s_soil.tsv \
  --m-metadata-column imo2_d3_raw \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo2_d3_raw-significance.qzv \
  --p-pairwise
  
$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_16s_soil.tsv \
  --m-metadata-column imo2_d7_raw \
  --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo2_d7_raw-significance.qzv \
  --p-pairwise


$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_its_soil.tsv \
  --m-metadata-column soil_raw \
  --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-soil_raw-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_its_soil.tsv \
  --m-metadata-column imo1_raw \
  --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-imo1_raw-significance.qzv \
  --p-pairwise

$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_its_soil.tsv \
  --m-metadata-column imo2_d3_raw \
  --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-imo2_d3_raw-significance.qzv \
  --p-pairwise
  
$srun qiime diversity beta-group-significance \
  --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata_its_soil.tsv \
  --m-metadata-column imo2_d7_raw \
  --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-imo2_d7_raw-significance.qzv \
  --p-pairwise



$srun qiime emperor plot \
  --i-pcoa imo-16s-core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-custom-axes imo_num \
  --o-visualization imo-16s-core-metrics-results/unweighted-unifrac-emperor-imo_num.qzv

$srun qiime emperor plot \
  --i-pcoa imo-16s-core-metrics-results/bray_curtis_pcoa_results.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-custom-axes imo_num \
  --o-visualization imo-16s-core-metrics-results/bray-curtis-emperor-imo_num.qzv
  


$srun qiime feature-table filter-samples \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[imo_stage]='imo2_d3'" \
  --o-filtered-table 16s_imo2_d3-table.qza
  
$srun qiime composition ancombc \
  --i-table 16s_imo2_d3-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-formula 'location' \
  --o-differentials imo-16s_imo2_d3_loc_ancombc.qza

$srun qiime composition da-barplot \
  --i-data imo-16s_imo2_d3_loc_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_16s_imo2_d3_loc.qzv
  
$srun qiime feature-table filter-samples \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[imo_stage]='imo2_d7'" \
  --o-filtered-table 16s_imo2_d7-table.qza
  
$srun qiime composition ancombc \
  --i-table 16s_imo2_d7-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-formula 'location' \
  --o-differentials imo-16s_imo2_d7_loc_ancombc.qza

$srun qiime composition da-barplot \
  --i-data imo-16s_imo2_d7_loc_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_16s_imo2_d7_loc.qzv

$srun qiime feature-table filter-samples \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[imo_stage]='soil'" \
  --o-filtered-table 16s_soil-table.qza
  
$srun qiime composition ancombc \
  --i-table 16s_soil-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-formula 'location' \
  --o-differentials imo-16s_soil_loc_ancombc.qza

$srun qiime composition da-barplot \
  --i-data imo-16s_soil_loc_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_16s_soil_loc.qzv



$srun qiime feature-table filter-samples \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[sample-id]='IMOL10-16S'" \
  --o-filtered-table imo-16s_imol10-table.qza
  
$srun qiime feature-table summarize \
--i-table imo-16s_imol10-table.qza \
--o-visualization imo-16s_imol10-table.qzv \
--m-sample-metadata-file metadata_all_16s_control.tsv

$srun qiime feature-table filter-samples \
  --i-table imo-16s-table-feat.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[sample-id]='IMOL10-16S'" \
  --o-filtered-table imo-16s_imol10-table-feat.qza
  
$srun qiime feature-table summarize \
--i-table imo-16s_imol10-table-feat.qza \
--o-visualization imo-16s_imol10-table-feat.qzv \
--m-sample-metadata-file metadata_all_16s_control.tsv



