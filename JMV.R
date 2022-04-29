install.packages('jmvtools', repos='https://repo.jamovi.org')
jmvtools::check()
jmvtools::check(home = "C:/Program Files/jamovi 2.2.5.0")
options(jamovi_home = "C:/Program Files/jamovi 2.2.5.0")

setwd("termfrequency") 
jmvtools::addAnalysis(name = 'termfrequency', title='Term Frequency')
jmvtools::install()              

