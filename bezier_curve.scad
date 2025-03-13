// https://www.raphaelluckom.com/posts/bezier_curves.html
// https://en.wikipedia.org/wiki/Binomial_coefficient
binomial_terms = [
                [1],                // n = 0
               [1, 1],              // n = 1
             [1, 2, 1],             // n = 2
            [1, 3, 3, 1],           // n = 3
          [1, 4, 6, 4, 1],          // n = 4
       [1, 5, 10, 10, 5, 1],        // n = 5
      [1, 6, 15, 20, 15, 6, 1],     // n = 6
    [1, 7, 21, 35, 35, 21, 7, 1],   // n = 7
  [1, 8, 28, 56, 70, 56, 28, 8, 1]  // n = 8
];
function bezier_coordinate(t, weights, term=0, total=0) =
  let (
     n = len(weights) - 1,
     binomial_row = binomial_terms[n],
     a = 1 - t,
     b = t,
     a_pow = n - term,
     b_pow = term
  )
  (term > n ? total : 
    bezier_coordinate(
      t,
      weights,
      term + 1,
      (
        total + (weights[term] * binomial_row[term] 
        * pow(a, a_pow) * pow(b, b_pow))
      )
    )
  );
function bezier_point(t, control_points) = 
  [
    bezier_coordinate(t, [for (point = control_points) point[0]]),
    bezier_coordinate(t, [for (point = control_points) point[1]]),
    bezier_coordinate(t, [for (point = control_points) point[2]]),
  ];

function bezier_curve_points(control_points, num_points) =
  [for (t=[0:num_points]) bezier_point(
    t * (1 / num_points), control_points
  )];

module draw_points(points) {
  for (point = points) {
    translate(point) children(0);
  }
}
module piecewise_join(points) {
  for (n=[1:len(points) - 1]) {
    hull() {
      translate(points[n-1]) children(0);
      translate(points[n]) children(0);
    }
  }
}

module bezier_curve(control_points, number_of_sections) {
  assert(len(control_points)<10,str("You can only have up to 9 points."));
  piecewise_join(
    bezier_curve_points(control_points, number_of_sections)
  ) children(0);
}

control_points = [
      [  7,   47,  0],   // 0
      [-90,  140,  0     ], // 1
      [100,  170,  0    ],  // 2
      [140,  164.5,  0    ],    // 3
      [180,  157,  0    ],    // 4
      [230,  128,  0    ],    // 5
      [231,  100,  0    ],    // 6
      [231,  100,  0    ],    // 6
      [224,   69,  0  ]    // 7
];

draw_points(control_points) sphere(1);
bezier_curve(control_points, 30) sphere(0.2);
