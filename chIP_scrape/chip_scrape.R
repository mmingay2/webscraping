#scrape chipbase for bed files
library(dplyr)
library(ggplot2)
library(reshape2)
library(rvest)
library(RCurl)
pref <- "http://rna.sysu.edu.cn/chipbase/chip_seq_browse.php?organism=human&assembly=hg38&protein="
alltfs <- read.csv("~/Google Drive/github_share/webscraping/alltfs.csv", header=F)$V1
tfbeds <- NULL

#for (j in 1:12) {

  for (i in 3349:10000) {
    tryCatch({  
      nz <- 5-nchar(as.character(i))
      samplid <- paste(replicate(nz, "0"), collapse = "")
      urltex <- paste0(pref, "NA&sample_id=HUMHG", samplid, as.character(i))
      url <- read_html(urltex)
      cell = url %>% html_node("tr:nth-child(1) .text-right+ td") %>% html_text()
      dlink = url %>% html_node("#export > span:nth-child(3)") %>% html_node("a") %>% html_attr("href") %>% gsub("\\./download","http://rna.sysu.edu.cn/chipbase/download", .)
      proj_id = url %>% html_node("#detail_table a") %>% html_attr("href")
      info = url %>% html_node("tr:nth-child(2) .text-right+ td") %>% html_text() %>% strsplit(",") %>% unlist()
      cell_class = gsub(" ", "", info[1])
      type = gsub(" ", "", info[2])
      desc = url %>% html_node("tr:nth-child(6) .text-right+ td") %>% html_text()
      prog = url %>% html_node("tr:nth-child(4) .text-right+ td") %>% html_text()
      temp <- data.frame(cell,  proj_id, treatment, mark,desc,prog, dlink, urltex)
      tfbeds <- rbind(tfbeds, temp)
      })
    cat(i, "..\r")
  }

write.csv(tfbeds, "~/Google Drive/github_share/webscraping/allbeds.csv")
tfbeds <- read.csv("~/Google Drive/github_share/webscraping/allbeds.csv")
