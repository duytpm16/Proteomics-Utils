#######################################################################################################################################
#
#   This script makes local blast protein database for each of the 8 DO founder strains and the reference.
#
#   Note*:
#       Need to install BLAST executable at ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/. 
#
#
#
#   Input:
#      1.) dir_path : path where fasta file are stored and where the database will be stored in
#      2.) file_name: Vector containing  protein fasta files for each of the 8 founder strains and the reference
#      3.) db_name  : Vector of names to save the BLAST db file. Should be consistent with file_name
#      4.) db_type  : 'prot' for amino acids | 'nucl' for nucleotides
#
#
#   Output:
#      1.) Local BLAST database for each item in file_name
#
#
#
#
#   Author: Duy Pham
#   E-mail: duy.pham@jax.org
#   Date  : December 20, 2018
#
###################################################################################################################################################

### Options and library packages
options(stringsAsFactors = FALSE)
library(rBLAST)








### Path where fasta files are stored and where the databases will be stored
dir_path <- "~/Desktop/Ensembl_90_Proteins/"











### Names of the protein fasta files
file_name <- c("Mus_musculus.GRCm38.pep.all.fa",
               "Mus_musculus_aj.A_J_v1.pep.all.fa",
               "Mus_musculus_129s1svimj.129S1_SvImJ_v1.pep.all.fa",
               "Mus_musculus_c57bl6nj.C57BL_6NJ_v1.pep.all.fa",
               "Mus_musculus_casteij.CAST_EiJ_v1.pep.all.fa",
               "Mus_musculus_nodshiltj.NOD_ShiLtJ_v1.pep.all.fa",
               "Mus_musculus_nzohlltj.NZO_HlLtJ_v1.pep.all.fa",
               "Mus_musculus_pwkphj.PWK_PhJ_v1.pep.all.fa",
               "Mus_musculus_wsbeij.WSB_EiJ_v1.pep.all.fa")
file_name <- paste0(dir_path, file_name)










### Names for database
db_name <- c("mm.ref.prot",
             "mm.aj.prot",
             "mm.svimj.prot",
             "mm.c57bl.prot",
             "mm.cast.prot",
             "mm.nod.prot",
             "mm.nzo.prot",
             "mm.pwk.prot",
             "mm.wsb.prot")
db_name <- paste0(dir_path, db_name)







### Type of database. 'prot' for protein | 'nucl' for nucleotides
db_type <- 'prot'










### Make local BLAST db begins
for(i in 1:length(file_name)){
   
    makeblastdb(file   = file_name[i],
                dbtype = db_type,
                args   = paste('-out', db_name[i]))
   
}





