n <- length(k)


protein_df <- data.frame(protein_id   = character(length = n),
                         chromosome   = character(length = n),
                         start        = numeric(length = n),
                         end          = numeric(length = n),
                         gene_id      = character(length = n),
                         trascript_id = character(length = n),
                         gene_symbol  = character(length = n))




for(i in 1:n){
    
    info <- strsplit(getAnnot.SeqFastaAA(k[[i]]), split = ' ')[[1]]                      # Get fasta header of protein sequence
    protein_df$protein_id[i]    <- gsub('>','',info[1])                                  # Get protein id
    protein_df$chromosome[i]    <- strsplit(info[3], split = ':')[[1]][3]                # Get chromosome
    protein_df$start[i]         <- as.numeric(strsplit(info[3], split = ':')[[1]][4])    # Get start
    protein_df$end[i]           <- as.numeric(strsplit(info[3], split = ':')[[1]][5])    # Get end
    protein_df$gene_id[i]       <- strsplit(info[4], split = ':')[[1]][2]                # Get gene id
    protein_df$trascript_id[i]  <- strsplit(info[5], split = ':')[[1]][2]                # Get transcript id
    protein_df$gene_symbol[i]   <- strsplit(info[8], split = ':')[[1]][2]                # Get gene_symbol
  
}


