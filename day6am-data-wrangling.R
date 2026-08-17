# Packages contain functions and data. Load them with the `library()` function. 

library(tidyverse)

library(palmerpenguins)


# palmer penguins contains the penguins data frame 

penguins

# _**glimpse()**_ rotates the printing of a dataframe so you can see every column.

glimpse(penguins)

# each line correposnds to see what column is. very helpful for large datasets because the consle preview only shows up to 7 columns.


# Rows -------------------------------------------------------------------

## _**filter()**_

# keeps rows that satisfy one or more conditions

filter(penguins, sex == "female")
# There are two arguments in this expression 

filter(penguins, species == "Chinstrap")
# Filtering it on a different column

# What about this?
filter(penguins, species == "female")
# Filter always returns the dataframe with the rows that satisfy the condition. In this case there are no rows that satisfy. It is a dataframe with 0 rows.

filter(penguins, body_mass_g < 3000)

filter(penguins, sex == "female" | flipper_length_mm > 190)
# The single |, and & are the vectorized version of the || and && operator. This is being applied to the whole data frame and to all the rows. 
# Save the doubles for if and use the singles in data frames. 

## _**Arrange()**_

# Arrange and sorts rows by one or more columns.

arrange(penguins, bill_depth_mm)
arrange(penguins, island)
# Can sort by multiple columns (order matters)
arrange(penguins, island, bill_depth_mm)

# What if I want descending 0rder?
arrange(penguins, desc(body_mass_g))


## _**Distinct and Count**_

distinct(penguins, island)
# Good for wrapping your head around a new dataset.

count(penguins, island)
# It will add a new column to show you "n", which is the count of those entries. 

# Works on multiple columns too.
count(penguins, species, island)


# Columns ----------------------------------------------------------------

## _**mutate()**_

# adds or replaces columns; will also modify

mutate(penguins, body_mass_kg = body_mass_g / 1000)
penguins_kg_g <- mutate(penguins, body_mass_kg = body_mass_g / 1000)
select(penguins_kg_g, body_mass_kg, body_mass_g)

# mutate can create one or more column at a time

mutate(penguins, body_mass_kg = body_mass_g / 1000, bill_length_cm = bill_length_mm / 10)

# relocate columns using .before (ex, = 1 would put them before the old columns)
mutate(penguins, body_mass_kg = body_mass_g / 1000, bill_length_cm = bill_length_mm / 10,
.before = 1
)

## _**select()**_ chooses columns to retain (or exclude)

select(penguins, body_mass_g)

# helpers for select;
select(penguins, species:island)
# going to give us all of the columns in between (:)
select(penguins, species:bill_depth_mm)
# can also remove (!)
select(penguins, !species)

# the : will give us a range while a ! removes them. Can also use them together.
select(penguins, !island:bill_length_mm)

# select() family of helper functions
select(penguins, starts_with("bill")) # this will return columns thats start with bill.
select(penguins, ends_with("mm")) # this will returns columns that end will mm.
select(penguins, contains("length")) # this will return columns that contains the word length in. 




# Pipe -------------------------------------------------------------------

# Chaining together multiple functons is ugly. 
filter(mutate(penguins, body_mass_kg = body_mass_g / 1000), body_mass_kg < 2.8) # this is gross. dont. 

# Pipe to the rescue 
penguins |> 
    mutate(body_mass_kg = body_mass_g / 1000) |> 
    filter(body_mass_kg < 2.8)

# Your turn
# flip this into the correct order using pipes

penguins |> 
    arrange(species, bill_length_mm) |> 
    select(species:bill_length_mm)



# Summarize --------------------------------------------------------------

# Working with groups
penguins |> 
    summarize(avg_size = mean(body_mass_g))
# NA is R's way of representing missing data.

# So, do this instead.
penguins |> 
    summarize(avg_size = mean(body_mass_g, na.rm = TRUE))

# By default, summaries happen across the entire data frame
# Use .by to group

penguins |> 
    summarize(
        avg_size = mean(body_mass_g, na.rm = TRUE),
        .by = species
    )
 

# Grouping by multiple columns
penguins |> 
    summarize (
        avg_size = mean(body_mass_g, na.rm = TRUE),
        .by = c(species, island)
    )
# now we are seeing the average size at these different sites. 

# Creating multiple summmaries
penguins |> 
    summarize (
        avg_size = mean(body_mass_g, na.rm = TRUE),
        n_penguins = n(),
        .by = c(species, island)
    )


# MEMORIZE - 

#rows
#filter()
#arrange()

# columns
# select()
# mutate()

# groups
# summarize()
# n()
# the .by parameter