///===
/// extcore/signal_filter_chebyshev1

pub(all) struct Signalfilterchebyshev1Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_chebyshev1_make_point(x : Double, y : Double) -> Signalfilterchebyshev1Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_chebyshev1_make_point3(x : Double, y : Double, z : Double) -> Signalfilterchebyshev1Point {
  { x, y, z, label: 0 }
}

pub fn Signalfilterchebyshev1Point::x(self : Signalfilterchebyshev1Point) -> Double { self.x }

pub fn Signalfilterchebyshev1Point::y(self : Signalfilterchebyshev1Point) -> Double { self.y }

pub fn Signalfilterchebyshev1Point::z(self : Signalfilterchebyshev1Point) -> Double { self.z }

pub fn Signalfilterchebyshev1Point::label(self : Signalfilterchebyshev1Point) -> Int { self.label }

pub fn Signalfilterchebyshev1Point::dist(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Signalfilterchebyshev1Point::add(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Signalfilterchebyshev1Point::sub(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Signalfilterchebyshev1Point::scale(self : Signalfilterchebyshev1Point, s : Double) -> Signalfilterchebyshev1Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Signalfilterchebyshev1Point::dot(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Signalfilterchebyshev1Point::cross(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Signalfilterchebyshev1Point::norm(self : Signalfilterchebyshev1Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Signalfilterchebyshev1Point::normalize(self : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Signalfilterchebyshev1Point::negate(self : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Signalfilterchebyshev1Point::mid(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point) -> Signalfilterchebyshev1Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Signalfilterchebyshev1Point::lerp(self : Signalfilterchebyshev1Point, other : Signalfilterchebyshev1Point, t : Double) -> Signalfilterchebyshev1Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Signalfilterchebyshev1Point::to_string(self : Signalfilterchebyshev1Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_chebyshev1_make_series(vals : Array[Double], name : String) -> Signalfilterchebyshev1Series {
  { vals, name, meta: 0 }
}

pub fn Signalfilterchebyshev1Series::len(self : Signalfilterchebyshev1Series) -> Int { self.vals.length() }

pub fn Signalfilterchebyshev1Series::sum(self : Signalfilterchebyshev1Series) -> Double { @_common.sum(self.vals) }

pub fn Signalfilterchebyshev1Series::mean(self : Signalfilterchebyshev1Series) -> Double { @_common.mean(self.vals) }

pub fn Signalfilterchebyshev1Series::min(self : Signalfilterchebyshev1Series) -> Double { @_common.min(self.vals) }

pub fn Signalfilterchebyshev1Series::max(self : Signalfilterchebyshev1Series) -> Double { @_common.max(self.vals) }

pub fn Signalfilterchebyshev1Series::range(self : Signalfilterchebyshev1Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Signalfilterchebyshev1Series::variance(self : Signalfilterchebyshev1Series) -> Double { @_common.variance(self.vals) }

pub fn Signalfilterchebyshev1Series::std(self : Signalfilterchebyshev1Series) -> Double { @_common.std(self.vals) }

pub fn Signalfilterchebyshev1Series::median(self : Signalfilterchebyshev1Series) -> Double { @_common.median(self.vals) }

pub fn Signalfilterchebyshev1Series::scale(self : Signalfilterchebyshev1Series, f : Double) -> Signalfilterchebyshev1Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::add(self : Signalfilterchebyshev1Series, other : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::sub(self : Signalfilterchebyshev1Series, other : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::normalize(self : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Signalfilterchebyshev1Series::cumsum(self : Signalfilterchebyshev1Series) -> Signalfilterchebyshev1Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Signalfilterchebyshev1Series::to_string(self : Signalfilterchebyshev1Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Signalfilterchebyshev1Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_chebyshev1_make_matrix(rows : Int, cols : Int, val : Double) -> Signalfilterchebyshev1Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_chebyshev1_matrix_identity(n : Int) -> Signalfilterchebyshev1Matrix {
  let m = signal_filter_chebyshev1_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Signalfilterchebyshev1Matrix::get(self : Signalfilterchebyshev1Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Signalfilterchebyshev1Matrix::transpose(self : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  let result = signal_filter_chebyshev1_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Signalfilterchebyshev1Matrix::add(self : Signalfilterchebyshev1Matrix, other : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_chebyshev1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Signalfilterchebyshev1Matrix::scale(self : Signalfilterchebyshev1Matrix, s : Double) -> Signalfilterchebyshev1Matrix {
  let result = signal_filter_chebyshev1_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Signalfilterchebyshev1Matrix::multiply(self : Signalfilterchebyshev1Matrix, other : Signalfilterchebyshev1Matrix) -> Signalfilterchebyshev1Matrix {
  if self.cols != other.rows { return signal_filter_chebyshev1_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_chebyshev1_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Signalfilterchebyshev1Matrix::trace(self : Signalfilterchebyshev1Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Signalfilterchebyshev1Matrix::det(self : Signalfilterchebyshev1Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Signalfilterchebyshev1Matrix::norm(self : Signalfilterchebyshev1Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Signalfilterchebyshev1Matrix::to_string(self : Signalfilterchebyshev1Matrix) -> String {
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

pub(all) struct Signalfilterchebyshev1Vector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_chebyshev1_make_vector(comps : Array[Double]) -> Signalfilterchebyshev1Vector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_chebyshev1_vector_zero(dim : Int) -> Signalfilterchebyshev1Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Signalfilterchebyshev1Vector::add(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Signalfilterchebyshev1Vector::sub(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Signalfilterchebyshev1Vector::scale(self : Signalfilterchebyshev1Vector, s : Double) -> Signalfilterchebyshev1Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Signalfilterchebyshev1Vector::dot(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Signalfilterchebyshev1Vector::norm(self : Signalfilterchebyshev1Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Signalfilterchebyshev1Vector::normalize(self : Signalfilterchebyshev1Vector) -> Signalfilterchebyshev1Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Signalfilterchebyshev1Vector::dist(self : Signalfilterchebyshev1Vector, other : Signalfilterchebyshev1Vector) -> Double {
  self.sub(other).norm()
}

pub fn Signalfilterchebyshev1Vector::to_string(self : Signalfilterchebyshev1Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_chebyshev1_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_chebyshev1_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_chebyshev1_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_chebyshev1_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_chebyshev1_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_chebyshev1_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_chebyshev1_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_chebyshev1_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_chebyshev1_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_chebyshev1_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_chebyshev1_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_chebyshev1_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_chebyshev1_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_chebyshev1_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_chebyshev1_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_chebyshev1_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_chebyshev1_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_chebyshev1_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_chebyshev1_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_chebyshev1_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_chebyshev1_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_chebyshev1_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_chebyshev1_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_chebyshev1_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_chebyshev1_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_chebyshev1_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_chebyshev1_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_chebyshev1_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_chebyshev1_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Signalfilterchebyshev1Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_frame_make(size : Int) -> Signalfilterchebyshev1Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_frame_len(s : Signalfilterchebyshev1Frame) -> Int { s.size }

pub fn signal_filter_chebyshev1_frame_get(s : Signalfilterchebyshev1Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_frame_set(s : Signalfilterchebyshev1Frame, i : Int, v : Double) -> Signalfilterchebyshev1Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_frame_sum(s : Signalfilterchebyshev1Frame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_frame_mean(s : Signalfilterchebyshev1Frame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_frame_scale(s : Signalfilterchebyshev1Frame, f : Double) -> Signalfilterchebyshev1Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_frame_add(a : Signalfilterchebyshev1Frame, b : Signalfilterchebyshev1Frame) -> Signalfilterchebyshev1Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_frame_copy(s : Signalfilterchebyshev1Frame) -> Signalfilterchebyshev1Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_frame_fill(s : Signalfilterchebyshev1Frame, v : Double) -> Signalfilterchebyshev1Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_frame_min(s : Signalfilterchebyshev1Frame) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_frame_max(s : Signalfilterchebyshev1Frame) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_frame_to_string(s : Signalfilterchebyshev1Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_table_make(size : Int) -> Signalfilterchebyshev1Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_table_len(s : Signalfilterchebyshev1Table) -> Int { s.size }

pub fn signal_filter_chebyshev1_table_get(s : Signalfilterchebyshev1Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_table_set(s : Signalfilterchebyshev1Table, i : Int, v : Double) -> Signalfilterchebyshev1Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_table_sum(s : Signalfilterchebyshev1Table) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_table_mean(s : Signalfilterchebyshev1Table) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_table_scale(s : Signalfilterchebyshev1Table, f : Double) -> Signalfilterchebyshev1Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_table_add(a : Signalfilterchebyshev1Table, b : Signalfilterchebyshev1Table) -> Signalfilterchebyshev1Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_table_copy(s : Signalfilterchebyshev1Table) -> Signalfilterchebyshev1Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_table_fill(s : Signalfilterchebyshev1Table, v : Double) -> Signalfilterchebyshev1Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_table_min(s : Signalfilterchebyshev1Table) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_table_max(s : Signalfilterchebyshev1Table) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_table_to_string(s : Signalfilterchebyshev1Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_graphn_make(size : Int) -> Signalfilterchebyshev1GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_graphn_len(s : Signalfilterchebyshev1GraphN) -> Int { s.size }

pub fn signal_filter_chebyshev1_graphn_get(s : Signalfilterchebyshev1GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_graphn_set(s : Signalfilterchebyshev1GraphN, i : Int, v : Double) -> Signalfilterchebyshev1GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_graphn_sum(s : Signalfilterchebyshev1GraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_graphn_mean(s : Signalfilterchebyshev1GraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_graphn_scale(s : Signalfilterchebyshev1GraphN, f : Double) -> Signalfilterchebyshev1GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_graphn_add(a : Signalfilterchebyshev1GraphN, b : Signalfilterchebyshev1GraphN) -> Signalfilterchebyshev1GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_graphn_copy(s : Signalfilterchebyshev1GraphN) -> Signalfilterchebyshev1GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_graphn_fill(s : Signalfilterchebyshev1GraphN, v : Double) -> Signalfilterchebyshev1GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_graphn_min(s : Signalfilterchebyshev1GraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_graphn_max(s : Signalfilterchebyshev1GraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_graphn_to_string(s : Signalfilterchebyshev1GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_node_make(size : Int) -> Signalfilterchebyshev1Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_node_len(s : Signalfilterchebyshev1Node) -> Int { s.size }

pub fn signal_filter_chebyshev1_node_get(s : Signalfilterchebyshev1Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_node_set(s : Signalfilterchebyshev1Node, i : Int, v : Double) -> Signalfilterchebyshev1Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_node_sum(s : Signalfilterchebyshev1Node) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_node_mean(s : Signalfilterchebyshev1Node) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_node_scale(s : Signalfilterchebyshev1Node, f : Double) -> Signalfilterchebyshev1Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_node_add(a : Signalfilterchebyshev1Node, b : Signalfilterchebyshev1Node) -> Signalfilterchebyshev1Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_node_copy(s : Signalfilterchebyshev1Node) -> Signalfilterchebyshev1Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_node_fill(s : Signalfilterchebyshev1Node, v : Double) -> Signalfilterchebyshev1Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_node_min(s : Signalfilterchebyshev1Node) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_node_max(s : Signalfilterchebyshev1Node) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_node_to_string(s : Signalfilterchebyshev1Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_edge_make(size : Int) -> Signalfilterchebyshev1Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_edge_len(s : Signalfilterchebyshev1Edge) -> Int { s.size }

pub fn signal_filter_chebyshev1_edge_get(s : Signalfilterchebyshev1Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_edge_set(s : Signalfilterchebyshev1Edge, i : Int, v : Double) -> Signalfilterchebyshev1Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_edge_sum(s : Signalfilterchebyshev1Edge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_edge_mean(s : Signalfilterchebyshev1Edge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_edge_scale(s : Signalfilterchebyshev1Edge, f : Double) -> Signalfilterchebyshev1Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_edge_add(a : Signalfilterchebyshev1Edge, b : Signalfilterchebyshev1Edge) -> Signalfilterchebyshev1Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_edge_copy(s : Signalfilterchebyshev1Edge) -> Signalfilterchebyshev1Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_edge_fill(s : Signalfilterchebyshev1Edge, v : Double) -> Signalfilterchebyshev1Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_edge_min(s : Signalfilterchebyshev1Edge) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_edge_max(s : Signalfilterchebyshev1Edge) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_edge_to_string(s : Signalfilterchebyshev1Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_path_make(size : Int) -> Signalfilterchebyshev1Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_path_len(s : Signalfilterchebyshev1Path) -> Int { s.size }

pub fn signal_filter_chebyshev1_path_get(s : Signalfilterchebyshev1Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_path_set(s : Signalfilterchebyshev1Path, i : Int, v : Double) -> Signalfilterchebyshev1Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_path_sum(s : Signalfilterchebyshev1Path) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_path_mean(s : Signalfilterchebyshev1Path) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_path_scale(s : Signalfilterchebyshev1Path, f : Double) -> Signalfilterchebyshev1Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_path_add(a : Signalfilterchebyshev1Path, b : Signalfilterchebyshev1Path) -> Signalfilterchebyshev1Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_path_copy(s : Signalfilterchebyshev1Path) -> Signalfilterchebyshev1Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_path_fill(s : Signalfilterchebyshev1Path, v : Double) -> Signalfilterchebyshev1Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_path_min(s : Signalfilterchebyshev1Path) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_path_max(s : Signalfilterchebyshev1Path) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_path_to_string(s : Signalfilterchebyshev1Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_cluster_make(size : Int) -> Signalfilterchebyshev1Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_cluster_len(s : Signalfilterchebyshev1Cluster) -> Int { s.size }

pub fn signal_filter_chebyshev1_cluster_get(s : Signalfilterchebyshev1Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_cluster_set(s : Signalfilterchebyshev1Cluster, i : Int, v : Double) -> Signalfilterchebyshev1Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cluster_sum(s : Signalfilterchebyshev1Cluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_cluster_mean(s : Signalfilterchebyshev1Cluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_cluster_scale(s : Signalfilterchebyshev1Cluster, f : Double) -> Signalfilterchebyshev1Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cluster_add(a : Signalfilterchebyshev1Cluster, b : Signalfilterchebyshev1Cluster) -> Signalfilterchebyshev1Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_cluster_copy(s : Signalfilterchebyshev1Cluster) -> Signalfilterchebyshev1Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cluster_fill(s : Signalfilterchebyshev1Cluster, v : Double) -> Signalfilterchebyshev1Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cluster_min(s : Signalfilterchebyshev1Cluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_cluster_max(s : Signalfilterchebyshev1Cluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_cluster_to_string(s : Signalfilterchebyshev1Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_model_make(size : Int) -> Signalfilterchebyshev1Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_model_len(s : Signalfilterchebyshev1Model) -> Int { s.size }

pub fn signal_filter_chebyshev1_model_get(s : Signalfilterchebyshev1Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_model_set(s : Signalfilterchebyshev1Model, i : Int, v : Double) -> Signalfilterchebyshev1Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_model_sum(s : Signalfilterchebyshev1Model) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_model_mean(s : Signalfilterchebyshev1Model) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_model_scale(s : Signalfilterchebyshev1Model, f : Double) -> Signalfilterchebyshev1Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_model_add(a : Signalfilterchebyshev1Model, b : Signalfilterchebyshev1Model) -> Signalfilterchebyshev1Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_model_copy(s : Signalfilterchebyshev1Model) -> Signalfilterchebyshev1Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_model_fill(s : Signalfilterchebyshev1Model, v : Double) -> Signalfilterchebyshev1Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_model_min(s : Signalfilterchebyshev1Model) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_model_max(s : Signalfilterchebyshev1Model) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_model_to_string(s : Signalfilterchebyshev1Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_layer_make(size : Int) -> Signalfilterchebyshev1Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_layer_len(s : Signalfilterchebyshev1Layer) -> Int { s.size }

pub fn signal_filter_chebyshev1_layer_get(s : Signalfilterchebyshev1Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_layer_set(s : Signalfilterchebyshev1Layer, i : Int, v : Double) -> Signalfilterchebyshev1Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_layer_sum(s : Signalfilterchebyshev1Layer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_layer_mean(s : Signalfilterchebyshev1Layer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_layer_scale(s : Signalfilterchebyshev1Layer, f : Double) -> Signalfilterchebyshev1Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_layer_add(a : Signalfilterchebyshev1Layer, b : Signalfilterchebyshev1Layer) -> Signalfilterchebyshev1Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_layer_copy(s : Signalfilterchebyshev1Layer) -> Signalfilterchebyshev1Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_layer_fill(s : Signalfilterchebyshev1Layer, v : Double) -> Signalfilterchebyshev1Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_layer_min(s : Signalfilterchebyshev1Layer) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_layer_max(s : Signalfilterchebyshev1Layer) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_layer_to_string(s : Signalfilterchebyshev1Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_buffer_make(size : Int) -> Signalfilterchebyshev1Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_buffer_len(s : Signalfilterchebyshev1Buffer) -> Int { s.size }

pub fn signal_filter_chebyshev1_buffer_get(s : Signalfilterchebyshev1Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_buffer_set(s : Signalfilterchebyshev1Buffer, i : Int, v : Double) -> Signalfilterchebyshev1Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_buffer_sum(s : Signalfilterchebyshev1Buffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_buffer_mean(s : Signalfilterchebyshev1Buffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_buffer_scale(s : Signalfilterchebyshev1Buffer, f : Double) -> Signalfilterchebyshev1Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_buffer_add(a : Signalfilterchebyshev1Buffer, b : Signalfilterchebyshev1Buffer) -> Signalfilterchebyshev1Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_buffer_copy(s : Signalfilterchebyshev1Buffer) -> Signalfilterchebyshev1Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_buffer_fill(s : Signalfilterchebyshev1Buffer, v : Double) -> Signalfilterchebyshev1Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_buffer_min(s : Signalfilterchebyshev1Buffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_buffer_max(s : Signalfilterchebyshev1Buffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_buffer_to_string(s : Signalfilterchebyshev1Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_cursor_make(size : Int) -> Signalfilterchebyshev1Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_cursor_len(s : Signalfilterchebyshev1Cursor) -> Int { s.size }

pub fn signal_filter_chebyshev1_cursor_get(s : Signalfilterchebyshev1Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_cursor_set(s : Signalfilterchebyshev1Cursor, i : Int, v : Double) -> Signalfilterchebyshev1Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cursor_sum(s : Signalfilterchebyshev1Cursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_cursor_mean(s : Signalfilterchebyshev1Cursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_cursor_scale(s : Signalfilterchebyshev1Cursor, f : Double) -> Signalfilterchebyshev1Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cursor_add(a : Signalfilterchebyshev1Cursor, b : Signalfilterchebyshev1Cursor) -> Signalfilterchebyshev1Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_cursor_copy(s : Signalfilterchebyshev1Cursor) -> Signalfilterchebyshev1Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cursor_fill(s : Signalfilterchebyshev1Cursor, v : Double) -> Signalfilterchebyshev1Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_cursor_min(s : Signalfilterchebyshev1Cursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_cursor_max(s : Signalfilterchebyshev1Cursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_cursor_to_string(s : Signalfilterchebyshev1Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_view_make(size : Int) -> Signalfilterchebyshev1View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_view_len(s : Signalfilterchebyshev1View) -> Int { s.size }

pub fn signal_filter_chebyshev1_view_get(s : Signalfilterchebyshev1View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_view_set(s : Signalfilterchebyshev1View, i : Int, v : Double) -> Signalfilterchebyshev1View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_view_sum(s : Signalfilterchebyshev1View) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_view_mean(s : Signalfilterchebyshev1View) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_view_scale(s : Signalfilterchebyshev1View, f : Double) -> Signalfilterchebyshev1View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_view_add(a : Signalfilterchebyshev1View, b : Signalfilterchebyshev1View) -> Signalfilterchebyshev1View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_view_copy(s : Signalfilterchebyshev1View) -> Signalfilterchebyshev1View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_view_fill(s : Signalfilterchebyshev1View, v : Double) -> Signalfilterchebyshev1View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_view_min(s : Signalfilterchebyshev1View) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_view_max(s : Signalfilterchebyshev1View) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_view_to_string(s : Signalfilterchebyshev1View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_range_make(size : Int) -> Signalfilterchebyshev1Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_range_len(s : Signalfilterchebyshev1Range) -> Int { s.size }

pub fn signal_filter_chebyshev1_range_get(s : Signalfilterchebyshev1Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_range_set(s : Signalfilterchebyshev1Range, i : Int, v : Double) -> Signalfilterchebyshev1Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_range_sum(s : Signalfilterchebyshev1Range) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_range_mean(s : Signalfilterchebyshev1Range) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_range_scale(s : Signalfilterchebyshev1Range, f : Double) -> Signalfilterchebyshev1Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_range_add(a : Signalfilterchebyshev1Range, b : Signalfilterchebyshev1Range) -> Signalfilterchebyshev1Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_range_copy(s : Signalfilterchebyshev1Range) -> Signalfilterchebyshev1Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_range_fill(s : Signalfilterchebyshev1Range, v : Double) -> Signalfilterchebyshev1Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_range_min(s : Signalfilterchebyshev1Range) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_range_max(s : Signalfilterchebyshev1Range) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_range_to_string(s : Signalfilterchebyshev1Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev1Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev1_slice_make(size : Int) -> Signalfilterchebyshev1Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev1_slice_len(s : Signalfilterchebyshev1Slice) -> Int { s.size }

pub fn signal_filter_chebyshev1_slice_get(s : Signalfilterchebyshev1Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev1_slice_set(s : Signalfilterchebyshev1Slice, i : Int, v : Double) -> Signalfilterchebyshev1Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_slice_sum(s : Signalfilterchebyshev1Slice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev1_slice_mean(s : Signalfilterchebyshev1Slice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev1_slice_scale(s : Signalfilterchebyshev1Slice, f : Double) -> Signalfilterchebyshev1Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_slice_add(a : Signalfilterchebyshev1Slice, b : Signalfilterchebyshev1Slice) -> Signalfilterchebyshev1Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev1_slice_copy(s : Signalfilterchebyshev1Slice) -> Signalfilterchebyshev1Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_slice_fill(s : Signalfilterchebyshev1Slice, v : Double) -> Signalfilterchebyshev1Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev1_slice_min(s : Signalfilterchebyshev1Slice) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev1_slice_max(s : Signalfilterchebyshev1Slice) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev1_slice_to_string(s : Signalfilterchebyshev1Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

