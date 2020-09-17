# Not used.. See generate_pdfs_with_lat_long.R which does both document 
# creation and sending the emails


# 
# # packages ----------------------------------------------------------------
# 
# if (!requireNamespace("pacman")) install.packages("pacman")
# 
# pacman::p_load(gmailr)
# 
# 
# # load data ---------------------------------------------------------------
# 
# allLocations <- read.csv("https://github.com/sahirbhatnagar/EPIB607/raw/master/data/earth-locations-20180914.csv")
# str(allLocations)
# 
# allLocations$water  = 1*(allLocations$alt < 0)
# summary(allLocations)
# 
# 
# plot(allLocations$lon[allLocations$water==1],
#      allLocations$lat[allLocations$water==1],
#      col="blue",cex=0.02)
# 
# plot( table( round(allLocations $lat) ) )
# 
# # water only
# 
# depthsOfWater = allLocations[allLocations$water==1,]
# depthsOfWater$depth = -depthsOfWater$alt
# str(depthsOfWater)
# summary(depthsOfWater)
# hist(depthsOfWater$depth,breaks=100)
# 
# # emails ------------------------------------------------------------------
# 
# # stored on local laptop only for security reasons
# emails <- read.csv("~/Documents/EPIB607.csv", 
#                    stringsAsFactors = FALSE)
# 
# recipient = rep(c(               # for testing
#   "james.hanley@mcgill.ca",
#   "sahir@bhatnagar@mcgill.ca",
#   "james.hanley@mcgill.ca",
#   "james.hanley@mcgill.ca",
#   "james.hanley@mcgill.ca"), 17)
# 
# recipient = c("sahir.bhatnagar@mcgill.ca")
# 
# N.r = length(recipient)
# 
# 
# # testing MIME first ------------------------------------------------------
# 
# # before the mass mailing,
# # use this first time to be authenticated
# # I use option 2
# 
# MIME <- gmailr::mime(from = "sahir.bhatnagar@gmail.com",       
#                     to = "sahir.bhatnagar@mcgill.ca",
#                     subject = "hello", 
#                     body = "test") 
# send_message(MIME)
# 
# # cycle over recipients
# 
# 
# # template for sending ----------------------------------------------------
# 
# OffsetAll    = 0; # sequential, from very top (optional)
# OffsetDepths = 0;
# OffsetLand   = 0;  
# 
# cr = "\n"
# 
# m = matrix(NA, N.r, 4) # 1st 4 for 607 all  for bios601 
# 
# for(i in 1: N.r){
#   
#   BODY=paste(cr,"# ---- Covered by Water? (1=Yes) -----",cr)
#   
#   COL=0
#   
#   for (n in c(5,20) ) {
#     
#     COL = COL +1
#     
#     # for water(1/0)
#     
#     I = OffsetAll + 1:n
#     
#     LON = paste("Lon.n.",toString(n)," <- c(",
#                 paste(round(allLocations$lon[I],3),
#                       collapse=","),")", sep="" )
#     LAT = paste("Lat.n.",toString(n)," <- c(",
#                 paste(round(allLocations$lat[I],3),
#                       collapse=","),")", sep="" )
#     WATER = paste("Water.n.",toString(n)," = c(",
#                   paste(allLocations$water[I],
#                         collapse=","),")", sep="" )
#     m[i,COL] = mean(allLocations$water[I])
#     HITS = paste("sum(Water.n.",toString(n),")",sep="" )
#     
#     BODY = paste(BODY,cr,LON,cr,LAT,cr,cr,WATER,cr,cr,HITS,cr)
#     
#     OffsetAll = OffsetAll + n
#     
#   } # n
#   
#   BODY = paste(BODY,cr,"# ----- Water Depths ---------",cr)
#   
#   for (n in c(5,20) ) {
#     
#     COL=COL+1
#     
#     I = OffsetDepths + 1:n
#     
#     LON = paste("LON.n.",toString(n)," = c(",
#                 paste(round(allLocations$lon[I],3),
#                       collapse=","),")", sep="" )
#     LAT = paste("LAT.n.",toString(n)," = c(",
#                 paste(round(allLocations$lat[I],3),
#                       collapse=","),")", sep="" )
#     DEPTH = paste("Depth.n.",toString(n)," = c(",
#                   paste(depthsOfWater$depth[I],
#                         collapse=","),")", sep="" )
#     MEAN = paste("mean(Depth.n.",toString(n),")",sep="" )
#     
#     m[i,COL] = mean(depthsOfWater$depth[I])
#     
#     BODY = paste(BODY,cr,LON,cr,LAT,cr,cr,DEPTH,cr,cr,MEAN,cr)
#     
#     OffsetDepths = OffsetDepths + n
#     
#   } # n
#   
#   # BODY = paste(BODY,cr,"# ----- Land heights ---------",cr)
#   
#   # for (n in c(5,20) ) {
#   #   
#   #   COL=COL+1
#   #   
#   #   I = OffsetLand + 1:n
#   #   
#   #   ALT = paste("Elevation.n.",toString(n)," = c(",
#   #               paste(heightsOfLand$alt[I],
#   #                     collapse=","),")", sep="" )
#   #   MEAN = paste("mean(Elevation.n.",toString(n),")",sep="" )
#   #   
#   #   m[i,COL] = mean(heightsOfLand$alt[I])
#   #   
#   #   # BODY = paste(BODY,cr,LON,cr,LAT,cr,cr,DEPTH,cr,cr,MEAN,cr)
#   #   
#   #   OffsetLand = OffsetLand + 1
#   #   
#   # } # n
#   
#   MIME = mime(from="sahir.bhatnagar@gmail.com",       
#               to=recipient[i],
#               subject="data from random Earth locations", 
#               body=BODY) 
#   
#   send_message(MIME)
#   print(MIME)
#   
# } # end i (recipient)
