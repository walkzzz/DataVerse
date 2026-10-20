///===
/// extcore/opt_convex_sr1

pub(all) struct Optconvexsr1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_sr1_make_point(x : Double, y : Double) -> Optconvexsr1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_sr1_make_point3(x : Double, y : Double, z : Double) -> Optconvexsr1Point {
  { x, y, z, label: 0 }
}

pub fn Optconvexsr1Point::x(self : Optconvexsr1Point) -> Double { self.x }

pub fn Optconvexsr1Point::y(self : Optconvexsr1Point) -> Double { self.y }

pub fn Optconvexsr1Point::z(self : Optconvexsr1Point) -> Double { self.z }

pub fn Optconvexsr1Point::label(self : Optconvexsr1Point) -> Int { self.label }

pub fn Optconvexsr1Point::dist(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Optconvexsr1Point::add(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Optconvexsr1Point::sub(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Optconvexsr1Point::scale(self : Optconvexsr1Point, s : Double) -> Optconvexsr1Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Optconvexsr1Point::dot(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Optconvexsr1Point::cross(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Optconvexsr1Point::norm(self : Optconvexsr1Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Optconvexsr1Point::normalize(self : Optconvexsr1Point) -> Optconvexsr1Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Optconvexsr1Point::negate(self : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Optconvexsr1Point::mid(self : Optconvexsr1Point, other : Optconvexsr1Point) -> Optconvexsr1Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Optconvexsr1Point::lerp(self : Optconvexsr1Point, other : Optconvexsr1Point, t : Double) -> Optconvexsr1Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Optconvexsr1Point::to_string(self : Optconvexsr1Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Optconvexsr1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_sr1_make_series(vals : Array[Double], name : String) -> Optconvexsr1Series {
  { vals, name, meta: 0 }
}

pub fn Optconvexsr1Series::len(self : Optconvexsr1Series) -> Int { self.vals.length() }

pub fn Optconvexsr1Series::sum(self : Optconvexsr1Series) -> Double { @_common.sum(self.vals) }

pub fn Optconvexsr1Series::mean(self : Optconvexsr1Series) -> Double { @_common.mean(self.vals) }

pub fn Optconvexsr1Series::min(self : Optconvexsr1Series) -> Double { @_common.min(self.vals) }

pub fn Optconvexsr1Series::max(self : Optconvexsr1Series) -> Double { @_common.max(self.vals) }

pub fn Optconvexsr1Series::range(self : Optconvexsr1Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Optconvexsr1Series::variance(self : Optconvexsr1Series) -> Double { @_common.variance(self.vals) }

pub fn Optconvexsr1Series::std(self : Optconvexsr1Series) -> Double { @_common.std(self.vals) }

pub fn Optconvexsr1Series::median(self : Optconvexsr1Series) -> Double { @_common.median(self.vals) }

pub fn Optconvexsr1Series::scale(self : Optconvexsr1Series, f : Double) -> Optconvexsr1Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Optconvexsr1Series::add(self : Optconvexsr1Series, other : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Optconvexsr1Series::sub(self : Optconvexsr1Series, other : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Optconvexsr1Series::normalize(self : Optconvexsr1Series) -> Optconvexsr1Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Optconvexsr1Series::cumsum(self : Optconvexsr1Series) -> Optconvexsr1Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Optconvexsr1Series::to_string(self : Optconvexsr1Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Optconvexsr1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_sr1_make_matrix(rows : Int, cols : Int, val : Double) -> Optconvexsr1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_sr1_matrix_identity(n : Int) -> Optconvexsr1Matrix {
  let m = opt_convex_sr1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Optconvexsr1Matrix::get(self : Optconvexsr1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Optconvexsr1Matrix::transpose(self : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  let result = opt_convex_sr1_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Optconvexsr1Matrix::add(self : Optconvexsr1Matrix, other : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_sr1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Optconvexsr1Matrix::scale(self : Optconvexsr1Matrix, s : Double) -> Optconvexsr1Matrix {
  let result = opt_convex_sr1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Optconvexsr1Matrix::multiply(self : Optconvexsr1Matrix, other : Optconvexsr1Matrix) -> Optconvexsr1Matrix {
  if self.cols != other.rows { return opt_convex_sr1_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_sr1_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Optconvexsr1Matrix::trace(self : Optconvexsr1Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Optconvexsr1Matrix::det(self : Optconvexsr1Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Optconvexsr1Matrix::norm(self : Optconvexsr1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Optconvexsr1Matrix::to_string(self : Optconvexsr1Matrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Optconvexsr1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_sr1_make_vector(comps : Array[Double]) -> Optconvexsr1Vector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_sr1_vector_zero(dim : Int) -> Optconvexsr1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Optconvexsr1Vector::add(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Optconvexsr1Vector::sub(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Optconvexsr1Vector::scale(self : Optconvexsr1Vector, s : Double) -> Optconvexsr1Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Optconvexsr1Vector::dot(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Optconvexsr1Vector::norm(self : Optconvexsr1Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Optconvexsr1Vector::normalize(self : Optconvexsr1Vector) -> Optconvexsr1Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Optconvexsr1Vector::dist(self : Optconvexsr1Vector, other : Optconvexsr1Vector) -> Double {
  self.sub(other).norm()
}

pub fn Optconvexsr1Vector::to_string(self : Optconvexsr1Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_sr1_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_sr1_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_sr1_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_sr1_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_sr1_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_sr1_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_sr1_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_sr1_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_sr1_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_sr1_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_sr1_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_sr1_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_sr1_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_sr1_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_sr1_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_sr1_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_sr1_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_sr1_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_sr1_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_sr1_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_sr1_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_sr1_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_sr1_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_sr1_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_sr1_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_sr1_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_sr1_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_sr1_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_sr1_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Optconvexsr1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_frame_make(size : Int) -> Optconvexsr1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_frame_len(s : Optconvexsr1Frame) -> Int { s.size }

pub fn opt_convex_sr1_frame_get(s : Optconvexsr1Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_frame_set(s : Optconvexsr1Frame, i : Int, v : Double) -> Optconvexsr1Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_frame_sum(s : Optconvexsr1Frame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_frame_mean(s : Optconvexsr1Frame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_frame_scale(s : Optconvexsr1Frame, f : Double) -> Optconvexsr1Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_frame_add(a : Optconvexsr1Frame, b : Optconvexsr1Frame) -> Optconvexsr1Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_frame_copy(s : Optconvexsr1Frame) -> Optconvexsr1Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_frame_fill(s : Optconvexsr1Frame, v : Double) -> Optconvexsr1Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_frame_min(s : Optconvexsr1Frame) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_frame_max(s : Optconvexsr1Frame) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_frame_to_string(s : Optconvexsr1Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_table_make(size : Int) -> Optconvexsr1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_table_len(s : Optconvexsr1Table) -> Int { s.size }

pub fn opt_convex_sr1_table_get(s : Optconvexsr1Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_table_set(s : Optconvexsr1Table, i : Int, v : Double) -> Optconvexsr1Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_table_sum(s : Optconvexsr1Table) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_table_mean(s : Optconvexsr1Table) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_table_scale(s : Optconvexsr1Table, f : Double) -> Optconvexsr1Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_table_add(a : Optconvexsr1Table, b : Optconvexsr1Table) -> Optconvexsr1Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_table_copy(s : Optconvexsr1Table) -> Optconvexsr1Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_table_fill(s : Optconvexsr1Table, v : Double) -> Optconvexsr1Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_table_min(s : Optconvexsr1Table) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_table_max(s : Optconvexsr1Table) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_table_to_string(s : Optconvexsr1Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_graphn_make(size : Int) -> Optconvexsr1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_graphn_len(s : Optconvexsr1GraphN) -> Int { s.size }

pub fn opt_convex_sr1_graphn_get(s : Optconvexsr1GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_graphn_set(s : Optconvexsr1GraphN, i : Int, v : Double) -> Optconvexsr1GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_graphn_sum(s : Optconvexsr1GraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_graphn_mean(s : Optconvexsr1GraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_graphn_scale(s : Optconvexsr1GraphN, f : Double) -> Optconvexsr1GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_graphn_add(a : Optconvexsr1GraphN, b : Optconvexsr1GraphN) -> Optconvexsr1GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_graphn_copy(s : Optconvexsr1GraphN) -> Optconvexsr1GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_graphn_fill(s : Optconvexsr1GraphN, v : Double) -> Optconvexsr1GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_graphn_min(s : Optconvexsr1GraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_graphn_max(s : Optconvexsr1GraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_graphn_to_string(s : Optconvexsr1GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_node_make(size : Int) -> Optconvexsr1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_node_len(s : Optconvexsr1Node) -> Int { s.size }

pub fn opt_convex_sr1_node_get(s : Optconvexsr1Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_node_set(s : Optconvexsr1Node, i : Int, v : Double) -> Optconvexsr1Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_node_sum(s : Optconvexsr1Node) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_node_mean(s : Optconvexsr1Node) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_node_scale(s : Optconvexsr1Node, f : Double) -> Optconvexsr1Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_node_add(a : Optconvexsr1Node, b : Optconvexsr1Node) -> Optconvexsr1Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_node_copy(s : Optconvexsr1Node) -> Optconvexsr1Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_node_fill(s : Optconvexsr1Node, v : Double) -> Optconvexsr1Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_node_min(s : Optconvexsr1Node) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_node_max(s : Optconvexsr1Node) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_node_to_string(s : Optconvexsr1Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_edge_make(size : Int) -> Optconvexsr1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_edge_len(s : Optconvexsr1Edge) -> Int { s.size }

pub fn opt_convex_sr1_edge_get(s : Optconvexsr1Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_edge_set(s : Optconvexsr1Edge, i : Int, v : Double) -> Optconvexsr1Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_edge_sum(s : Optconvexsr1Edge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_edge_mean(s : Optconvexsr1Edge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_edge_scale(s : Optconvexsr1Edge, f : Double) -> Optconvexsr1Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_edge_add(a : Optconvexsr1Edge, b : Optconvexsr1Edge) -> Optconvexsr1Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_edge_copy(s : Optconvexsr1Edge) -> Optconvexsr1Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_edge_fill(s : Optconvexsr1Edge, v : Double) -> Optconvexsr1Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_edge_min(s : Optconvexsr1Edge) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_edge_max(s : Optconvexsr1Edge) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_edge_to_string(s : Optconvexsr1Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_path_make(size : Int) -> Optconvexsr1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_path_len(s : Optconvexsr1Path) -> Int { s.size }

pub fn opt_convex_sr1_path_get(s : Optconvexsr1Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_path_set(s : Optconvexsr1Path, i : Int, v : Double) -> Optconvexsr1Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_path_sum(s : Optconvexsr1Path) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_path_mean(s : Optconvexsr1Path) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_path_scale(s : Optconvexsr1Path, f : Double) -> Optconvexsr1Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_path_add(a : Optconvexsr1Path, b : Optconvexsr1Path) -> Optconvexsr1Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_path_copy(s : Optconvexsr1Path) -> Optconvexsr1Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_path_fill(s : Optconvexsr1Path, v : Double) -> Optconvexsr1Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_path_min(s : Optconvexsr1Path) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_path_max(s : Optconvexsr1Path) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_path_to_string(s : Optconvexsr1Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_cluster_make(size : Int) -> Optconvexsr1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_cluster_len(s : Optconvexsr1Cluster) -> Int { s.size }

pub fn opt_convex_sr1_cluster_get(s : Optconvexsr1Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_cluster_set(s : Optconvexsr1Cluster, i : Int, v : Double) -> Optconvexsr1Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cluster_sum(s : Optconvexsr1Cluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_cluster_mean(s : Optconvexsr1Cluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_cluster_scale(s : Optconvexsr1Cluster, f : Double) -> Optconvexsr1Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cluster_add(a : Optconvexsr1Cluster, b : Optconvexsr1Cluster) -> Optconvexsr1Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_cluster_copy(s : Optconvexsr1Cluster) -> Optconvexsr1Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cluster_fill(s : Optconvexsr1Cluster, v : Double) -> Optconvexsr1Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cluster_min(s : Optconvexsr1Cluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_cluster_max(s : Optconvexsr1Cluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_cluster_to_string(s : Optconvexsr1Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_model_make(size : Int) -> Optconvexsr1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_model_len(s : Optconvexsr1Model) -> Int { s.size }

pub fn opt_convex_sr1_model_get(s : Optconvexsr1Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_model_set(s : Optconvexsr1Model, i : Int, v : Double) -> Optconvexsr1Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_model_sum(s : Optconvexsr1Model) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_model_mean(s : Optconvexsr1Model) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_model_scale(s : Optconvexsr1Model, f : Double) -> Optconvexsr1Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_model_add(a : Optconvexsr1Model, b : Optconvexsr1Model) -> Optconvexsr1Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_model_copy(s : Optconvexsr1Model) -> Optconvexsr1Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_model_fill(s : Optconvexsr1Model, v : Double) -> Optconvexsr1Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_model_min(s : Optconvexsr1Model) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_model_max(s : Optconvexsr1Model) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_model_to_string(s : Optconvexsr1Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_layer_make(size : Int) -> Optconvexsr1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_layer_len(s : Optconvexsr1Layer) -> Int { s.size }

pub fn opt_convex_sr1_layer_get(s : Optconvexsr1Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_layer_set(s : Optconvexsr1Layer, i : Int, v : Double) -> Optconvexsr1Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_layer_sum(s : Optconvexsr1Layer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_layer_mean(s : Optconvexsr1Layer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_layer_scale(s : Optconvexsr1Layer, f : Double) -> Optconvexsr1Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_layer_add(a : Optconvexsr1Layer, b : Optconvexsr1Layer) -> Optconvexsr1Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_layer_copy(s : Optconvexsr1Layer) -> Optconvexsr1Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_layer_fill(s : Optconvexsr1Layer, v : Double) -> Optconvexsr1Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_layer_min(s : Optconvexsr1Layer) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_layer_max(s : Optconvexsr1Layer) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_layer_to_string(s : Optconvexsr1Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_buffer_make(size : Int) -> Optconvexsr1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_buffer_len(s : Optconvexsr1Buffer) -> Int { s.size }

pub fn opt_convex_sr1_buffer_get(s : Optconvexsr1Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_buffer_set(s : Optconvexsr1Buffer, i : Int, v : Double) -> Optconvexsr1Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_buffer_sum(s : Optconvexsr1Buffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_buffer_mean(s : Optconvexsr1Buffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_buffer_scale(s : Optconvexsr1Buffer, f : Double) -> Optconvexsr1Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_buffer_add(a : Optconvexsr1Buffer, b : Optconvexsr1Buffer) -> Optconvexsr1Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_buffer_copy(s : Optconvexsr1Buffer) -> Optconvexsr1Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_buffer_fill(s : Optconvexsr1Buffer, v : Double) -> Optconvexsr1Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_buffer_min(s : Optconvexsr1Buffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_buffer_max(s : Optconvexsr1Buffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_buffer_to_string(s : Optconvexsr1Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_cursor_make(size : Int) -> Optconvexsr1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_cursor_len(s : Optconvexsr1Cursor) -> Int { s.size }

pub fn opt_convex_sr1_cursor_get(s : Optconvexsr1Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_cursor_set(s : Optconvexsr1Cursor, i : Int, v : Double) -> Optconvexsr1Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cursor_sum(s : Optconvexsr1Cursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_cursor_mean(s : Optconvexsr1Cursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_cursor_scale(s : Optconvexsr1Cursor, f : Double) -> Optconvexsr1Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cursor_add(a : Optconvexsr1Cursor, b : Optconvexsr1Cursor) -> Optconvexsr1Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_cursor_copy(s : Optconvexsr1Cursor) -> Optconvexsr1Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cursor_fill(s : Optconvexsr1Cursor, v : Double) -> Optconvexsr1Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_cursor_min(s : Optconvexsr1Cursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_cursor_max(s : Optconvexsr1Cursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_cursor_to_string(s : Optconvexsr1Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_view_make(size : Int) -> Optconvexsr1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_view_len(s : Optconvexsr1View) -> Int { s.size }

pub fn opt_convex_sr1_view_get(s : Optconvexsr1View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_view_set(s : Optconvexsr1View, i : Int, v : Double) -> Optconvexsr1View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_view_sum(s : Optconvexsr1View) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_view_mean(s : Optconvexsr1View) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_view_scale(s : Optconvexsr1View, f : Double) -> Optconvexsr1View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_view_add(a : Optconvexsr1View, b : Optconvexsr1View) -> Optconvexsr1View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_view_copy(s : Optconvexsr1View) -> Optconvexsr1View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_view_fill(s : Optconvexsr1View, v : Double) -> Optconvexsr1View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_view_min(s : Optconvexsr1View) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_view_max(s : Optconvexsr1View) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_view_to_string(s : Optconvexsr1View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_range_make(size : Int) -> Optconvexsr1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_range_len(s : Optconvexsr1Range) -> Int { s.size }

pub fn opt_convex_sr1_range_get(s : Optconvexsr1Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_range_set(s : Optconvexsr1Range, i : Int, v : Double) -> Optconvexsr1Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_range_sum(s : Optconvexsr1Range) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_range_mean(s : Optconvexsr1Range) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_range_scale(s : Optconvexsr1Range, f : Double) -> Optconvexsr1Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_range_add(a : Optconvexsr1Range, b : Optconvexsr1Range) -> Optconvexsr1Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_range_copy(s : Optconvexsr1Range) -> Optconvexsr1Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_range_fill(s : Optconvexsr1Range, v : Double) -> Optconvexsr1Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_range_min(s : Optconvexsr1Range) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_range_max(s : Optconvexsr1Range) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_range_to_string(s : Optconvexsr1Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Optconvexsr1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_sr1_slice_make(size : Int) -> Optconvexsr1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_sr1_slice_len(s : Optconvexsr1Slice) -> Int { s.size }

pub fn opt_convex_sr1_slice_get(s : Optconvexsr1Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_sr1_slice_set(s : Optconvexsr1Slice, i : Int, v : Double) -> Optconvexsr1Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_slice_sum(s : Optconvexsr1Slice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_sr1_slice_mean(s : Optconvexsr1Slice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_sr1_slice_scale(s : Optconvexsr1Slice, f : Double) -> Optconvexsr1Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_slice_add(a : Optconvexsr1Slice, b : Optconvexsr1Slice) -> Optconvexsr1Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_sr1_slice_copy(s : Optconvexsr1Slice) -> Optconvexsr1Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_slice_fill(s : Optconvexsr1Slice, v : Double) -> Optconvexsr1Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_sr1_slice_min(s : Optconvexsr1Slice) -> Double { @_common.min(s.data) }

pub fn opt_convex_sr1_slice_max(s : Optconvexsr1Slice) -> Double { @_common.max(s.data) }

pub fn opt_convex_sr1_slice_to_string(s : Optconvexsr1Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

