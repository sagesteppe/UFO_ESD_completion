library(tidyverse)

p <- '../data'
f <- list.files(file.path(p, 'raw'), pattern = 'csv$')
f

comm_table <- read.csv(file.path(p, 'raw', f[grep('community', f)])) %>% 
  drop_na(PHASE) # blank lines used in the transcription process for clarity

veg_bench <- read.csv(file.path(p, 'raw', f[grep('benchmarks', f)])) #%>% 
  drop_na(PHASE) # blank lines used in the transcription process for clarity

veg_states <- read.csv(file.path(p, 'raw', f[grep('Ordered', f)])) %>% 
  mutate(across(.cols = everything(), ~ str_trim(.x))) %>% 
  mutate(STATE = str_remove(STATE, ' STATE'),
         STATE = str_replace(STATE, 'DEDPAUPERATE', 'DEPAUPERATE')
         ) %>% 
  mutate(VEG = str_replace(VEG, 'HERB.$', 'FORB'),
         VEG = str_replace(VEG, 'FOBR|FORBS', 'FORB'),
         VEG = str_replace(VEG, 'SHRUBS', 'SHRUB'),
         VEG = str_replace(VEG, 'PINYON JUNIPER|PJ', 'PINYON-JUNIPER'),
         VEG = str_replace(VEG, 'TWONEEDLE PINYON|TWO-NEEDLE PINYON|TWO NEEDLE PINYON', 'PIED'),
         VEG = str_replace(VEG, 'UTAH JUNIPER|TWO-NEEDLE PINYON|TWO NEEDLE PINYON', 'JUOS'),
         
         VEG = str_replace(VEG, 'GALLETA|JAMES GALLETA', 'PLJA'),
         VEG = str_replace(VEG, 'TORREY MORMONTEA|TORREYS JOINTFIR', 'EPTO'),
         VEG = str_replace(VEG, 'MORMONTEA', 'EPHEDRA'),
         VEG = str_replace(VEG, 'INDIAN RICEGRASS|AHCY', 'ACHY'),
         VEG = str_replace(VEG, 'CHEATGRASS', 'BRTE'),
         VEG = str_replace(VEG, 'BLUE GRAMA', 'BOGR2'), 
         VEG = str_replace(VEG, 'BOTTLEBRUSH SQUIRRELTAIL|SQUIRRELTAIL', 'ELE5'),
         VEG = str_replace(VEG, 'TREES|TREE', 'TR'),
         VEG = str_replace(VEG, 'BASIN WILDRYE', 'LECI4'),  
         VEG = str_replace(VEG, 'SALINA WILDRYE', 'LESAS'), 
         VEG = str_replace(VEG, 'BROOMSNAKEWEED|SNAKEWEED', 'GUSA'), 
         VEG = str_replace(VEG, 'WINTERFAT', 'KRLA'), 
         VEG = str_replace(VEG, 'FOURWING SALTBUSH', 'ATCA2'), 
         VEG = str_replace(VEG, 'BLACK SAGEBRUSH', 'ARNO4'),
         VEG = str_replace(VEG, 'NEEDLE AND THREAD', 'HECO26'),
         VEG = str_replace(VEG, 'YELLOW RABBITBRUSH|RABBITBRUSH', 'CHVI'), 
         VEG = str_replace(VEG, 'HALOGETON', 'HAGL'),
         VEG = str_replace(VEG, 'MUTTONGRASS', 'POFE'), 
         VEG = str_replace(VEG, 'ALKALI SACATON', 'SPAI'),  
         VEG = str_replace(VEG, 'IODINEBUSH', 'ALOC2'), 
         VEG = str_replace(VEG, 'SALTGRASS', 'DISP'), 
         VEG = str_replace(VEG, 'SHADSCALE|SHADCALE', 'ATCO'), 
         VEG = str_replace(VEG, 'BIGELOWS SAGEBRUSH', 'ARBI3'), 
         VEG = str_replace(VEG, 'PERENNIAL SHRUB|SHRUB', 'SH'), 
         VEG = str_replace(VEG, 'MAT SALTBUSH', 'ATCO4'), 
         VEG = str_replace(VEG, 'BUD SAGEBRUSH', 'PIDE4'), # WYOMING BIG SAGE
         VEG = str_replace(VEG, 'WYOMING BIG SAGE', 'ARTRW8'),
         VEG = str_replace(VEG, 'BLACKBRUSH', 'CORA'),
         VEG = str_replace(VEG, 'WESTERN WHEATGRASS', 'PASM'),
         VEG = str_replace(VEG, 'NEBRASKA SEDGE', 'CANE2'), 
         VEG = str_replace(VEG, 'PERENNIAL GRASS', 'PG'), 
         VEG = str_replace(VEG, 'BASIN BIG SAGEBRUSH', 'ARTRT'), 
         VEG = str_replace(VEG, 'SEDGES', 'CAREX'), 
         VEG = str_replace(VEG, 'RUSHES', 'JUNCUS'), 
         VEG = str_replace(VEG, 'ALDERLEAD MT. MAHOGANY', 'CEMO2') # IS THIS RIGHT ?
)

unique(veg_states$VEG)
