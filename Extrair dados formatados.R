require(RCurl)
require(dplyr)
#http://pt.stackoverflow.com/questions/8056/apply-sapply-mapply-lapply-vapply-rapply-tapply-replicate-aggregate-by-e
#http://blog.revolutionanalytics.com/2014/06/reading-data-from-the-new-version-of-google-spreadsheets.html


#Função para extrair dados já formatado

getGoogleDataset <- function(id) {
  download.file(paste0('https://docs.google.com/spreadsheets/d/', id, '/export?format=csv'),'google-ds.csv','curl');
  lines <- scan('google-ds.csv', character(0), sep="\n");
  
  pattern <-"\"([0-9]+),([0-9]+)";
  for (i in 0:length(lines)) {
    while (length(grep(pattern,lines[i]))> 0) {
      lines[i] <- gsub(pattern,"\"\\1\\2",lines[i]);
    }
  }
  return(read.csv(textConnection(lines)));
}


dados <- getGoogleDataset(id = '13rmBp932vSAEvJ8LchRwNlW5R8_7Sh-ioSnsJk2VmvY')
