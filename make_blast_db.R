### Options and library packages
options(stringsAsFactors = FALSE)
library(rBLAST)




### Variables to change
#   Need to install BLAST executable at ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/. 

#   1.) fasta_file_db: Path + name of file to make a BLAST databse. Better to not have space in directory/file names
#   2.) db_name      : name to give to BLAST db
#   2.) db_type      : 'prot' for amino acids | 'nucl' for DNA
fasta_file_db <- "~/Desktop/Ensembl_90_Proteins/Mus_musculus.GRCm38.pep.all.fa"
db_name       <- "mm.ref.prot"
db_type       <- 'prot'





makeblastdb(file   = fasta_file_db,
            dbtype = db_type,
            args   = paste('-out',db_name))


