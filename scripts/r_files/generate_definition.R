library(pipeline)

# Set folder paths
setwd("~/Google Drive/dev/R/CWAnalysis/analysis/data")
pathToScriptFolder = "../scripts"
pathToDataFolder = "../data"

# Set data file
data_file_path = file.path(pathToDataFolder, "computed/preprocessed/preprocessed_data.Rdata")

# Load processed data for grouped analysis and correlation data
data = get(load(data_file_path))

# Create the formatter and set the data to be formatted
formatter = Formatter$new()
formatter$set_data(data)

# Get a definition object and save it as a .csv to be modified manually if necessary
data_definition = formatter$get_data_definition()

definition_filepath = gsub(".Rdata" , ".definition.csv", data_file_path)
write.csv(data_definition, file = definition_filepath, row.names = F)

# get the formatted data (automatic formatting)
auto_formatted_data = formatter$formatted()

# save auto-formatted data
formatted_data_file_path <- sub("(/)([^/]*)$", "/formated_\\2", data_file_path, perl = T)
save(auto_formatted_data, file = formatted_data_file_path)

# modify the definition csv as/if necessary and load modified definition
modified_definition_filepath = gsub(".definition.csv", ".mod.definition.csv", definition_filepath)
modified_data_definition = read.csv(modified_definition_filepath)

# set the new format using the modified definition
formatter$set_data_definition(data_definition = modified_data_definition)

# get the formatted data
formatted_data = formatter$formatted()

# Get a definition object that results from the import of the modified definition
# Remaining data might have been left out from the mod.csv - this file is postfixed .complete.
# And save it as a .csv to be modified manually if necessary
data_definition_complete = formatter$get_data_definition()

definition_filepath = gsub(".Rdata" , ".complete.definition.csv", data_file_path)
write.csv(data_definition_complete, file = definition_filepath, row.names = F)

# save the newly formatted data with a formatted_ prefix
formatted_data_file_path <- sub("(/)([^/]*)$", "/formated_\\2", data_file_path, perl = T)
save(formatted_data, file = formatted_data_file_path)

