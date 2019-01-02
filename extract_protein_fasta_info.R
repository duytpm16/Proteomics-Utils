### Options and libraries
options(stringsAsFactors = FALSE)
library(seqinr)




### Variables to change
#   1.) fasta.file  : path to protein fasta file. Specifically from http://ftp.ensembl.org/pub/release-90/fasta/. Not sure if other versions contain the same format
#   2.) mb          : logical value. True - convert numeric positions to Mb  | False - leave positions as is
#   3.) outfile.name: file name to save results as .rds
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
    info[grep('description:', info)] <- paste(info[grep('description:', info)],
                                              paste(info[!grepl('[:>]', info) & !grepl('pep', info)], collapse = ' '))
  
  
    # Add the info to fasta_file_df
    fasta_file_df$protein_id[i]         <- gsub('>','',info[1])
    chromosome_position                 <- strsplit(info[grep('chromosome:', info)], split = ':')[[1]]
    fasta_file_df$chromosome[i]         <- chromosome_position[3]
    fasta_file_df$start[i]              <- chromosome_position[4]
    fasta_file_df$end[i]                <- chromosome_position[5]
    fasta_file_df$gene_id[i]            <- strsplit(info[grep('gene:', info)], split = ':')[[1]][2]
    fasta_file_df$transcript_id[i]      <- strsplit(info[grep('transcript:', info)], split = ':')[[1]][2]
    fasta_file_df$gene_biotype[i]       <- strsplit(info[grep('gene_biotype:', info)], split = ':')[[1]][2]
    fasta_file_df$transcript_biotype[i] <- strsplit(info[grep('transcript_biotype:', info)], split = ':')[[1]][2]
    fasta_file_df$gene_symbol[i]        <- if(length(info[grep('gene_symbol:', info)]) != 0) strsplit(info[grep('gene_symbol:', info)], split = ':')[[1]][2] else NA
    fasta_file_df$description[i]        <- if(length(info[grep('gene_symbol:', info)]) !=0 ) strsplit(info[grep('description:', info)], split = ':')[[1]][2] else NA
  
}

fasta_file_df$start <- as.numeric(fasta_file_df$start)
fasta_file_df$end   <- as.numeric(fasta_file_df$end)





### Convert positions to Mb if mb == TRUE
if(mb){
   fasta_file_df$start <- fasta_file_df$start / 1e6
   fasta_file_df$end   <- fasta_file_df$end / 1e6
}





### Save as RDS
saveRDS(fasta_file_df, file = outfile.name)
