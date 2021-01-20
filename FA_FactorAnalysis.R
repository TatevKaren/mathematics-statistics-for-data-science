#--------------------------------------------------------------------------- 
#Factor Analysis 
#--------------------------------------------------------------------------- 
fa.data = factanal(data_log10, 3, rotation = "none")
fa.data
fa.dataRot = factanal(data_log10, 3, rotation = "varimax")
fa.dataRot
fa.dataRot
fa.dataRot = factanal(data_log10, 4, rotation = "varimax")
fa.dataRot
fa.dataRot = factanal(data_log10, 2, rotation = "varimax")
fa.dataRot
fa.dataRot = factanal(data_log10, 1, rotation = "varimax")
fa.dataRot
