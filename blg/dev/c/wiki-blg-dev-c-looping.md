#Looping

     for (prod = products, row = 0; prod; prod = prod->next, ++row) {

This part here is interesting (because I still need to understand what
this for loop does) and odd at the same time. Breaking down:

    (prod = products, row = 0; prod; prod = prod->next, ++row)
     \                      /  \  /  \                      /
      \   initialization   /    \/    \    afterthought    /
       \                  /      |     \                  /
        \                /       |      \                /
         \              /        |       \              /
          \            /         |        \            /
           \          /          |         \          /
            \        /           |          \        /
             \      /            |           \      /
              \    /             |            \    /
               \  /              |             \  /
                \/               |              \/
                             condition

This goes against what I have been studying so far:

  1) The initialization and afterthoughy have two operations

  2) The condition is not a computation (e.g.: less than X)

I'm ok with having two operations in the initialization and
afterthought, I just never heard of it until now. But the condition
looks weird. What I think it means is "iterate throught the next item".
