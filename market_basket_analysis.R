library(tidyverse)
library(arules)
library(lubridate)

rec <- read_csv("/Users/BOYA/Documents/GitHub/GithubwithRstudio/data/AssociationRules.csv")
head(rec)
str(rec)

################## data wrangling ####################################

# on data and time
datetime <- dmy_hm(rec$`Created On`)
checkdata <- if_else(is.na(datetime), 0, 1)
rec$newDate <- if_else(checkdata == 1, dmy_hm(rec$`Created On`), ymd_hm(rec$`Created On`))

# on Order and SKU data format
rec$Order <- as.factor(rec$Order)
rec$SKU <- as.factor(rec$SKU)
# on Description forrmat
rec$Description <- as.factor(rec$Description)
# convert data frame into transaction data 
aa <- rec[,c(2,3)]
write.csv(aa, file = "./data/indian_grocery.csv", row.names = FALSE)

trr <- read.transactions("./data/indian_grocery.csv", format = "single", header = TRUE, sep = ",", cols = c("Order", "SKU"))
inspect(trr[8387])
summary(trr)
