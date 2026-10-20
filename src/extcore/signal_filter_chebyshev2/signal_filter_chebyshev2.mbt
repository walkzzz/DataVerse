///===
/// extcore/signal_filter_chebyshev2

pub(all) struct Signalfilterchebyshev2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_chebyshev2_make_point(x : Double, y : Double) -> Signalfilterchebyshev2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_chebyshev2_make_point3(x : Double, y : Double, z : Double) -> Signalfilterchebyshev2Point {
  { x, y, z, label: 0 }
}

pub fn Signalfilterchebyshev2Point::x(self : Signalfilterchebyshev2Point) -> Double { self.x }

pub fn Signalfilterchebyshev2Point::y(self : Signalfilterchebyshev2Point) -> Double { self.y }

pub fn Signalfilterchebyshev2Point::z(self : Signalfilterchebyshev2Point) -> Double { self.z }

pub fn Signalfilterchebyshev2Point::label(self : Signalfilterchebyshev2Point) -> Int { self.label }

pub fn Signalfilterchebyshev2Point::dist(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Signalfilterchebyshev2Point::add(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Signalfilterchebyshev2Point::sub(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Signalfilterchebyshev2Point::scale(self : Signalfilterchebyshev2Point, s : Double) -> Signalfilterchebyshev2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Signalfilterchebyshev2Point::dot(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Signalfilterchebyshev2Point::cross(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Signalfilterchebyshev2Point::norm(self : Signalfilterchebyshev2Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Signalfilterchebyshev2Point::normalize(self : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Signalfilterchebyshev2Point::negate(self : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Signalfilterchebyshev2Point::mid(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point) -> Signalfilterchebyshev2Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Signalfilterchebyshev2Point::lerp(self : Signalfilterchebyshev2Point, other : Signalfilterchebyshev2Point, t : Double) -> Signalfilterchebyshev2Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Signalfilterchebyshev2Point::to_string(self : Signalfilterchebyshev2Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_chebyshev2_make_series(vals : Array[Double], name : String) -> Signalfilterchebyshev2Series {
  { vals, name, meta: 0 }
}

pub fn Signalfilterchebyshev2Series::len(self : Signalfilterchebyshev2Series) -> Int { self.vals.length() }

pub fn Signalfilterchebyshev2Series::sum(self : Signalfilterchebyshev2Series) -> Double { @_common.sum(self.vals) }

pub fn Signalfilterchebyshev2Series::mean(self : Signalfilterchebyshev2Series) -> Double { @_common.mean(self.vals) }

pub fn Signalfilterchebyshev2Series::min(self : Signalfilterchebyshev2Series) -> Double { @_common.min(self.vals) }

pub fn Signalfilterchebyshev2Series::max(self : Signalfilterchebyshev2Series) -> Double { @_common.max(self.vals) }

pub fn Signalfilterchebyshev2Series::range(self : Signalfilterchebyshev2Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Signalfilterchebyshev2Series::variance(self : Signalfilterchebyshev2Series) -> Double { @_common.variance(self.vals) }

pub fn Signalfilterchebyshev2Series::std(self : Signalfilterchebyshev2Series) -> Double { @_common.std(self.vals) }

pub fn Signalfilterchebyshev2Series::median(self : Signalfilterchebyshev2Series) -> Double { @_common.median(self.vals) }

pub fn Signalfilterchebyshev2Series::scale(self : Signalfilterchebyshev2Series, f : Double) -> Signalfilterchebyshev2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Signalfilterchebyshev2Series::add(self : Signalfilterchebyshev2Series, other : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Signalfilterchebyshev2Series::sub(self : Signalfilterchebyshev2Series, other : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Signalfilterchebyshev2Series::normalize(self : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Signalfilterchebyshev2Series::cumsum(self : Signalfilterchebyshev2Series) -> Signalfilterchebyshev2Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Signalfilterchebyshev2Series::to_string(self : Signalfilterchebyshev2Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Signalfilterchebyshev2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_chebyshev2_make_matrix(rows : Int, cols : Int, val : Double) -> Signalfilterchebyshev2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_chebyshev2_matrix_identity(n : Int) -> Signalfilterchebyshev2Matrix {
  let m = signal_filter_chebyshev2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Signalfilterchebyshev2Matrix::get(self : Signalfilterchebyshev2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Signalfilterchebyshev2Matrix::transpose(self : Signalfilterchebyshev2Matrix) -> Signalfilterchebyshev2Matrix {
  let result = signal_filter_chebyshev2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Signalfilterchebyshev2Matrix::add(self : Signalfilterchebyshev2Matrix, other : Signalfilterchebyshev2Matrix) -> Signalfilterchebyshev2Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_chebyshev2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Signalfilterchebyshev2Matrix::scale(self : Signalfilterchebyshev2Matrix, s : Double) -> Signalfilterchebyshev2Matrix {
  let result = signal_filter_chebyshev2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Signalfilterchebyshev2Matrix::multiply(self : Signalfilterchebyshev2Matrix, other : Signalfilterchebyshev2Matrix) -> Signalfilterchebyshev2Matrix {
  if self.cols != other.rows { return signal_filter_chebyshev2_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_chebyshev2_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Signalfilterchebyshev2Matrix::trace(self : Signalfilterchebyshev2Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Signalfilterchebyshev2Matrix::det(self : Signalfilterchebyshev2Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Signalfilterchebyshev2Matrix::norm(self : Signalfilterchebyshev2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Signalfilterchebyshev2Matrix::to_string(self : Signalfilterchebyshev2Matrix) -> String {
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

pub(all) struct Signalfilterchebyshev2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_chebyshev2_make_vector(comps : Array[Double]) -> Signalfilterchebyshev2Vector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_chebyshev2_vector_zero(dim : Int) -> Signalfilterchebyshev2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Signalfilterchebyshev2Vector::add(self : Signalfilterchebyshev2Vector, other : Signalfilterchebyshev2Vector) -> Signalfilterchebyshev2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Signalfilterchebyshev2Vector::sub(self : Signalfilterchebyshev2Vector, other : Signalfilterchebyshev2Vector) -> Signalfilterchebyshev2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Signalfilterchebyshev2Vector::scale(self : Signalfilterchebyshev2Vector, s : Double) -> Signalfilterchebyshev2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Signalfilterchebyshev2Vector::dot(self : Signalfilterchebyshev2Vector, other : Signalfilterchebyshev2Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Signalfilterchebyshev2Vector::norm(self : Signalfilterchebyshev2Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Signalfilterchebyshev2Vector::normalize(self : Signalfilterchebyshev2Vector) -> Signalfilterchebyshev2Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Signalfilterchebyshev2Vector::dist(self : Signalfilterchebyshev2Vector, other : Signalfilterchebyshev2Vector) -> Double {
  self.sub(other).norm()
}

pub fn Signalfilterchebyshev2Vector::to_string(self : Signalfilterchebyshev2Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_chebyshev2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_chebyshev2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_chebyshev2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_chebyshev2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_chebyshev2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_chebyshev2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_chebyshev2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_chebyshev2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_chebyshev2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_chebyshev2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_chebyshev2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_chebyshev2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_chebyshev2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_chebyshev2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_chebyshev2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_chebyshev2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_chebyshev2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_chebyshev2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_chebyshev2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_chebyshev2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_chebyshev2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_chebyshev2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_chebyshev2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_chebyshev2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_chebyshev2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_chebyshev2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_chebyshev2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_chebyshev2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_chebyshev2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Signalfilterchebyshev2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_frame_make(size : Int) -> Signalfilterchebyshev2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_frame_len(s : Signalfilterchebyshev2Frame) -> Int { s.size }

pub fn signal_filter_chebyshev2_frame_get(s : Signalfilterchebyshev2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_frame_set(s : Signalfilterchebyshev2Frame, i : Int, v : Double) -> Signalfilterchebyshev2Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_sum(s : Signalfilterchebyshev2Frame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_frame_mean(s : Signalfilterchebyshev2Frame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_frame_scale(s : Signalfilterchebyshev2Frame, f : Double) -> Signalfilterchebyshev2Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_add(a : Signalfilterchebyshev2Frame, b : Signalfilterchebyshev2Frame) -> Signalfilterchebyshev2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_frame_copy(s : Signalfilterchebyshev2Frame) -> Signalfilterchebyshev2Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_fill(s : Signalfilterchebyshev2Frame, v : Double) -> Signalfilterchebyshev2Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_frame_min(s : Signalfilterchebyshev2Frame) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_frame_max(s : Signalfilterchebyshev2Frame) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_frame_to_string(s : Signalfilterchebyshev2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_table_make(size : Int) -> Signalfilterchebyshev2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_table_len(s : Signalfilterchebyshev2Table) -> Int { s.size }

pub fn signal_filter_chebyshev2_table_get(s : Signalfilterchebyshev2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_table_set(s : Signalfilterchebyshev2Table, i : Int, v : Double) -> Signalfilterchebyshev2Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_sum(s : Signalfilterchebyshev2Table) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_table_mean(s : Signalfilterchebyshev2Table) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_table_scale(s : Signalfilterchebyshev2Table, f : Double) -> Signalfilterchebyshev2Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_add(a : Signalfilterchebyshev2Table, b : Signalfilterchebyshev2Table) -> Signalfilterchebyshev2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_table_copy(s : Signalfilterchebyshev2Table) -> Signalfilterchebyshev2Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_fill(s : Signalfilterchebyshev2Table, v : Double) -> Signalfilterchebyshev2Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_table_min(s : Signalfilterchebyshev2Table) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_table_max(s : Signalfilterchebyshev2Table) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_table_to_string(s : Signalfilterchebyshev2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_graphn_make(size : Int) -> Signalfilterchebyshev2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_graphn_len(s : Signalfilterchebyshev2GraphN) -> Int { s.size }

pub fn signal_filter_chebyshev2_graphn_get(s : Signalfilterchebyshev2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_graphn_set(s : Signalfilterchebyshev2GraphN, i : Int, v : Double) -> Signalfilterchebyshev2GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_sum(s : Signalfilterchebyshev2GraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_graphn_mean(s : Signalfilterchebyshev2GraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_graphn_scale(s : Signalfilterchebyshev2GraphN, f : Double) -> Signalfilterchebyshev2GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_add(a : Signalfilterchebyshev2GraphN, b : Signalfilterchebyshev2GraphN) -> Signalfilterchebyshev2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_graphn_copy(s : Signalfilterchebyshev2GraphN) -> Signalfilterchebyshev2GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_fill(s : Signalfilterchebyshev2GraphN, v : Double) -> Signalfilterchebyshev2GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_graphn_min(s : Signalfilterchebyshev2GraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_graphn_max(s : Signalfilterchebyshev2GraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_graphn_to_string(s : Signalfilterchebyshev2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_node_make(size : Int) -> Signalfilterchebyshev2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_node_len(s : Signalfilterchebyshev2Node) -> Int { s.size }

pub fn signal_filter_chebyshev2_node_get(s : Signalfilterchebyshev2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_node_set(s : Signalfilterchebyshev2Node, i : Int, v : Double) -> Signalfilterchebyshev2Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_sum(s : Signalfilterchebyshev2Node) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_node_mean(s : Signalfilterchebyshev2Node) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_node_scale(s : Signalfilterchebyshev2Node, f : Double) -> Signalfilterchebyshev2Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_add(a : Signalfilterchebyshev2Node, b : Signalfilterchebyshev2Node) -> Signalfilterchebyshev2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_node_copy(s : Signalfilterchebyshev2Node) -> Signalfilterchebyshev2Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_fill(s : Signalfilterchebyshev2Node, v : Double) -> Signalfilterchebyshev2Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_node_min(s : Signalfilterchebyshev2Node) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_node_max(s : Signalfilterchebyshev2Node) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_node_to_string(s : Signalfilterchebyshev2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_edge_make(size : Int) -> Signalfilterchebyshev2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_edge_len(s : Signalfilterchebyshev2Edge) -> Int { s.size }

pub fn signal_filter_chebyshev2_edge_get(s : Signalfilterchebyshev2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_edge_set(s : Signalfilterchebyshev2Edge, i : Int, v : Double) -> Signalfilterchebyshev2Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_sum(s : Signalfilterchebyshev2Edge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_edge_mean(s : Signalfilterchebyshev2Edge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_edge_scale(s : Signalfilterchebyshev2Edge, f : Double) -> Signalfilterchebyshev2Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_add(a : Signalfilterchebyshev2Edge, b : Signalfilterchebyshev2Edge) -> Signalfilterchebyshev2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_edge_copy(s : Signalfilterchebyshev2Edge) -> Signalfilterchebyshev2Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_fill(s : Signalfilterchebyshev2Edge, v : Double) -> Signalfilterchebyshev2Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_edge_min(s : Signalfilterchebyshev2Edge) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_edge_max(s : Signalfilterchebyshev2Edge) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_edge_to_string(s : Signalfilterchebyshev2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_path_make(size : Int) -> Signalfilterchebyshev2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_path_len(s : Signalfilterchebyshev2Path) -> Int { s.size }

pub fn signal_filter_chebyshev2_path_get(s : Signalfilterchebyshev2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_path_set(s : Signalfilterchebyshev2Path, i : Int, v : Double) -> Signalfilterchebyshev2Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_sum(s : Signalfilterchebyshev2Path) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_path_mean(s : Signalfilterchebyshev2Path) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_path_scale(s : Signalfilterchebyshev2Path, f : Double) -> Signalfilterchebyshev2Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_add(a : Signalfilterchebyshev2Path, b : Signalfilterchebyshev2Path) -> Signalfilterchebyshev2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_path_copy(s : Signalfilterchebyshev2Path) -> Signalfilterchebyshev2Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_fill(s : Signalfilterchebyshev2Path, v : Double) -> Signalfilterchebyshev2Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_path_min(s : Signalfilterchebyshev2Path) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_path_max(s : Signalfilterchebyshev2Path) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_path_to_string(s : Signalfilterchebyshev2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_cluster_make(size : Int) -> Signalfilterchebyshev2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_cluster_len(s : Signalfilterchebyshev2Cluster) -> Int { s.size }

pub fn signal_filter_chebyshev2_cluster_get(s : Signalfilterchebyshev2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_cluster_set(s : Signalfilterchebyshev2Cluster, i : Int, v : Double) -> Signalfilterchebyshev2Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_sum(s : Signalfilterchebyshev2Cluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_cluster_mean(s : Signalfilterchebyshev2Cluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_cluster_scale(s : Signalfilterchebyshev2Cluster, f : Double) -> Signalfilterchebyshev2Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_add(a : Signalfilterchebyshev2Cluster, b : Signalfilterchebyshev2Cluster) -> Signalfilterchebyshev2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_cluster_copy(s : Signalfilterchebyshev2Cluster) -> Signalfilterchebyshev2Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_fill(s : Signalfilterchebyshev2Cluster, v : Double) -> Signalfilterchebyshev2Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cluster_min(s : Signalfilterchebyshev2Cluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_cluster_max(s : Signalfilterchebyshev2Cluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_cluster_to_string(s : Signalfilterchebyshev2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_model_make(size : Int) -> Signalfilterchebyshev2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_model_len(s : Signalfilterchebyshev2Model) -> Int { s.size }

pub fn signal_filter_chebyshev2_model_get(s : Signalfilterchebyshev2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_model_set(s : Signalfilterchebyshev2Model, i : Int, v : Double) -> Signalfilterchebyshev2Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_sum(s : Signalfilterchebyshev2Model) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_model_mean(s : Signalfilterchebyshev2Model) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_model_scale(s : Signalfilterchebyshev2Model, f : Double) -> Signalfilterchebyshev2Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_add(a : Signalfilterchebyshev2Model, b : Signalfilterchebyshev2Model) -> Signalfilterchebyshev2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_model_copy(s : Signalfilterchebyshev2Model) -> Signalfilterchebyshev2Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_fill(s : Signalfilterchebyshev2Model, v : Double) -> Signalfilterchebyshev2Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_model_min(s : Signalfilterchebyshev2Model) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_model_max(s : Signalfilterchebyshev2Model) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_model_to_string(s : Signalfilterchebyshev2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_layer_make(size : Int) -> Signalfilterchebyshev2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_layer_len(s : Signalfilterchebyshev2Layer) -> Int { s.size }

pub fn signal_filter_chebyshev2_layer_get(s : Signalfilterchebyshev2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_layer_set(s : Signalfilterchebyshev2Layer, i : Int, v : Double) -> Signalfilterchebyshev2Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_sum(s : Signalfilterchebyshev2Layer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_layer_mean(s : Signalfilterchebyshev2Layer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_layer_scale(s : Signalfilterchebyshev2Layer, f : Double) -> Signalfilterchebyshev2Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_add(a : Signalfilterchebyshev2Layer, b : Signalfilterchebyshev2Layer) -> Signalfilterchebyshev2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_layer_copy(s : Signalfilterchebyshev2Layer) -> Signalfilterchebyshev2Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_fill(s : Signalfilterchebyshev2Layer, v : Double) -> Signalfilterchebyshev2Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_layer_min(s : Signalfilterchebyshev2Layer) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_layer_max(s : Signalfilterchebyshev2Layer) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_layer_to_string(s : Signalfilterchebyshev2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_buffer_make(size : Int) -> Signalfilterchebyshev2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_buffer_len(s : Signalfilterchebyshev2Buffer) -> Int { s.size }

pub fn signal_filter_chebyshev2_buffer_get(s : Signalfilterchebyshev2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_buffer_set(s : Signalfilterchebyshev2Buffer, i : Int, v : Double) -> Signalfilterchebyshev2Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_sum(s : Signalfilterchebyshev2Buffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_buffer_mean(s : Signalfilterchebyshev2Buffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_buffer_scale(s : Signalfilterchebyshev2Buffer, f : Double) -> Signalfilterchebyshev2Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_add(a : Signalfilterchebyshev2Buffer, b : Signalfilterchebyshev2Buffer) -> Signalfilterchebyshev2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_buffer_copy(s : Signalfilterchebyshev2Buffer) -> Signalfilterchebyshev2Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_fill(s : Signalfilterchebyshev2Buffer, v : Double) -> Signalfilterchebyshev2Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_buffer_min(s : Signalfilterchebyshev2Buffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_buffer_max(s : Signalfilterchebyshev2Buffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_buffer_to_string(s : Signalfilterchebyshev2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_cursor_make(size : Int) -> Signalfilterchebyshev2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_cursor_len(s : Signalfilterchebyshev2Cursor) -> Int { s.size }

pub fn signal_filter_chebyshev2_cursor_get(s : Signalfilterchebyshev2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_cursor_set(s : Signalfilterchebyshev2Cursor, i : Int, v : Double) -> Signalfilterchebyshev2Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_sum(s : Signalfilterchebyshev2Cursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_cursor_mean(s : Signalfilterchebyshev2Cursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_cursor_scale(s : Signalfilterchebyshev2Cursor, f : Double) -> Signalfilterchebyshev2Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_add(a : Signalfilterchebyshev2Cursor, b : Signalfilterchebyshev2Cursor) -> Signalfilterchebyshev2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_cursor_copy(s : Signalfilterchebyshev2Cursor) -> Signalfilterchebyshev2Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_fill(s : Signalfilterchebyshev2Cursor, v : Double) -> Signalfilterchebyshev2Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_cursor_min(s : Signalfilterchebyshev2Cursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_cursor_max(s : Signalfilterchebyshev2Cursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_cursor_to_string(s : Signalfilterchebyshev2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_view_make(size : Int) -> Signalfilterchebyshev2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_view_len(s : Signalfilterchebyshev2View) -> Int { s.size }

pub fn signal_filter_chebyshev2_view_get(s : Signalfilterchebyshev2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_view_set(s : Signalfilterchebyshev2View, i : Int, v : Double) -> Signalfilterchebyshev2View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_sum(s : Signalfilterchebyshev2View) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_view_mean(s : Signalfilterchebyshev2View) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_view_scale(s : Signalfilterchebyshev2View, f : Double) -> Signalfilterchebyshev2View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_add(a : Signalfilterchebyshev2View, b : Signalfilterchebyshev2View) -> Signalfilterchebyshev2View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_view_copy(s : Signalfilterchebyshev2View) -> Signalfilterchebyshev2View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_fill(s : Signalfilterchebyshev2View, v : Double) -> Signalfilterchebyshev2View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_view_min(s : Signalfilterchebyshev2View) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_view_max(s : Signalfilterchebyshev2View) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_view_to_string(s : Signalfilterchebyshev2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_range_make(size : Int) -> Signalfilterchebyshev2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_range_len(s : Signalfilterchebyshev2Range) -> Int { s.size }

pub fn signal_filter_chebyshev2_range_get(s : Signalfilterchebyshev2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_range_set(s : Signalfilterchebyshev2Range, i : Int, v : Double) -> Signalfilterchebyshev2Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_sum(s : Signalfilterchebyshev2Range) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_range_mean(s : Signalfilterchebyshev2Range) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_range_scale(s : Signalfilterchebyshev2Range, f : Double) -> Signalfilterchebyshev2Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_add(a : Signalfilterchebyshev2Range, b : Signalfilterchebyshev2Range) -> Signalfilterchebyshev2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_range_copy(s : Signalfilterchebyshev2Range) -> Signalfilterchebyshev2Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_fill(s : Signalfilterchebyshev2Range, v : Double) -> Signalfilterchebyshev2Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_range_min(s : Signalfilterchebyshev2Range) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_range_max(s : Signalfilterchebyshev2Range) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_range_to_string(s : Signalfilterchebyshev2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Signalfilterchebyshev2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_chebyshev2_slice_make(size : Int) -> Signalfilterchebyshev2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_chebyshev2_slice_len(s : Signalfilterchebyshev2Slice) -> Int { s.size }

pub fn signal_filter_chebyshev2_slice_get(s : Signalfilterchebyshev2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_chebyshev2_slice_set(s : Signalfilterchebyshev2Slice, i : Int, v : Double) -> Signalfilterchebyshev2Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_sum(s : Signalfilterchebyshev2Slice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_chebyshev2_slice_mean(s : Signalfilterchebyshev2Slice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_chebyshev2_slice_scale(s : Signalfilterchebyshev2Slice, f : Double) -> Signalfilterchebyshev2Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_add(a : Signalfilterchebyshev2Slice, b : Signalfilterchebyshev2Slice) -> Signalfilterchebyshev2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_chebyshev2_slice_copy(s : Signalfilterchebyshev2Slice) -> Signalfilterchebyshev2Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_fill(s : Signalfilterchebyshev2Slice, v : Double) -> Signalfilterchebyshev2Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_chebyshev2_slice_min(s : Signalfilterchebyshev2Slice) -> Double { @_common.min(s.data) }

pub fn signal_filter_chebyshev2_slice_max(s : Signalfilterchebyshev2Slice) -> Double { @_common.max(s.data) }

pub fn signal_filter_chebyshev2_slice_to_string(s : Signalfilterchebyshev2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

