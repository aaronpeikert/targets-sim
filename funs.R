simulate <- function(n){
  data.frame(y = rnorm(n), x = rep(c("a", "b"), each = n/2))
}

get_p <- function(d)t.test(y ~ x, data = d)$p.value

continued_testing_ <- function(n, k){
  d <- simulate(n)
  p <- get_p(d)
  while (length(p) < k && p[length(p)] > 0.05) {
    d <- rbind(d, simulate(n))
    p <- c(p, get_p(d))
  }
  list(p)
}

continued_testing <- function(n, k, seed = .Random.seed){
  withr::with_seed(seed, continued_testing_(n, k))
}

gen_seed <- function(n)round(runif(n)*1e6)

if(FALSE){
  continued_testing(10, 10, 1123)
}
