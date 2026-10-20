///===
/// extcore/timeseries_decomp_x11

pub(all) struct Timeseriesdecompx11Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_x11_make_point(x : Double, y : Double) -> Timeseriesdecompx11Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_x11_make_point3(x : Double, y : Double, z : Double) -> Timeseriesdecompx11Point {
  { x, y, z, label: 0 }
}

pub fn Timeseriesdecompx11Point::x(self : Timeseriesdecompx11Point) -> Double { self.x }

pub fn Timeseriesdecompx11Point::y(self : Timeseriesdecompx11Point) -> Double { self.y }

pub fn Timeseriesdecompx11Point::z(self : Timeseriesdecompx11Point) -> Double { self.z }

pub fn Timeseriesdecompx11Point::label(self : Timeseriesdecompx11Point) -> Int { self.label }

pub fn Timeseriesdecompx11Point::dist(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Timeseriesdecompx11Point::add(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Timeseriesdecompx11Point::sub(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Timeseriesdecompx11Point::scale(self : Timeseriesdecompx11Point, s : Double) -> Timeseriesdecompx11Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Timeseriesdecompx11Point::dot(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Timeseriesdecompx11Point::cross(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Timeseriesdecompx11Point::norm(self : Timeseriesdecompx11Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Timeseriesdecompx11Point::normalize(self : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Timeseriesdecompx11Point::negate(self : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Timeseriesdecompx11Point::mid(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point) -> Timeseriesdecompx11Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Timeseriesdecompx11Point::lerp(self : Timeseriesdecompx11Point, other : Timeseriesdecompx11Point, t : Double) -> Timeseriesdecompx11Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Timeseriesdecompx11Point::to_string(self : Timeseriesdecompx11Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_x11_make_series(vals : Array[Double], name : String) -> Timeseriesdecompx11Series {
  { vals, name, meta: 0 }
}

pub fn Timeseriesdecompx11Series::len(self : Timeseriesdecompx11Series) -> Int { self.vals.length() }

pub fn Timeseriesdecompx11Series::sum(self : Timeseriesdecompx11Series) -> Double { @_common.sum(self.vals) }

pub fn Timeseriesdecompx11Series::mean(self : Timeseriesdecompx11Series) -> Double { @_common.mean(self.vals) }

pub fn Timeseriesdecompx11Series::min(self : Timeseriesdecompx11Series) -> Double { @_common.min(self.vals) }

pub fn Timeseriesdecompx11Series::max(self : Timeseriesdecompx11Series) -> Double { @_common.max(self.vals) }

pub fn Timeseriesdecompx11Series::range(self : Timeseriesdecompx11Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Timeseriesdecompx11Series::variance(self : Timeseriesdecompx11Series) -> Double { @_common.variance(self.vals) }

pub fn Timeseriesdecompx11Series::std(self : Timeseriesdecompx11Series) -> Double { @_common.std(self.vals) }

pub fn Timeseriesdecompx11Series::median(self : Timeseriesdecompx11Series) -> Double { @_common.median(self.vals) }

pub fn Timeseriesdecompx11Series::scale(self : Timeseriesdecompx11Series, f : Double) -> Timeseriesdecompx11Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Timeseriesdecompx11Series::add(self : Timeseriesdecompx11Series, other : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Timeseriesdecompx11Series::sub(self : Timeseriesdecompx11Series, other : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Timeseriesdecompx11Series::normalize(self : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Timeseriesdecompx11Series::cumsum(self : Timeseriesdecompx11Series) -> Timeseriesdecompx11Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Timeseriesdecompx11Series::to_string(self : Timeseriesdecompx11Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Timeseriesdecompx11Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_x11_make_matrix(rows : Int, cols : Int, val : Double) -> Timeseriesdecompx11Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_x11_matrix_identity(n : Int) -> Timeseriesdecompx11Matrix {
  let m = timeseries_decomp_x11_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Timeseriesdecompx11Matrix::get(self : Timeseriesdecompx11Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Timeseriesdecompx11Matrix::transpose(self : Timeseriesdecompx11Matrix) -> Timeseriesdecompx11Matrix {
  let result = timeseries_decomp_x11_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Timeseriesdecompx11Matrix::add(self : Timeseriesdecompx11Matrix, other : Timeseriesdecompx11Matrix) -> Timeseriesdecompx11Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_x11_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Timeseriesdecompx11Matrix::scale(self : Timeseriesdecompx11Matrix, s : Double) -> Timeseriesdecompx11Matrix {
  let result = timeseries_decomp_x11_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Timeseriesdecompx11Matrix::multiply(self : Timeseriesdecompx11Matrix, other : Timeseriesdecompx11Matrix) -> Timeseriesdecompx11Matrix {
  if self.cols != other.rows { return timeseries_decomp_x11_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_x11_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Timeseriesdecompx11Matrix::trace(self : Timeseriesdecompx11Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Timeseriesdecompx11Matrix::det(self : Timeseriesdecompx11Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Timeseriesdecompx11Matrix::norm(self : Timeseriesdecompx11Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Timeseriesdecompx11Matrix::to_string(self : Timeseriesdecompx11Matrix) -> String {
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

pub(all) struct Timeseriesdecompx11Vector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_x11_make_vector(comps : Array[Double]) -> Timeseriesdecompx11Vector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_x11_vector_zero(dim : Int) -> Timeseriesdecompx11Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Timeseriesdecompx11Vector::add(self : Timeseriesdecompx11Vector, other : Timeseriesdecompx11Vector) -> Timeseriesdecompx11Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Timeseriesdecompx11Vector::sub(self : Timeseriesdecompx11Vector, other : Timeseriesdecompx11Vector) -> Timeseriesdecompx11Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Timeseriesdecompx11Vector::scale(self : Timeseriesdecompx11Vector, s : Double) -> Timeseriesdecompx11Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Timeseriesdecompx11Vector::dot(self : Timeseriesdecompx11Vector, other : Timeseriesdecompx11Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Timeseriesdecompx11Vector::norm(self : Timeseriesdecompx11Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Timeseriesdecompx11Vector::normalize(self : Timeseriesdecompx11Vector) -> Timeseriesdecompx11Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Timeseriesdecompx11Vector::dist(self : Timeseriesdecompx11Vector, other : Timeseriesdecompx11Vector) -> Double {
  self.sub(other).norm()
}

pub fn Timeseriesdecompx11Vector::to_string(self : Timeseriesdecompx11Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_x11_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_x11_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_x11_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_x11_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_x11_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_x11_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_x11_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_x11_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_x11_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_x11_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_x11_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_x11_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_x11_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_x11_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_x11_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_x11_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_x11_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_x11_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_x11_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_x11_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_x11_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_x11_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_x11_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_x11_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_x11_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_x11_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_x11_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_x11_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_x11_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Timeseriesdecompx11Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_frame_make(size : Int) -> Timeseriesdecompx11Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_frame_len(s : Timeseriesdecompx11Frame) -> Int { s.size }

pub fn timeseries_decomp_x11_frame_get(s : Timeseriesdecompx11Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_frame_set(s : Timeseriesdecompx11Frame, i : Int, v : Double) -> Timeseriesdecompx11Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_frame_sum(s : Timeseriesdecompx11Frame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_frame_mean(s : Timeseriesdecompx11Frame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_frame_scale(s : Timeseriesdecompx11Frame, f : Double) -> Timeseriesdecompx11Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_frame_add(a : Timeseriesdecompx11Frame, b : Timeseriesdecompx11Frame) -> Timeseriesdecompx11Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_frame_copy(s : Timeseriesdecompx11Frame) -> Timeseriesdecompx11Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_frame_fill(s : Timeseriesdecompx11Frame, v : Double) -> Timeseriesdecompx11Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_frame_min(s : Timeseriesdecompx11Frame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_frame_max(s : Timeseriesdecompx11Frame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_frame_to_string(s : Timeseriesdecompx11Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_table_make(size : Int) -> Timeseriesdecompx11Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_table_len(s : Timeseriesdecompx11Table) -> Int { s.size }

pub fn timeseries_decomp_x11_table_get(s : Timeseriesdecompx11Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_table_set(s : Timeseriesdecompx11Table, i : Int, v : Double) -> Timeseriesdecompx11Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_table_sum(s : Timeseriesdecompx11Table) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_table_mean(s : Timeseriesdecompx11Table) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_table_scale(s : Timeseriesdecompx11Table, f : Double) -> Timeseriesdecompx11Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_table_add(a : Timeseriesdecompx11Table, b : Timeseriesdecompx11Table) -> Timeseriesdecompx11Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_table_copy(s : Timeseriesdecompx11Table) -> Timeseriesdecompx11Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_table_fill(s : Timeseriesdecompx11Table, v : Double) -> Timeseriesdecompx11Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_table_min(s : Timeseriesdecompx11Table) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_table_max(s : Timeseriesdecompx11Table) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_table_to_string(s : Timeseriesdecompx11Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_graphn_make(size : Int) -> Timeseriesdecompx11GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_graphn_len(s : Timeseriesdecompx11GraphN) -> Int { s.size }

pub fn timeseries_decomp_x11_graphn_get(s : Timeseriesdecompx11GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_graphn_set(s : Timeseriesdecompx11GraphN, i : Int, v : Double) -> Timeseriesdecompx11GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_graphn_sum(s : Timeseriesdecompx11GraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_graphn_mean(s : Timeseriesdecompx11GraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_graphn_scale(s : Timeseriesdecompx11GraphN, f : Double) -> Timeseriesdecompx11GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_graphn_add(a : Timeseriesdecompx11GraphN, b : Timeseriesdecompx11GraphN) -> Timeseriesdecompx11GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_graphn_copy(s : Timeseriesdecompx11GraphN) -> Timeseriesdecompx11GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_graphn_fill(s : Timeseriesdecompx11GraphN, v : Double) -> Timeseriesdecompx11GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_graphn_min(s : Timeseriesdecompx11GraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_graphn_max(s : Timeseriesdecompx11GraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_graphn_to_string(s : Timeseriesdecompx11GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_node_make(size : Int) -> Timeseriesdecompx11Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_node_len(s : Timeseriesdecompx11Node) -> Int { s.size }

pub fn timeseries_decomp_x11_node_get(s : Timeseriesdecompx11Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_node_set(s : Timeseriesdecompx11Node, i : Int, v : Double) -> Timeseriesdecompx11Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_node_sum(s : Timeseriesdecompx11Node) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_node_mean(s : Timeseriesdecompx11Node) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_node_scale(s : Timeseriesdecompx11Node, f : Double) -> Timeseriesdecompx11Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_node_add(a : Timeseriesdecompx11Node, b : Timeseriesdecompx11Node) -> Timeseriesdecompx11Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_node_copy(s : Timeseriesdecompx11Node) -> Timeseriesdecompx11Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_node_fill(s : Timeseriesdecompx11Node, v : Double) -> Timeseriesdecompx11Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_node_min(s : Timeseriesdecompx11Node) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_node_max(s : Timeseriesdecompx11Node) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_node_to_string(s : Timeseriesdecompx11Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_edge_make(size : Int) -> Timeseriesdecompx11Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_edge_len(s : Timeseriesdecompx11Edge) -> Int { s.size }

pub fn timeseries_decomp_x11_edge_get(s : Timeseriesdecompx11Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_edge_set(s : Timeseriesdecompx11Edge, i : Int, v : Double) -> Timeseriesdecompx11Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_edge_sum(s : Timeseriesdecompx11Edge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_edge_mean(s : Timeseriesdecompx11Edge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_edge_scale(s : Timeseriesdecompx11Edge, f : Double) -> Timeseriesdecompx11Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_edge_add(a : Timeseriesdecompx11Edge, b : Timeseriesdecompx11Edge) -> Timeseriesdecompx11Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_edge_copy(s : Timeseriesdecompx11Edge) -> Timeseriesdecompx11Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_edge_fill(s : Timeseriesdecompx11Edge, v : Double) -> Timeseriesdecompx11Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_edge_min(s : Timeseriesdecompx11Edge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_edge_max(s : Timeseriesdecompx11Edge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_edge_to_string(s : Timeseriesdecompx11Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_path_make(size : Int) -> Timeseriesdecompx11Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_path_len(s : Timeseriesdecompx11Path) -> Int { s.size }

pub fn timeseries_decomp_x11_path_get(s : Timeseriesdecompx11Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_path_set(s : Timeseriesdecompx11Path, i : Int, v : Double) -> Timeseriesdecompx11Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_path_sum(s : Timeseriesdecompx11Path) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_path_mean(s : Timeseriesdecompx11Path) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_path_scale(s : Timeseriesdecompx11Path, f : Double) -> Timeseriesdecompx11Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_path_add(a : Timeseriesdecompx11Path, b : Timeseriesdecompx11Path) -> Timeseriesdecompx11Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_path_copy(s : Timeseriesdecompx11Path) -> Timeseriesdecompx11Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_path_fill(s : Timeseriesdecompx11Path, v : Double) -> Timeseriesdecompx11Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_path_min(s : Timeseriesdecompx11Path) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_path_max(s : Timeseriesdecompx11Path) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_path_to_string(s : Timeseriesdecompx11Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_cluster_make(size : Int) -> Timeseriesdecompx11Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_cluster_len(s : Timeseriesdecompx11Cluster) -> Int { s.size }

pub fn timeseries_decomp_x11_cluster_get(s : Timeseriesdecompx11Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_cluster_set(s : Timeseriesdecompx11Cluster, i : Int, v : Double) -> Timeseriesdecompx11Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cluster_sum(s : Timeseriesdecompx11Cluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_cluster_mean(s : Timeseriesdecompx11Cluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_cluster_scale(s : Timeseriesdecompx11Cluster, f : Double) -> Timeseriesdecompx11Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cluster_add(a : Timeseriesdecompx11Cluster, b : Timeseriesdecompx11Cluster) -> Timeseriesdecompx11Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_cluster_copy(s : Timeseriesdecompx11Cluster) -> Timeseriesdecompx11Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cluster_fill(s : Timeseriesdecompx11Cluster, v : Double) -> Timeseriesdecompx11Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cluster_min(s : Timeseriesdecompx11Cluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_cluster_max(s : Timeseriesdecompx11Cluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_cluster_to_string(s : Timeseriesdecompx11Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_model_make(size : Int) -> Timeseriesdecompx11Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_model_len(s : Timeseriesdecompx11Model) -> Int { s.size }

pub fn timeseries_decomp_x11_model_get(s : Timeseriesdecompx11Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_model_set(s : Timeseriesdecompx11Model, i : Int, v : Double) -> Timeseriesdecompx11Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_model_sum(s : Timeseriesdecompx11Model) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_model_mean(s : Timeseriesdecompx11Model) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_model_scale(s : Timeseriesdecompx11Model, f : Double) -> Timeseriesdecompx11Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_model_add(a : Timeseriesdecompx11Model, b : Timeseriesdecompx11Model) -> Timeseriesdecompx11Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_model_copy(s : Timeseriesdecompx11Model) -> Timeseriesdecompx11Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_model_fill(s : Timeseriesdecompx11Model, v : Double) -> Timeseriesdecompx11Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_model_min(s : Timeseriesdecompx11Model) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_model_max(s : Timeseriesdecompx11Model) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_model_to_string(s : Timeseriesdecompx11Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_layer_make(size : Int) -> Timeseriesdecompx11Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_layer_len(s : Timeseriesdecompx11Layer) -> Int { s.size }

pub fn timeseries_decomp_x11_layer_get(s : Timeseriesdecompx11Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_layer_set(s : Timeseriesdecompx11Layer, i : Int, v : Double) -> Timeseriesdecompx11Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_layer_sum(s : Timeseriesdecompx11Layer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_layer_mean(s : Timeseriesdecompx11Layer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_layer_scale(s : Timeseriesdecompx11Layer, f : Double) -> Timeseriesdecompx11Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_layer_add(a : Timeseriesdecompx11Layer, b : Timeseriesdecompx11Layer) -> Timeseriesdecompx11Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_layer_copy(s : Timeseriesdecompx11Layer) -> Timeseriesdecompx11Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_layer_fill(s : Timeseriesdecompx11Layer, v : Double) -> Timeseriesdecompx11Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_layer_min(s : Timeseriesdecompx11Layer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_layer_max(s : Timeseriesdecompx11Layer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_layer_to_string(s : Timeseriesdecompx11Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_buffer_make(size : Int) -> Timeseriesdecompx11Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_buffer_len(s : Timeseriesdecompx11Buffer) -> Int { s.size }

pub fn timeseries_decomp_x11_buffer_get(s : Timeseriesdecompx11Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_buffer_set(s : Timeseriesdecompx11Buffer, i : Int, v : Double) -> Timeseriesdecompx11Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_buffer_sum(s : Timeseriesdecompx11Buffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_buffer_mean(s : Timeseriesdecompx11Buffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_buffer_scale(s : Timeseriesdecompx11Buffer, f : Double) -> Timeseriesdecompx11Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_buffer_add(a : Timeseriesdecompx11Buffer, b : Timeseriesdecompx11Buffer) -> Timeseriesdecompx11Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_buffer_copy(s : Timeseriesdecompx11Buffer) -> Timeseriesdecompx11Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_buffer_fill(s : Timeseriesdecompx11Buffer, v : Double) -> Timeseriesdecompx11Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_buffer_min(s : Timeseriesdecompx11Buffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_buffer_max(s : Timeseriesdecompx11Buffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_buffer_to_string(s : Timeseriesdecompx11Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_cursor_make(size : Int) -> Timeseriesdecompx11Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_cursor_len(s : Timeseriesdecompx11Cursor) -> Int { s.size }

pub fn timeseries_decomp_x11_cursor_get(s : Timeseriesdecompx11Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_cursor_set(s : Timeseriesdecompx11Cursor, i : Int, v : Double) -> Timeseriesdecompx11Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cursor_sum(s : Timeseriesdecompx11Cursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_cursor_mean(s : Timeseriesdecompx11Cursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_cursor_scale(s : Timeseriesdecompx11Cursor, f : Double) -> Timeseriesdecompx11Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cursor_add(a : Timeseriesdecompx11Cursor, b : Timeseriesdecompx11Cursor) -> Timeseriesdecompx11Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_cursor_copy(s : Timeseriesdecompx11Cursor) -> Timeseriesdecompx11Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cursor_fill(s : Timeseriesdecompx11Cursor, v : Double) -> Timeseriesdecompx11Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_cursor_min(s : Timeseriesdecompx11Cursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_cursor_max(s : Timeseriesdecompx11Cursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_cursor_to_string(s : Timeseriesdecompx11Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_view_make(size : Int) -> Timeseriesdecompx11View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_view_len(s : Timeseriesdecompx11View) -> Int { s.size }

pub fn timeseries_decomp_x11_view_get(s : Timeseriesdecompx11View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_view_set(s : Timeseriesdecompx11View, i : Int, v : Double) -> Timeseriesdecompx11View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_view_sum(s : Timeseriesdecompx11View) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_view_mean(s : Timeseriesdecompx11View) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_view_scale(s : Timeseriesdecompx11View, f : Double) -> Timeseriesdecompx11View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_view_add(a : Timeseriesdecompx11View, b : Timeseriesdecompx11View) -> Timeseriesdecompx11View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_view_copy(s : Timeseriesdecompx11View) -> Timeseriesdecompx11View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_view_fill(s : Timeseriesdecompx11View, v : Double) -> Timeseriesdecompx11View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_view_min(s : Timeseriesdecompx11View) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_view_max(s : Timeseriesdecompx11View) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_view_to_string(s : Timeseriesdecompx11View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_range_make(size : Int) -> Timeseriesdecompx11Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_range_len(s : Timeseriesdecompx11Range) -> Int { s.size }

pub fn timeseries_decomp_x11_range_get(s : Timeseriesdecompx11Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_range_set(s : Timeseriesdecompx11Range, i : Int, v : Double) -> Timeseriesdecompx11Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_range_sum(s : Timeseriesdecompx11Range) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_range_mean(s : Timeseriesdecompx11Range) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_range_scale(s : Timeseriesdecompx11Range, f : Double) -> Timeseriesdecompx11Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_range_add(a : Timeseriesdecompx11Range, b : Timeseriesdecompx11Range) -> Timeseriesdecompx11Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_range_copy(s : Timeseriesdecompx11Range) -> Timeseriesdecompx11Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_range_fill(s : Timeseriesdecompx11Range, v : Double) -> Timeseriesdecompx11Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_range_min(s : Timeseriesdecompx11Range) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_range_max(s : Timeseriesdecompx11Range) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_range_to_string(s : Timeseriesdecompx11Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_slice_make(size : Int) -> Timeseriesdecompx11Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_x11_slice_len(s : Timeseriesdecompx11Slice) -> Int { s.size }

pub fn timeseries_decomp_x11_slice_get(s : Timeseriesdecompx11Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_x11_slice_set(s : Timeseriesdecompx11Slice, i : Int, v : Double) -> Timeseriesdecompx11Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_slice_sum(s : Timeseriesdecompx11Slice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_x11_slice_mean(s : Timeseriesdecompx11Slice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_x11_slice_scale(s : Timeseriesdecompx11Slice, f : Double) -> Timeseriesdecompx11Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_slice_add(a : Timeseriesdecompx11Slice, b : Timeseriesdecompx11Slice) -> Timeseriesdecompx11Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_x11_slice_copy(s : Timeseriesdecompx11Slice) -> Timeseriesdecompx11Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_slice_fill(s : Timeseriesdecompx11Slice, v : Double) -> Timeseriesdecompx11Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_x11_slice_min(s : Timeseriesdecompx11Slice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_x11_slice_max(s : Timeseriesdecompx11Slice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_x11_slice_to_string(s : Timeseriesdecompx11Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

