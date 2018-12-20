options(stringsAsFactors = FALSE)
library(seqinr)


### Variables to change
#   1.) fasta.file  : path to protein fasta file
#   2.) mb          : logical value. True - convert numeric positions to Mb  | False - leave positions as is
#   3.) outfile.name: file name to save results  
fasta.file   <- 'Ensembl 90 Proteins/Mus_musculus.GRCm38.pep.all.fa'
mb           <- TRUE
outfile.name <- 'reference_protein_info.rds' 









### Create data frame to store protein header info
fasta.file <- read.fasta(fasta.file)


n <- length(fasta.file)
fasta_file_df <- data.frame(protein_id         = character(length = n),
                            chromosome         = character(length = n),
                            start              = numeric(length = n),
                            end                = numeric(length = n),
                            gene_id            = character(length = n),
                            transcript_id      = character(length = n),
                            gene_biotype       = character(length = n),
                            transcript_biotype = character(length = n),
                            gene_symbol        = character(length = n),
                            description        = character(length = n))








### Parsing fasta file begins
for(i in 1:n){
    
    # Get header description for a protein
    info <- strsplit(getAnnot(fasta.file[[i]]), split = ' ')[[1]]
  
  
  
    # Add the info to fasta_file_df
    fasta_file_df$protein_id[i]         <- gsub('>','',info[1])
    fasta_file_df$chromosome[i]         <- strsplit(info[3], split = ':')[[1]][3]
    fasta_file_df$start[i]              <- strsplit(info[3], split = ':')[[1]][4]
    fasta_file_df$end[i]                <- strsplit(info[3], split = ':')[[1]][5]
    fasta_file_df$gene_id[i]            <- strsplit(info[4], split = ':')[[1]][2]
    fasta_file_df$transcript_id[i]      <- strsplit(info[5], split = ':')[[1]][2]
    fasta_file_df$gene_biotype[i]       <- strsplit(info[6], split = ':')[[1]][2]
    fasta_file_df$transcript_biotype[i] <- strsplit(info[7], split = ':')[[1]][2]
    fasta_file_df$gene_symbol[i]        <- strsplit(info[8], split = ':')[[1]][2]
    fasta_file_df$description[i]        <- strsplit(info[9], split = ':')[[1]][2]
  
}



### Convert positions to Mb if mb == TRUE
if(mb){
   fasta_file_df$start <- fasta_file_df$start / 1e6
   fasta_file_df$end   <- fasta_file_df$end / 1e6
}





saveRDS(fasta_file_df, file = out.file)
