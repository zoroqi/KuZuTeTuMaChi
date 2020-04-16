package main;import "fmt";func main(){s:="package main;import %q;func main(){s:=%q;fmt.Printf(s,%sfmt%s,s,string(rune(34)),string(rune(34)))}";fmt.Printf(s,"fmt",s,string(rune(34)),string(rune(34)))}

