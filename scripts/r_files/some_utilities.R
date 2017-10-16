library(lubridate)
library(data.table)
library(psych)
library(ggplot2)
library(xlsx)
library(RJSONIO)
# library(epitools)

library(tableone)
# library(graphics)
# library(pastecs)

# library(e1071)
library(fBasics)

# Loadez ces fonctions comme en rajoutant cette ligne en haut de vos scripts:
# source("script/utilities/functions.R")

loadJson = function (filename) {
  #data_general = data.table(read.csv(file_path)) # Loads data and
  json_file = fromJSON(file_path)
  json_file = lapply(json_file, function(x) {
    x[sapply(x, is.null)] <- NA
    unlist(x)
  })

  # As data.table
  data = data.table(do.call("rbind", json_file))

  return(data)
}


to_numeric = function (data, columns, offset = 0) {
  for(i in 1:length(columns)) {
    data[, (columns[i]) := as.numeric(data[, get(columns[i])]) - offset]
  }
  return(data)
}



id_from_callback = function (data, callbackColumn = "callback", idCol= "subjID") {
  splitN = function (char, by = ",", i = 1) {
    splited = NULL
    for(j in 1:NROW(char)) {
      splited = c(splited, strsplit(as.character(char[j]), by)[[1]][i])
    }
    return(splited)
  }

  data[, (idCol) := splitN(get(callbackColumn), ",", 1)]
}

age_from_date = function (data, idCol = "subjID", birthdate_column="Veuillez_entrer.._", date_of_test_col = "Date_de_lancement") {
  data[, ageInSeconds := period_to_seconds(as.period(ymd_hms(get(birthdate_column))%--%ymd_hms(get(date_of_test_col)))), by=idCol]
  data[, ageInDaysFromBirthDate := ageInSeconds/86400, by=idCol]
  data[, ageInYearsFromBirthDate := ageInSeconds/3.154e+7, by=idCol]
}

load_rename_select = function(working_directory = "~/Dropbox/CWIQ_master/analysis",
                              data_folder = NULL,
                              date = NULL,
                              filename,
                              oldnames = NULL,
                              newnames = NULL,
                              goodIds = NULL,
                              type = "csv",
                              idCol = "subjID",
                              fromCallback = F) {
  # Build the file path
  file_path = file.path(working_directory, data_folder , date, filename)

  # load data
  if (type == "csv") {
    data = data.table(read.csv(file_path))
  } else if (type == "json") {
    data = loadJson(file_path)
  } else {
    stop("load_rename_select: Unknown file type")
  }

  # Change column names
  if (!is.null(newnames) && is.null(oldnames) && (NROW(newnames) == NROW(names(data)))) {
    setnames(data, names(data), newnames)
  } else if (!is.null(newnames) && !is.null(oldnames)) {
    setnames(data, oldnames, newnames)
  }

  # Look if id needs to be extracted from callback
  if (fromCallback) {
    id_from_callback(data)
  }

  # Select only valid subjects
  if (!is.null(goodIds)) {
    data = data[get(idCol)%in%goodIds,]
  }

  # return the loaded data
  return(data)
}


generate_table = function(columns, data, strata_g = NULL) {
  columns = unique(columns)
  catVar = NULL
  sapply(columns, function(name) {
    if (class(data[[name]])%in%"factor") {
      catVar <<- c(catVar, name)
    }
  })

  data_filtered = data[, unique(c(columns,strata_g)), with=F]

  if (is.null(strata_g)) {
    table_g <- CreateTableOne(vars = columns, data = data_filtered, factorVars = catVar, includeNA = T)
  } else {
    table_g <- CreateTableOne(columns, data_filtered, catVar, strata = strata_g, includeNA = T)
  }


  mat_g <- print(table_g, exact = "stage", quote = FALSE, noSpaces = TRUE, printToggle = FALSE)

  return(mat_g)
}

corr.test.2latex = function (data, variables = NULL, method="spearman", ...) {
  rs = corr.test(data[, variables, with=F], method=method) #find the probabilities of the correlations
  cp =corr.p(r=rs$r, n = NROW(data))

  cpp = rs$r
  cpp[cp$p>0.05] = 3

  colnames(cpp) = paste0(1:NROW(cpp), ".")
  rownames(cpp) = paste(colnames(cpp), gsub("_", " ", rownames(cpp), perl=T))

  cpp[upper.tri(cpp)] = NA
  output = df2latex(cpp, silent = T, file="tempcorrtest.txt")

  output = paste0(gsub(pattern = "3.00",replacement = ".", output, fixed = T))
  output = gsub(pattern = "\n",replacement = "", output, fixed = T)
  return(output)
}

# Plot designs
line_design = list(geom_line(position = position_dodge(0.4),alpha= 0.5,size=0.8), geom_point(size=2, position = position_jitterdodge(dodge.width = 0.4, jitter.width = 0, jitter.height = 0.01),alpha=0.7), theme_bw())
big_point_design = list(geom_point(position = position_dodge(width=0.5), size=4), theme_bw())

