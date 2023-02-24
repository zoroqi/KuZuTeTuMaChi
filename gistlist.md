---
id: 20230224160906_2377b63492584192
date: "2023-02-24"
aliases:
- gist 内容汇总
---

```dataviewjs
let pagelist = dv.pages('"KuZuTeTuMaChi"').
    where(k => k.category == "gist").sort(k => k.gist.language[0])

for (let group of pagelist.groupBy(p => p.gist.language[0])) {
    dv.header(4, group.key);
    dv.table(["link", "title", "language", "tags"],
        group.rows.map(k => [k.file.link, k.aliases[0], k.gist.language, k.gist.tags]))
}
```
