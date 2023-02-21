# Get all indicator-ids
#----------------------
url0="https://regionalatlas.statistikportal.de/taskrunner/services.json"
dat0=httr::content(httr::GET(url0))
categories=sapply(dat0,function(x)x$title)

dat=t(do.call(cbind,lapply(dat0,function(x)
	do.call(cbind,lapply(x$children,function(c) 
		do.call(cbind,lapply(c$attributes,function(a) 
			c(a$title_short,a$code,a$unit,a$meta,c$title_short,c$code,x$title))))))))
colnames(dat)=c("attribute-title","attibute-code","attribute-unit","attribute-meta","table-title","table-code","category")
dat=dat[,colnames(dat)!="attribute-meta"]

# Output Markdown-table
#----------------------
tab=paste(c(
	paste0("|",paste0(colnames(dat),collapse="|"),"|"),
	paste0("|",paste0(gsub(".*","---",colnames(dat)),collapse="|"),"|"),
	apply(dat,1,function(a)paste0("|",gsub("\n"," ",paste0(a,collapse="|")),"|"))),
	collapse="\n")

writeLines(tab,"table.txt")

