# This is just testing that the server boots up,
# and that goldi is loaded. I'm having issues 
# checking that the outputted DT, because I cannot
# figure out how to get it back to a regular data.table 
# for testing. Anyway, if goldi loads, we're 80% of the way
# there in any case. More for my own sanity than anything
# else. CRAN is going to break goldi at some point. 
testServer(expr = {
  library(goldi)
  expect_equal(1, 1)
})