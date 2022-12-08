library(tidyverse)

setwd('/media/sagesteppe/ExternalHD/UFO_ESD_completion/scripts')
p <- '../data'
f <- list.files(file.path(p, 'raw'), pattern = 'csv$')

################################################################################
# CLEAN UP THE QUANTITATIVE BENCHMARKS OF VEGETATION COVER BY FUNCTIONAL GROUP
veg_bench <- read.csv(file.path(p, 'raw', f[grep('Quantitative', f)])) %>% 
  separate(COVER_PRCNT, c('LOWER', 'UPPER'), sep = '-') %>% 
  rename(ECO.SITE = ECOLOGICAL_SITE) %>% 
  mutate(UPPER = ifelse(is.na(UPPER), 0, UPPER))  %>% 
  mutate(COVER_TYPE = str_replace(COVER_TYPE, 'BARGROUND', 'BAREGROUND'), 
         ECO.SITE = str_replace(ECO.SITE,'R042XB036NM', 'R042BB036NM')) 

write.csv(veg_bench, file.path(p, 'processed', f[grep('Quantitative', f)]), row.names = F)
rm(veg_bench)

################################################################################
# CLEAN UP THE QUASI-HOPEFULLY ORDERED PLANT COVERS BY FUNCTIONAL GROUP
veg_states <- read.csv(file.path(p, 'raw', f[grep('Ordered', f)])) %>% 
  mutate(across(.cols = everything(), ~ str_trim(.x))) %>% 
  mutate(across(where(is.character), ~na_if(., ""))) %>% 
  mutate(STATE = str_remove(STATE, ' STATE'),
         STATE = str_replace(STATE, 'DEDPAUPERATE', 'DEPAUPERATE')
         ) %>% 
  mutate(VEG = str_replace(VEG, 'HERB.$', 'FORB'),
         VEG = str_replace(VEG, 'FOBR|FORBS', 'FORB'),
         VEG = str_replace(VEG, 'PERENNIAL FORB', 'PF'), 
         VEG = str_replace(VEG, 'SHRUBS', 'SHRUB'),
         VEG = str_replace(VEG, 'TREES|TREE', 'TR'),
         VEG = str_replace(VEG, 'PERENNIAL GRASSES|PERENNIAL GRASS', 'PG'), 
         VEG = str_replace(VEG, 'PERENNIAL SHRUB|SHRUB', 'SH'), 
         
         VEG = str_replace(VEG, 'TORREY MORMONTEA|TORREYS JOINTFIR', 'EPTO'),
         VEG = str_replace(VEG, 'MORMONTEA', 'EPHEDRA'),
         
         VEG = str_replace(VEG, 'GALLETA|JAMES GALLETA', 'PLJA'),
         VEG = str_replace(VEG, 'INDIAN RICEGRASS|AHCY', 'ACHY'),
         VEG = str_replace(VEG, 'CHEATGRASS', 'BRTE'),
         VEG = str_replace(VEG, 'BLUE GRAMA', 'BOGR2'), 
         VEG = str_replace(VEG, 'BOTTLEBRUSH SQUIRRELTAIL|SQUIRRELTAIL', 'ELE5'),
         VEG = str_replace(VEG, 'BASIN WILDRYE', 'LECI4'),  
         VEG = str_replace(VEG, 'SALINA WILDRYE', 'LESAS'), 
         VEG = str_replace(VEG, 'NEEDLE AND THREAD', 'HECO26'),
         VEG = str_replace(VEG, 'MUTTONGRASS', 'POFE'), 
         VEG = str_replace(VEG, 'ALKALI SACATON', 'SPAI'),  
         VEG = str_replace(VEG, 'SALTGRASS', 'DISP'), 
         VEG = str_replace(VEG, 'WESTERN WHEATGRASS', 'PASM'),
         VEG = str_replace(VEG, 'NEBRASKA SEDGE', 'CANE2'), 
         VEG = str_replace(VEG, 'SEDGES', 'CAREX'),
         VEG = str_replace(VEG, 'RUSHES', 'JUNCUS'), 
         VEG = str_replace(VEG, 'GRASSES', 'GRASS'),
         
         VEG = str_replace(VEG, 'HALOGETON', 'HAGL'),
         VEG = str_replace(VEG, 'BROOMSNAKEWEED|SNAKEWEED', 'GUSA'), 
         VEG = str_replace(VEG, 'WINTERFAT', 'KRLA'), 
         VEG = str_replace(VEG, 'FOURWING SALTBUSH', 'ATCA2'), 
         VEG = str_replace(VEG, 'YELLOW RABBITBRUSH|RABBITBRUSH', 'CHVI8'), 
         VEG = str_replace(VEG, 'IODINEBUSH', 'ALOC2'), 
         VEG = str_replace(VEG, 'BLACKBRUSH', 'CORA'),
         VEG = str_replace(VEG, 'SHADSCALE|SHADCALE', 'ATCO'), 
         VEG = str_replace(VEG, 'ALDERLEAD MT. MAHOGANY', 'CEMO2'), 
         
         VEG = str_replace(VEG, 'BLACK SAGEBRUSH', 'ARNO4'),
         VEG = str_replace(VEG, 'BIGELOWS SAGEBRUSH', 'ARBI3'), 
         VEG = str_replace(VEG, 'MAT SALTBUSH', 'ATCO4'), 
         VEG = str_replace(VEG, 'BASIN BIG SAGEBRUSH', 'ARTRT'), 
         VEG = str_replace(VEG, 'WYOMING BIG SAGE|BIG SAGEBRUSH|ARTW8', 'ARTRW8'),
         VEG = str_replace(VEG, 'BUD SAGEBRUSH', 'PIDE4'), 
         
         VEG = str_replace(VEG, 'PINYON JUNIPER|PINYON-JUNIPER', 'PJ'),
         VEG = str_replace(VEG, 'TWONEEDLE PINYON|TWO-NEEDLE PINYON|TWO NEEDLE PINYON|PINYON', 'PIED'),
         VEG = str_replace(VEG, 'UTAH JUNIPER', 'JUOS'),
         
         VEG = str_replace(VEG, 'INVASIVES|INVASIVE', 'NOXIOUS'),
         VEG = str_replace(VEG, 'ANNUAL NON-NATIVES', 'ANNUAL NON-NATIVE'),
         VEG = str_replace(VEG, 'ANNUAL NOXIOUS|NOXIOUS ANNUALS', 'NOXIOUS ANNUAL')
) %>% 
  rename(ECO.SITE = ESD.CODE)

# sort(unique(veg_states$VEG))

veg_states <- veg_states %>% 
  mutate(STATE = str_remove(STATE, ' STATE'),
         STATE = str_trim(STATE),
         STATE = str_replace(STATE, 'DEDPAUPERATE', 'DEPAUPERATE'),
         STATE = str_replace(STATE, 'REFEENCE', 'REFERENCE'),
         STATE = str_replace(STATE, 'PJ', 'PINYON-JUNIPER'),
         STATE = str_replace(STATE, '^POTENTIAL', 'CURRENT POTENTIAL'))

veg_states <- veg_states %>% 
  mutate(PHASE.NAME = str_trim(PHASE.NAME), 
         PHASE.NAME = str_replace(PHASE.NAME, 'PERENNAIL|PERRENIAL', 'PERENNIAL'), 
         PHASE.NAME = str_replace(PHASE.NAME, 'WOODALND', 'WOODLAND'),
         PHASE.NAME = str_replace(PHASE.NAME, 'INVASIVE ANNUALS', 'INVASIVE ANNUAL'),  
         PHASE.NAME = str_replace(PHASE.NAME, 'JUNIPER ENCHROACHMENT', 'JUNIPER ENCROACHMENT'),
         PHASE.NAME = str_replace(PHASE.NAME, 'SHRULAND', 'SHRUBLAND'), 
         PHASE.NAME = str_replace(PHASE.NAME,
                                  'TWONEEDLE PINYON, UTAH JUNIPER|UTAH JUNIPER, TWO-NEEDLE PINYON|PINYON-JUNIPER', 'PJ'),
         PHASE.NAME = str_replace(PHASE.NAME,
                                  'PJ WOODLAND WITH INVASIVE PLANTS', 'PJ WOODLAND WITH INVASIVE SPECIES'),
         PHASE.NAME = str_replace(PHASE.NAME, 'W/', 'WITH') 
         ) # SHRULAND

write.csv(veg_states, file.path(p, 'processed', f[grep('Ordered', f)]),  row.names = F)
rm(veg_states)

##################################################################################
# CLEAN UP THE PRODUCTION VALUES TABLES. 

comm_table <- read.csv(file.path(p, 'raw', f[grep('Production', f)])) %>% 
  drop_na(PHASE) %>%  # blank lines used in the transcription process for clarity
  mutate(
    ESD.CODE = str_replace(ESD.CODE, 'R026XY114CO', 'R036XY114CO'),
    STATE = str_replace(STATE, 'CURRENT POTENTIAL STATE', 'POTENTIAL'),
    STATE = str_replace(STATE, 'REFEENCE|REFERECNE', 'REFERENCE'),
    FUNCTIONAL = str_replace(FUNCTIONAL, 'TREES', 'TREE'),
    
    SYMBOL = str_trim(SYMBOL),
    SYMBOL = str_to_upper(SYMBOL)) %>% 
  #separate(PRODUCTION, c('LOWER', 'UPPER'), sep = '-') %>%  
  rename(LOWER = Lower, UPPER = Upper) %>% 
  mutate(PHASE.NAME = ifelse(PHASE.NAME == "", PHASE, PHASE.NAME)) %>% 
  rename(ECO.SITE = ESD.CODE)


# UPDATE ALL PLANTS WHICH 'ARE' MISSING FROM THE USDA LIST, THESE TYPOS. 
USDA_pls_codes <- read.csv(file.path(p, 'raw', f[grep('reference', f)]))  
comm_tab2 <- comm_table %>%  
  filter(SYMBOL %in% USDA_pls_codes$Synonym.Symbol)
comm_table <- comm_table %>% 
  mutate(
    SYMBOL = str_replace(SYMBOL, 'SYRO2', 'SYRO'), 
    SYMBOL = str_replace(SYMBOL, 'COWR7|COWR4$', 'COWR2'),
    SYMBOL = str_replace(SYMBOL, 'PESH', 'PEWH'), 
    SYMBOL = str_replace(SYMBOL, 'ERRA$', 'ERRA3'))

rm(comm_tab2)

trouble <- comm_table %>%  # update all codes to appropriate synonyms here. 
  filter(!SYMBOL %in% USDA_pls_codes$Symbol)

comm_table <- comm_table %>% 
  mutate(SYMBOL =  str_replace(SYMBOL, 'GUA', 'GUSA'),
         SYMBOL =  str_replace(SYMBOL, 'ATC0', 'ATCO'),
         SYMBOL =  str_replace(SYMBOL, 'ATRW8', 'ARTRW8'),
         SYMBOL =  str_replace(SYMBOL, 'CRGR2$|CRGR$', 'CRGR3'),
         SYMBOL =  str_replace(SYMBOL, 'PERA 4', 'PERA4'),
         SYMBOL =  str_replace(SYMBOL, 'ARNAN5', 'ERNA10'),
         SYMBOL =  str_replace(SYMBOL, 'ELE5', 'ELEL5'), 
         SYMBOL =  str_replace(SYMBOL, 'ARNO$', 'ARNO4'), 
         SYMBOL =  str_replace(SYMBOL, 'SRBI3', 'ARBI3'),
         SYMBOL =  str_replace(SYMBOL, 'PIDE$', 'PIDE4'),
         SYMBOL =  str_replace(SYMBOL, 'TRLD', 'TRLO'), 
         SYMBOL =  str_replace(SYMBOL, 'PPHO', 'PHLO'),
         SYMBOL =  str_replace(SYMBOL, 'OXYTRE', 'OXYTR'),
         SYMBOL =  str_replace(SYMBOL, 'ERISH', 'ERSH'),
         
         SYMBOL =  str_replace(SYMBOL, '2FA', 'AF'), 
         SYMBOL =  str_replace(SYMBOL, '2FP', 'PF'),
         SYMBOL =  str_replace(SYMBOL, '2GA', 'AG'),
         SYMBOL =  str_replace(SYMBOL, '2GP', 'PG'),
         SYMBOL =  str_replace(SYMBOL, '2GRAM', 'GRAM'),
         SYMBOL =  str_replace(SYMBOL, '2SHRUB', 'SH'),
         ) 



write.csv(comm_table, file.path(p, 'processed', f[grep('Production', f)]), row.names = F )
rm(comm_table, trouble, USDA_pls_codes)

################################################################################
# TRANSCRIPTION TRACKING SHEET

tracking <- read.csv(file.path(p, 'raw', f[grep('Transcription', f)])) %>% 
  mutate(across(.cols = everything(), ~ na_if(.x, ""))) %>% 
  filter(!NOTES %in% c('duplicate')) %>% 
  mutate(NAME = str_to_title(NAME))
colnames(tracking) <- c('ECO.SITE', 'PLOTS', 'STATETRANSITION.PRODUCTION', 
                        'ASSOCIATED.SITES', 'QUANTITATIVE.BENCHMARKS', 'ESD.NAME', 'NOTES')

write.csv(tracking, file.path(p, 'processed', f[grep('Transcription', f)]), row.names = F )
rm(tracking)

###############################################################################
# PLOT TRACKING SHEET WITH ESDS

original_pts <- st_read(
  '/media/sagesteppe/ExternalHD/aimDB/data/raw/AIM_Sample_Design/AIM_Design_Stratification.shp',
  quiet = T)

plottracking <- read.csv(file.path(p, 'raw', f[grep('PlotTracking', f)])) %>% 
  select(Plot.ID, Panel, STATUS = Plot.Status, Ecological.Site) %>% 
  rename_all(., .funs = toupper) %>% 
  mutate(
    PANEL = str_to_lower(PANEL),
    PLOT.ID = str_trim(str_replace_all(PLOT.ID, '[0-9]{1,3}$', 
                          str_pad(
                            str_extract(PLOT.ID, '[0-9]{1,3}$'), 3, "left", 0)
                          )),
    STATUS = str_to_upper(STATUS),
    
    ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 
  'No ecosite listed|Need To find 2018 Ecosites' , 'NEED MATCHED')) %>% 
  mutate(ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R0356XY445CO', 'R036XY445CO'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R035XY109UT', 'R036XY325CO'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R035XY325CO', 'R036XY445CO'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R035XY326CO', 'R036XY326CO'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R035XY315UT', 'R036XY315UT'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R036XY328UT', 'R036XY328CO'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R035XY316UT', 'R036XY316UT'),
         ECOLOGICAL.SITE = str_replace(ECOLOGICAL.SITE, 'R034XY404CO', 'R034BY404CO'),
         ) %>% # 'R036XY328CO' was drafted out of 'R034BY328CO'
  
  mutate(ECO.SITE = str_extract(ECOLOGICAL.SITE, "R0.*?CO|R0.*?UT|F0.*?CO"), 
         ECO.SITE = if_else(is.na(ECO.SITE), ECOLOGICAL.SITE, ECO.SITE), 
         ECO.SITE.MATCHED = str_detect(ECO.SITE, "[0-9]"), 
         PLOT.ID = str_trim(str_remove(PLOT.ID, 'Note:leave in for now, rejected last year'))) %>% 
  
  mutate(STATUS = str_trim(STATUS),
         STATUS = if_else(str_detect(STATUS, 'NOT IN TABLET'), 'NOT SAMPLED', STATUS),
           STATUS = str_replace(STATUS, 'REJECTION', 'REJECTED')) %>% 
  select(-ECOLOGICAL.SITE)

plottracking <- plottracking %>% 
  group_by(PLOT.ID) %>% 
  distinct(., .keep_all = T) 
pair2keep <- plottracking %>%  # These are odd copies
  group_by(PLOT.ID) %>% 
  filter(n() >= 2) %>% 
  filter(str_detect(STATUS, '^SAMPLED$'))

plottracking <- plottracking %>% 
  filter(!PLOT.ID %in% pair2keep$PLOT.ID) %>% 
  bind_rows(., pair2keep)
rejected_over_notsampled <- plottracking %>% 
  group_by(PLOT.ID) %>% 
  distinct(., .keep_all = T) %>% 
  filter(n() >= 2, STATUS == 'REJECTED')

plottracking <- plottracking %>% 
  filter(!PLOT.ID %in% rejected_over_notsampled$PLOT.ID) %>% 
  bind_rows(., rejected_over_notsampled)
plottracking <- anti_join(original_pts, plottracking, by = c('PLOTID' = 'PLOT.ID')) %>% 
  select(PLOT.ID = PLOTID, PANEL) %>% 
  mutate(PANEL = str_to_lower(PANEL)) %>% 
  mutate(STATUS = 'NOT SAMPLED', ECO.SITE = NA, ECO.SITE.MATCHED = NA) %>% 
  st_drop_geometry() %>% 
  bind_rows(., plottracking)

unique(plottracking$ECO.SITE)

write.csv(plottracking, file.path(p, 'processed', 'Plot_Tracking_ESDs.csv'), row.names = F )

rm(plottracking, original_pts, pair2keep, rejected_over_notsampled)
# clean up

rm(f,p)
