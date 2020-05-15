package las

import (
	"strconv"
	"strings"
)

type LookAndSaySequence struct {
	current []int
	start   int
}

func NewLookAndSyaSequence(first int) LookAndSaySequence {
	if first < 0 || first > 9 {
		panic("first num is [0,9]")
	}

	return LookAndSaySequence{current: []int{first}, start: first}
}

func (lass *LookAndSaySequence) Next() (r string) {
	builder := strings.Builder{}
	for _, i := range lass.current {
		builder.WriteString(strconv.Itoa(i))
	}
	r = builder.String()
	nextNum := make([]int, 0, int(float32(len(lass.current))*1.5))
	l := len(lass.current)
	for i := 0; i < l; {
		count, num := look(lass.current, i)
		// say
		nextNum = append(nextNum, count, num)
		i += count
	}
	lass.current = nextNum
	return
}

func look(nums []int, start int) (int, int) {
	l := len(nums)
	first := nums[start]
	count := 1
	for i := start + 1; i < l; i++ {
		if nums[i] != first {
			break
		}
		count++
	}
	return count, first
}
