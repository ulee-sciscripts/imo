#!/usr/bin/bash


cd /ru-auth/local/home/ulee/scratch_store/analysis/imo/

srun='srun -p zhao apptainer exec --cleanenv --bind /lustre/fs4/zhao_lab/scratch/ulee/analysis/imo/:/home --home /home/ /lustre/fs4/zhao_lab/scratch/ulee/docka/qiime2_amp.sif'

# $srun qiime dada2 denoise-paired \
# --i-demultiplexed-seqs /home/demux-paired-end_its.qza \
# --p-trim-left-f 0 \
# --p-trim-left-r 0 \
# --p-trunc-len-f 250 \
# --p-trunc-len-r 204 \
# --p-n-threads 24 \
# --verbose \
# --o-table imo-its-table.qza \
# --o-representative-sequences imo-its-rep-seqs.qza \
# --o-denoising-stats imo-its-stats-dada2.qza

# $srun qiime feature-table summarize \
  # --i-table imo-its-table.qza \
  # --o-visualization imo-its-table.qzv \
  # --m-sample-metadata-file metadata_all_its_control.tsv
  
# $srun qiime feature-table summarize \
  # --i-table imo-its-table.qza \
  # --o-visualization imo-its-table.qzv 

# $srun qiime feature-table summarize \
  # --i-table imo-its-table.qza \
  # --o-visualization imo-its-table.qzv \
  # --m-sample-metadata-file metadata_all_its_control.tsv

# $srun qiime feature-table filter-samples --i-table imo-its-table.qza \
  # --m-metadata-file metadata_all_its_nocontrol_sterile.tsv \
  # --o-filtered-table imo-its-table_nocontrol_sterile.qza
  
# $srun qiime feature-table filter-samples --i-table imo-its-table.qza \
  # --m-metadata-file metadata_all_its_nocontrol_raw.tsv \
  # --o-filtered-table imo-its-table_nocontrol_raw.qza
  
# $srun qiime feature-classifier classify-sklearn \
  # --i-classifier classifier/unite_ver10_dynamic_s_19.02.2025-Q2-2024.10.qza \
  # --i-reads imo-its-rep-seqs.qza \
  # --o-classification imo-its-taxonomy.qza

# $srun qiime metadata tabulate \
  # --m-input-file imo-its-taxonomy.qza \
  # --o-visualization imo-its-taxonomy.qzv
  
  
# $srun qiime taxa barplot \
  # --i-table imo-its-table.qza \
  # --i-taxonomy imo-its-taxonomy.qza \
  # --o-visualization imo-its-taxa-bar-plots.qzv
  
# $srun qiime taxa filter-table \
  # --i-table imo-its-table.qza \
  # --i-taxonomy imo-its-taxonomy.qza \
  # --p-include p__ \
  # --o-filtered-table imo-its-table_phylum.qza

# $srun qiime taxa barplot \
  # --i-table imo-its-table_phylum.qza \
  # --i-taxonomy imo-its-taxonomy.qza \
  # --o-visualization imo-its-taxa-bar-plots_phylum.qzv  
  
# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_16s_soil.tsv \
  # --m-metadata-column soil_raw \
  # --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo1_raw-significance.qzv \
  # --p-pairwise 
 
# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_16s_soil.tsv \
  # --m-metadata-column imo1_raw \
  # --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo1_raw-significance.qzv \
  # --p-pairwise

# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_16s_soil.tsv \
  # --m-metadata-column imo2_d3_raw \
  # --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo2_d3_raw-significance.qzv \
  # --p-pairwise
  
# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_16s_soil.tsv \
  # --m-metadata-column imo2_d7_raw \
  # --o-visualization imo-16s-core-metrics-results/imo-16s-unweighted-unifrac-imo2_d7_raw-significance.qzv \
  # --p-pairwise

# $srun qiime longitudinal pairwise-distances \
  # --i-distance-matrix imo-16s-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_16s_soil.tsv  \
  # --p-group-column state \
  # --p-state-column imo_num \
  # --p-state-1 1 \
  # --p-state-2 3 \
  # --p-individual-id-column location \
  # --o-visualization imo-16s-pairwise-distances.qzv
  


# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_its_soil.tsv \
  # --m-metadata-column soil_raw \
  # --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-soil_raw-significance.qzv \
  # --p-pairwise

# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_its_soil.tsv \
  # --m-metadata-column imo1_raw \
  # --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-imo1_raw-significance.qzv \
  # --p-pairwise

# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_its_soil.tsv \
  # --m-metadata-column imo2_d3_raw \
  # --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-imo2_d3_raw-significance.qzv \
  # --p-pairwise
  
# $srun qiime diversity beta-group-significance \
  # --i-distance-matrix imo-its-core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  # --m-metadata-file metadata_its_soil.tsv \
  # --m-metadata-column imo2_d7_raw \
  # --o-visualization imo-its-core-metrics-results/imo-its-unweighted-unifrac-imo2_d7_raw-significance.qzv \
  # --p-pairwise

$srun qiime feature-table filter-samples \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[imo_stage]='soil'" \
  --o-filtered-table 16s_soil-table.qza
  
$srun qiime composition ancombc \
  --i-table 16s_soil-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-formula 'state' \
  --o-differentials imo-16s_soil_state_ancombc.qza
  
  $srun qiime composition da-barplot \
  --i-data imo-16s_soil_state_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_16s_soil_state.qzv

$srun qiime feature-table filter-samples \
  --i-table imo-16s-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-where "[imo_stage]='soil'" \
  --o-filtered-table 16s_imo2_d7-table.qza
  
$srun qiime composition ancombc \
  --i-table 16s_imo2_d7-table.qza \
  --m-metadata-file metadata_all_16s_control.tsv \
  --p-formula 'state' \
  --o-differentials imo-16s_imo2_d7_state_ancombc.qza
  
  $srun qiime composition da-barplot \
  --i-data imo-16s_imo2_d7_state_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_16s_imo2_d7_state.qzv
  


$srun qiime feature-table filter-samples \
  --i-table imo-its-table.qza \
  --m-metadata-file metadata_all_its_control.tsv \
  --p-where "[imo_stage]='soil'" \
  --o-filtered-table its_soil-table.qza
  
$srun qiime composition ancombc \
  --i-table its_soil-table.qza \
  --m-metadata-file metadata_all_its_control.tsv \
  --p-formula 'state' \
  --o-differentials imo-its_soil_state_ancombc.qza
  
  $srun qiime composition da-barplot \
  --i-data imo-its_soil_state_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_its_soil_state.qzv

$srun qiime feature-table filter-samples \
  --i-table imo-its-table.qza \
  --m-metadata-file metadata_all_its_control.tsv \
  --p-where "[imo_stage]='soil'" \
  --o-filtered-table its_imo2_d7-table.qza
  
$srun qiime composition ancombc \
  --i-table its_imo2_d7-table.qza \
  --m-metadata-file metadata_all_its_control.tsv \
  --p-formula 'state' \
  --o-differentials imo-its_imo2_d7_state_ancombc.qza
  
  $srun qiime composition da-barplot \
  --i-data imo-its_imo2_d7_state_ancombc.qza \
  --p-significance-threshold 0.001 \
  --o-visualization imo_its_imo2_d7_state.qzv