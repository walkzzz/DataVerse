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

pub fn Timeseriesdecompx11Frame::len(self : Timeseriesdecompx11Frame) -> Int { self.size }

pub fn Timeseriesdecompx11Frame::get(self : Timeseriesdecompx11Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Frame::set(self : Timeseriesdecompx11Frame, i : Int, v : Double) -> Timeseriesdecompx11Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Frame::sum(self : Timeseriesdecompx11Frame) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Frame::mean(self : Timeseriesdecompx11Frame) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Frame::scale(self : Timeseriesdecompx11Frame, f : Double) -> Timeseriesdecompx11Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Frame::add(self : Timeseriesdecompx11Frame, other : Timeseriesdecompx11Frame) -> Timeseriesdecompx11Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Frame::copy(self : Timeseriesdecompx11Frame) -> Timeseriesdecompx11Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Frame::fill(self : Timeseriesdecompx11Frame, v : Double) -> Timeseriesdecompx11Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Frame::min(self : Timeseriesdecompx11Frame) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Frame::max(self : Timeseriesdecompx11Frame) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Frame::to_string(self : Timeseriesdecompx11Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_table_make(size : Int) -> Timeseriesdecompx11Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Table::len(self : Timeseriesdecompx11Table) -> Int { self.size }

pub fn Timeseriesdecompx11Table::get(self : Timeseriesdecompx11Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Table::set(self : Timeseriesdecompx11Table, i : Int, v : Double) -> Timeseriesdecompx11Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Table::sum(self : Timeseriesdecompx11Table) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Table::mean(self : Timeseriesdecompx11Table) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Table::scale(self : Timeseriesdecompx11Table, f : Double) -> Timeseriesdecompx11Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Table::add(self : Timeseriesdecompx11Table, other : Timeseriesdecompx11Table) -> Timeseriesdecompx11Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Table::copy(self : Timeseriesdecompx11Table) -> Timeseriesdecompx11Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Table::fill(self : Timeseriesdecompx11Table, v : Double) -> Timeseriesdecompx11Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Table::min(self : Timeseriesdecompx11Table) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Table::max(self : Timeseriesdecompx11Table) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Table::to_string(self : Timeseriesdecompx11Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_graphn_make(size : Int) -> Timeseriesdecompx11GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11GraphN::len(self : Timeseriesdecompx11GraphN) -> Int { self.size }

pub fn Timeseriesdecompx11GraphN::get(self : Timeseriesdecompx11GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11GraphN::set(self : Timeseriesdecompx11GraphN, i : Int, v : Double) -> Timeseriesdecompx11GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11GraphN::sum(self : Timeseriesdecompx11GraphN) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11GraphN::mean(self : Timeseriesdecompx11GraphN) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11GraphN::scale(self : Timeseriesdecompx11GraphN, f : Double) -> Timeseriesdecompx11GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11GraphN::add(self : Timeseriesdecompx11GraphN, other : Timeseriesdecompx11GraphN) -> Timeseriesdecompx11GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11GraphN::copy(self : Timeseriesdecompx11GraphN) -> Timeseriesdecompx11GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11GraphN::fill(self : Timeseriesdecompx11GraphN, v : Double) -> Timeseriesdecompx11GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11GraphN::min(self : Timeseriesdecompx11GraphN) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11GraphN::max(self : Timeseriesdecompx11GraphN) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11GraphN::to_string(self : Timeseriesdecompx11GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_node_make(size : Int) -> Timeseriesdecompx11Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Node::len(self : Timeseriesdecompx11Node) -> Int { self.size }

pub fn Timeseriesdecompx11Node::get(self : Timeseriesdecompx11Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Node::set(self : Timeseriesdecompx11Node, i : Int, v : Double) -> Timeseriesdecompx11Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Node::sum(self : Timeseriesdecompx11Node) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Node::mean(self : Timeseriesdecompx11Node) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Node::scale(self : Timeseriesdecompx11Node, f : Double) -> Timeseriesdecompx11Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Node::add(self : Timeseriesdecompx11Node, other : Timeseriesdecompx11Node) -> Timeseriesdecompx11Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Node::copy(self : Timeseriesdecompx11Node) -> Timeseriesdecompx11Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Node::fill(self : Timeseriesdecompx11Node, v : Double) -> Timeseriesdecompx11Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Node::min(self : Timeseriesdecompx11Node) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Node::max(self : Timeseriesdecompx11Node) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Node::to_string(self : Timeseriesdecompx11Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_edge_make(size : Int) -> Timeseriesdecompx11Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Edge::len(self : Timeseriesdecompx11Edge) -> Int { self.size }

pub fn Timeseriesdecompx11Edge::get(self : Timeseriesdecompx11Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Edge::set(self : Timeseriesdecompx11Edge, i : Int, v : Double) -> Timeseriesdecompx11Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Edge::sum(self : Timeseriesdecompx11Edge) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Edge::mean(self : Timeseriesdecompx11Edge) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Edge::scale(self : Timeseriesdecompx11Edge, f : Double) -> Timeseriesdecompx11Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Edge::add(self : Timeseriesdecompx11Edge, other : Timeseriesdecompx11Edge) -> Timeseriesdecompx11Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Edge::copy(self : Timeseriesdecompx11Edge) -> Timeseriesdecompx11Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Edge::fill(self : Timeseriesdecompx11Edge, v : Double) -> Timeseriesdecompx11Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Edge::min(self : Timeseriesdecompx11Edge) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Edge::max(self : Timeseriesdecompx11Edge) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Edge::to_string(self : Timeseriesdecompx11Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_path_make(size : Int) -> Timeseriesdecompx11Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Path::len(self : Timeseriesdecompx11Path) -> Int { self.size }

pub fn Timeseriesdecompx11Path::get(self : Timeseriesdecompx11Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Path::set(self : Timeseriesdecompx11Path, i : Int, v : Double) -> Timeseriesdecompx11Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Path::sum(self : Timeseriesdecompx11Path) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Path::mean(self : Timeseriesdecompx11Path) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Path::scale(self : Timeseriesdecompx11Path, f : Double) -> Timeseriesdecompx11Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Path::add(self : Timeseriesdecompx11Path, other : Timeseriesdecompx11Path) -> Timeseriesdecompx11Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Path::copy(self : Timeseriesdecompx11Path) -> Timeseriesdecompx11Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Path::fill(self : Timeseriesdecompx11Path, v : Double) -> Timeseriesdecompx11Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Path::min(self : Timeseriesdecompx11Path) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Path::max(self : Timeseriesdecompx11Path) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Path::to_string(self : Timeseriesdecompx11Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_cluster_make(size : Int) -> Timeseriesdecompx11Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Cluster::len(self : Timeseriesdecompx11Cluster) -> Int { self.size }

pub fn Timeseriesdecompx11Cluster::get(self : Timeseriesdecompx11Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Cluster::set(self : Timeseriesdecompx11Cluster, i : Int, v : Double) -> Timeseriesdecompx11Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cluster::sum(self : Timeseriesdecompx11Cluster) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Cluster::mean(self : Timeseriesdecompx11Cluster) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Cluster::scale(self : Timeseriesdecompx11Cluster, f : Double) -> Timeseriesdecompx11Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cluster::add(self : Timeseriesdecompx11Cluster, other : Timeseriesdecompx11Cluster) -> Timeseriesdecompx11Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Cluster::copy(self : Timeseriesdecompx11Cluster) -> Timeseriesdecompx11Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cluster::fill(self : Timeseriesdecompx11Cluster, v : Double) -> Timeseriesdecompx11Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cluster::min(self : Timeseriesdecompx11Cluster) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Cluster::max(self : Timeseriesdecompx11Cluster) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Cluster::to_string(self : Timeseriesdecompx11Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_model_make(size : Int) -> Timeseriesdecompx11Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Model::len(self : Timeseriesdecompx11Model) -> Int { self.size }

pub fn Timeseriesdecompx11Model::get(self : Timeseriesdecompx11Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Model::set(self : Timeseriesdecompx11Model, i : Int, v : Double) -> Timeseriesdecompx11Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Model::sum(self : Timeseriesdecompx11Model) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Model::mean(self : Timeseriesdecompx11Model) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Model::scale(self : Timeseriesdecompx11Model, f : Double) -> Timeseriesdecompx11Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Model::add(self : Timeseriesdecompx11Model, other : Timeseriesdecompx11Model) -> Timeseriesdecompx11Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Model::copy(self : Timeseriesdecompx11Model) -> Timeseriesdecompx11Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Model::fill(self : Timeseriesdecompx11Model, v : Double) -> Timeseriesdecompx11Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Model::min(self : Timeseriesdecompx11Model) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Model::max(self : Timeseriesdecompx11Model) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Model::to_string(self : Timeseriesdecompx11Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_layer_make(size : Int) -> Timeseriesdecompx11Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Layer::len(self : Timeseriesdecompx11Layer) -> Int { self.size }

pub fn Timeseriesdecompx11Layer::get(self : Timeseriesdecompx11Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Layer::set(self : Timeseriesdecompx11Layer, i : Int, v : Double) -> Timeseriesdecompx11Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Layer::sum(self : Timeseriesdecompx11Layer) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Layer::mean(self : Timeseriesdecompx11Layer) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Layer::scale(self : Timeseriesdecompx11Layer, f : Double) -> Timeseriesdecompx11Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Layer::add(self : Timeseriesdecompx11Layer, other : Timeseriesdecompx11Layer) -> Timeseriesdecompx11Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Layer::copy(self : Timeseriesdecompx11Layer) -> Timeseriesdecompx11Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Layer::fill(self : Timeseriesdecompx11Layer, v : Double) -> Timeseriesdecompx11Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Layer::min(self : Timeseriesdecompx11Layer) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Layer::max(self : Timeseriesdecompx11Layer) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Layer::to_string(self : Timeseriesdecompx11Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_buffer_make(size : Int) -> Timeseriesdecompx11Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Buffer::len(self : Timeseriesdecompx11Buffer) -> Int { self.size }

pub fn Timeseriesdecompx11Buffer::get(self : Timeseriesdecompx11Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Buffer::set(self : Timeseriesdecompx11Buffer, i : Int, v : Double) -> Timeseriesdecompx11Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Buffer::sum(self : Timeseriesdecompx11Buffer) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Buffer::mean(self : Timeseriesdecompx11Buffer) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Buffer::scale(self : Timeseriesdecompx11Buffer, f : Double) -> Timeseriesdecompx11Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Buffer::add(self : Timeseriesdecompx11Buffer, other : Timeseriesdecompx11Buffer) -> Timeseriesdecompx11Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Buffer::copy(self : Timeseriesdecompx11Buffer) -> Timeseriesdecompx11Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Buffer::fill(self : Timeseriesdecompx11Buffer, v : Double) -> Timeseriesdecompx11Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Buffer::min(self : Timeseriesdecompx11Buffer) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Buffer::max(self : Timeseriesdecompx11Buffer) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Buffer::to_string(self : Timeseriesdecompx11Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_cursor_make(size : Int) -> Timeseriesdecompx11Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Cursor::len(self : Timeseriesdecompx11Cursor) -> Int { self.size }

pub fn Timeseriesdecompx11Cursor::get(self : Timeseriesdecompx11Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Cursor::set(self : Timeseriesdecompx11Cursor, i : Int, v : Double) -> Timeseriesdecompx11Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cursor::sum(self : Timeseriesdecompx11Cursor) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Cursor::mean(self : Timeseriesdecompx11Cursor) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Cursor::scale(self : Timeseriesdecompx11Cursor, f : Double) -> Timeseriesdecompx11Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cursor::add(self : Timeseriesdecompx11Cursor, other : Timeseriesdecompx11Cursor) -> Timeseriesdecompx11Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Cursor::copy(self : Timeseriesdecompx11Cursor) -> Timeseriesdecompx11Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cursor::fill(self : Timeseriesdecompx11Cursor, v : Double) -> Timeseriesdecompx11Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Cursor::min(self : Timeseriesdecompx11Cursor) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Cursor::max(self : Timeseriesdecompx11Cursor) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Cursor::to_string(self : Timeseriesdecompx11Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_view_make(size : Int) -> Timeseriesdecompx11View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11View::len(self : Timeseriesdecompx11View) -> Int { self.size }

pub fn Timeseriesdecompx11View::get(self : Timeseriesdecompx11View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11View::set(self : Timeseriesdecompx11View, i : Int, v : Double) -> Timeseriesdecompx11View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11View::sum(self : Timeseriesdecompx11View) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11View::mean(self : Timeseriesdecompx11View) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11View::scale(self : Timeseriesdecompx11View, f : Double) -> Timeseriesdecompx11View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11View::add(self : Timeseriesdecompx11View, other : Timeseriesdecompx11View) -> Timeseriesdecompx11View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11View::copy(self : Timeseriesdecompx11View) -> Timeseriesdecompx11View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11View::fill(self : Timeseriesdecompx11View, v : Double) -> Timeseriesdecompx11View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11View::min(self : Timeseriesdecompx11View) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11View::max(self : Timeseriesdecompx11View) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11View::to_string(self : Timeseriesdecompx11View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_range_make(size : Int) -> Timeseriesdecompx11Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Range::len(self : Timeseriesdecompx11Range) -> Int { self.size }

pub fn Timeseriesdecompx11Range::get(self : Timeseriesdecompx11Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Range::set(self : Timeseriesdecompx11Range, i : Int, v : Double) -> Timeseriesdecompx11Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Range::sum(self : Timeseriesdecompx11Range) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Range::mean(self : Timeseriesdecompx11Range) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Range::scale(self : Timeseriesdecompx11Range, f : Double) -> Timeseriesdecompx11Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Range::add(self : Timeseriesdecompx11Range, other : Timeseriesdecompx11Range) -> Timeseriesdecompx11Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Range::copy(self : Timeseriesdecompx11Range) -> Timeseriesdecompx11Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Range::fill(self : Timeseriesdecompx11Range, v : Double) -> Timeseriesdecompx11Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Range::min(self : Timeseriesdecompx11Range) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Range::max(self : Timeseriesdecompx11Range) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Range::to_string(self : Timeseriesdecompx11Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Timeseriesdecompx11Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_x11_slice_make(size : Int) -> Timeseriesdecompx11Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Timeseriesdecompx11Slice::len(self : Timeseriesdecompx11Slice) -> Int { self.size }

pub fn Timeseriesdecompx11Slice::get(self : Timeseriesdecompx11Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Timeseriesdecompx11Slice::set(self : Timeseriesdecompx11Slice, i : Int, v : Double) -> Timeseriesdecompx11Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Slice::sum(self : Timeseriesdecompx11Slice) -> Double { @_common.sum(self.data) }

pub fn Timeseriesdecompx11Slice::mean(self : Timeseriesdecompx11Slice) -> Double { @_common.mean(self.data) }

pub fn Timeseriesdecompx11Slice::scale(self : Timeseriesdecompx11Slice, f : Double) -> Timeseriesdecompx11Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Slice::add(self : Timeseriesdecompx11Slice, other : Timeseriesdecompx11Slice) -> Timeseriesdecompx11Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Timeseriesdecompx11Slice::copy(self : Timeseriesdecompx11Slice) -> Timeseriesdecompx11Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Slice::fill(self : Timeseriesdecompx11Slice, v : Double) -> Timeseriesdecompx11Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Timeseriesdecompx11Slice::min(self : Timeseriesdecompx11Slice) -> Double { @_common.min(self.data) }

pub fn Timeseriesdecompx11Slice::max(self : Timeseriesdecompx11Slice) -> Double { @_common.max(self.data) }

pub fn Timeseriesdecompx11Slice::to_string(self : Timeseriesdecompx11Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

