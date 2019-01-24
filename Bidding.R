##The following is a script to simulate an auction, where a certain number of
##bidders, each with a unique bid, present their bids in a random order. The
##purpose of the simulation is to determine, if we keep track of the highest
##bid seen so far, the number of times that updates because a bidder presents
##a higher bid, to compare with the theoretical expectation of ln n + 1 times,
##where n is the number of bidders.
##
##Created as part of a programming assignment for a Foundations of Algorithms
##course at Johns Hopkins University.
##
##@author Joseph Scheidt
##@version PA2

##set seed for reproducibility
set.seed(5381542)

##create data frame to store experiment results (column names are number of bidders)
results <- data.frame(integer(100), integer(100), integer(100), integer(100),
                      integer(100), integer(100))
names(results) <- c("10", "100", "1,000", "10,000", "100,000", "1,000,000")

##create array of bidder sizes
number_of_bidders <- c(10, 100, 1000, 10000, 100000, 1000000)

##For each bidder size group, we will run 100 random permutations, run through
##the bidding process, and collect results for the number of times the highest
##bid variable was updated.

##For each size of bidder groups
for(bidder_size in 1:length(number_of_bidders)) {
    
    ##run 100 trials of the auction process
    for(trial in 1:100) {
        
        ##create random permutation of integers from 1 to bidder group size,
        ##reflecting the ranking of bids from the lowest (1) to the highest
        bidders <- sample.int(number_of_bidders[bidder_size], 
                              number_of_bidders[bidder_size], 
                              replace = FALSE)
    
        ##initialize high bid and number of updates to zero
        high = 0
        updates = 0
    
        ##traverse bids in order, updating highest bid and number of updates
        ##as necessary
        for (index in 1:length(bidders)) {
            if(bidders[index] > high) {
                high <- bidders[index]
                updates <- updates + 1
            }
        }
        
        ##store number of updates from trial at appropriate place 
        ##in results data frame
        results[trial, bidder_size] <- updates
    }
    
}

results <- mutate(results, id = 1:100)


write.table(results, "results.txt", row.names = FALSE, col.names = names(results))
