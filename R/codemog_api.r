#' Links R to the URL based REST API for the CO Demogrpahy Office Databases
#'
#' Takes some basic geographic information along with the table/field and 
#' dataset to grab tables from the CO Demography Office cleaned Census
#' databases.
#' 
#' @param datacall table or field based on call, field if specific column, table for all Defaults to table
#' @param data number of either a census product table or table and field number based on the datacall
#' @param db database c1980, c1990, c2000, c2010 for Census Data, acs0812 or acs0913 for ACS data
#' @param geonum a geographic identifier created by 1 followed by a State FIPS and a PLace/County FIPS Defaults to 108
#' @param sumlev can be used to call all geographies in a summary level (See Census for Definitions) Defaults to NULL
#' @param type can siwtch between JSON and CSV for output format (pretty much use CSV only) Defaults to CSV
#' @param meta a command that indicates whether include feild and table meta data in line 2 Defaults to yes

codemog_api=function(datacall="table",data, db="c2010", geonum="108", sumlev=NULL, type="csv", meta="yes"){
  
  url_base="http://codemogapi-166520.usw1.nitrousbox.com/demog.php?"
  
  call=switch(datacall,
              field=paste("&field=", data, sep=""),
              table=paste("&table=", data, sep=""))
  db=paste("db=", db, sep="")
  geonum=paste("&geonum=", geonum, sep="")
  sumlev=paste("&sumlev=", sumlev, sep="")
  type=paste("&type=", type, sep="")
  url=paste(url_base,db,call,geonum,sumlev,type, sep="")
  x=read.csv(url, stringsAsFactors=FALSE)
  y=switch(meta,yes=x, no=x[-1,])
  return(y)
}