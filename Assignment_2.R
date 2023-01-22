# # Assignment 2
# 
# # finding files
# list.files()
# 
# #recursively
# list.files(resursive = TRUE)
# 
# #with a search pattern
# # find all .csv files, recursively in your DATA_COURSE_LASTNAME.
# csvs <- list.files(pattern = ".csv",
#                    recursive = TRUE)
# 
# 
# airlines <- csvs[1]
# # question mark can help you when needed
# ?readlines()
# readLines(airlines,n=3)
# 
# airlines <- read.csv[1]
# readLines(airlines)
# 
# # numeric vectors
# x <- 1:10
# length(x) * 2
# length(5)
# # everything in R is vectorized
# y <- 2:11
# x
# y
# x + y
# x * y
# x/y
# x^y
# 
# # expressions (logical)
# sum(x > 3)
# TRUE
# FALSE
# TRUE+FALSE
# TRUE+TRUE
# TRUE / FALSE
# x >= 3 # greater than or equal to
# x <= 5 # less than or equal to
# x == 5 # is equal to
# 
# wingspan <- read.csv("Data_Course/Data/wingspan_vs_mass.csv")
# names(wingspan) # show names of elements
# names (x) # no names in this vector
# 
# wingspan$mass
# sum(wingspan$mass >= 70)
# 
# wingspan$giant <- wingspan$mass >= 70
# 
# plot(x=wingspan$wingspan,y=wingspan$mass)
# plot(x=wingspan$wingspan,y=wingspan$mass)
# wingspan$mass >= 70
# 
# getwd

# Doing assignment 2
# 4
csv_files <- list.files(path="/Data_Course/Data", pattern = '.csv')

# 5
length(csv_files)

#6 
df <- read.csv("Data_Course/Data/wingspan_vs_mass.csv")

#7 
?head()
head(df,5)
head(df,n=5)

#8 
list.files(path="Data_Course/Data", 
           recursive = TRUE,
           pattern = "^b",
           full.names = TRUE)
#9
b <- list.files(path="Data_Course/Data", 
           recursive = TRUE,
           pattern = "^b",
           full.names = TRUE)
readLines(b[1],n=1)
readLines(b[2],n=1)
readLines(b[3],n=1)

# for loops
for(i in b){
  print(
    # redo this task using for-loop
    readLines(i,n=1)
  )
}


# ^ $ beginning and ending of a pattern

#10
all_csv_files <- list.files(path="Data_Course/Data", 
                recursive = TRUE,
                pattern = ".csv",
                full.names = TRUE)
# for loops
for(i in all_csv_files){
  print(
    # redo this task using for-loop
    readLines(i,n=1)
  )
}
