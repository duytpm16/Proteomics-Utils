### Options and library packages
options(stringsAsFactors = FALSE)
library(rBLAST)                     # devtools::install_github("mhahsler/rBLAST")
library(Biostrings)
library(dplyr)






### Variables to change
#   Assuming BLAST executable is already installed from ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/.

#   1.) seq_vec : a vector of sequences
#   2.) seq_type: 'AA' for amino acids | 'DNA' for ACTG nucleotides
#   3.) db_path : path to blast database and databse name
#   4.) outfile : filename to save blast results as .rds
data <- read.delim("~/Desktop/protein alignment/peptides_DO_islets.txt")

seq_vec  <- data$Sequence
seq_type <- 'AA'
db_path  <- "~/Desktop/Blast/Mm_pep_blast"
outfile  <- 'coon_maxquant_pep_blast_to_ref.rds'











### Setting up local databse, StringSet object, and BLAST program
if(seq_type == 'AA'){
  
   blast_db <- blast(db = db_path, type = 'blastp')
   seq_ss   <- AAStringSet(seq_vec)
}

if(seq_type == 'DNA'){
  
   blast_db <- blast(db = db_path, type = 'blastn')
   seq_ss   <- DNAStringSet(seq_vec)
}











### Setting up dataframe to store results
n <- length(seq_vec)
results <- data.frame(Sequence     = seq_vec,
                      SubjectID    = character(length = n),
                      Perc.Ident   = character(length = n),
                      Align.Length = character(length = n),
                      Sub.Start    = character(length = n),
                      Sub.End      = character(length = n))











### Blast alignment begins
for(i in 1:n){
  
  
    # Blast for one sequence. Don't care about stats, just want 100% alignment
    bl_results <- predict(object     = blast_db, 
                          newdata    = seq_ss[i,],
                          BLAST_args = '-comp_based_stats 0')  
    
    
    bl_results <- bl_results %>%
                             filter(Perc.Ident == 100 &  Alignment.Length == width(seq_ss[i,]))
    
    
    
    
    
    
    # Get subject info where sequence align 100% and alignment length = length of sequence.
    if(nrow(bl_results) != 0){
       
       results$SubjectID[i]    <- paste0(bl_results$SubjectID,        collapse = ',')
       results$Perc.Ident[i]   <- paste0(bl_results$Perc.Ident,       collapse = ',')
       results$Align.Length[i] <- paste0(bl_results$Alignment.Length, collapse = ',')
       results$Sub.Start[i]    <- paste0(bl_results$S.start,          collapse = ',')
       results$Sub.End[i]      <- paste0(bl_results$S.end,            collapse = ',')
      
    }
    
    
    print(i)
    
}





### Save blast results
results[results == ""] <- NA
saveRDS(results, file = outfile)

