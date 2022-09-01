const count = 9;
const knights = [7, 5, 6, 8, 9, 10, 12, 10, 8];
const position = 2;
const rank = 5;

knights.splice(position - 1, 0, rank);

let max = 0;