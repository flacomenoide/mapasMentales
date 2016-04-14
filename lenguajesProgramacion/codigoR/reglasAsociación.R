library(arules)
#library(arulesViz)

# Create some transactional data.
id <- c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3)
item <- c("b", "d", "e", "a", "b", "c", "e", "b", "c", "d", "e")

# Push the data to the database as an ore.frame object.
### transdata_of <- ore.push(data.frame(ID = id, ITEM = item))
transdata_of <- data.frame(ID = id, ITEM = item)
transdata_of$ID <- as.factor(transdata_of$ID)
# Build a model with specifications.
###ar.mod1 <- ore.odmAssocRules(~., transdata_of, case.id.column = "ID", item.id.column = "ITEM", min.support = 0.6, min.confidence = 0.6, max.rule.length = 3)
transdata_of_mat <- as(split(transdata_of$ITEM, transdata_of$ID), "transactions")
ar.mod1 <- apriori(transdata_of_mat, parameter = list(supp=0.3, confidence= 0.3, minlen=2, maxlen=3))
# Generate itemsets and rules of the model.
#itemsets <- itemsets(ar.mod1)
#rules <- rules(ar.mod1)
inspect(ar.mod1)
#itemsets.arules <- ore.pull(itemsets)
#inspect(itemsets.arules)