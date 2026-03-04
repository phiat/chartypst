// test-area.typ — Area chart tests

#import "../src/lib.typ": *
#import "data.typ": simple-data, multi-data

#set page(margin: 0.5cm)

= Area Charts

#area-chart(simple-data, title: "area-chart")

#stacked-area-chart(multi-data, title: "stacked-area-chart")
