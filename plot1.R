library("data.table")
library("ggplot2")

# Download data for the first time
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

# Initialization
SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

# Output graph
png(filename='plot1.png')

# Plot graph
barplot(totalNEI[, Emissions], names = totalNEI[, year], xlab = "Years", ylab = "Emissions", main = "Emissions over the Years")

# Close
dev.off()