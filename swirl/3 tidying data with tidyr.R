library(tidyr)

#gather
# column headers are values
student
?gather
gather(students, sex, count, -grade)


# separate
students2
res <- gather(students2, sex_class, count, -grade)
res
?separate
separate(data = res, col= sex_class, into = c("sex", "class"))


students2 %>%
    gather( sex_class, count, -grade) %>%
    separate( sex_class, c("sex", "class")) %>%
    print
submit()


students3
students3 %>%
    gather( class, grade, class1:class5 , na.rm = TRUE) %>%
    print
submit()

# spread
?spread
students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    print
submit()

# extract_numeric
extract_numeric("class5")

students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    ### Call to mutate() goes here %>%
    mutate(class = extract_numeric(class)) %>%
    print
    
submit()
          

students4
student_info <- students4 %>%
    select( id, name, sex) %>%
    print
submit()

student_info <- students4 %>%
    select(id, name, sex) %>%
    ### Your code here %>%
    unique %>%
    print
submit()

gradebook <- students4 %>%
    ### Your code here %>%
    select(id, class, midterm, final) %>%
    print
submit()

# bind_rows
passed
failed
passed <- mutate(passed, status = "passed")
failed <- mutate(failed, status = "failed")

?bind_rows
bind_rows(passed, failed) # return tbl_df



sat
?select
?separate

sat %>%
    select(-contains('total')) %>%
    gather(part_sex, count, -score_range) %>%
    ### <Your call to separate()> %>%
    separate(part_sex, c("part", "sex")) %>%
    print
submit()

sat %>%
    select(-contains("total")) %>%
    gather(part_sex, count, -score_range) %>%
    separate(part_sex, c("part", "sex")) %>%
    ### <Your call to group_by()> %>%
    group_by(part, sex) %>%
mutate(total = sum(count),
       prop = count / total
) %>% print
submit()
