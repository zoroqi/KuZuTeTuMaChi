package prime

import (
	"fmt"
)

func PrintPrime(max int) {
	firstLevel := make(chan int)
	go sieve(firstLevel)
	firstLevel <- 2
	for i := 3; i < max; i += 2 {
		firstLevel <- i
	}
	close(firstLevel)
}

func sieve(current <-chan int) {
	nextLevel := make(chan int)
	prime, open := <-current
	if !open {
		return
	}
	fmt.Println(prime)
	go sieve(nextLevel)
	for num := range current {
		if num%prime != 0 {
			nextLevel <- num
		}
	}
	close(nextLevel)
}
