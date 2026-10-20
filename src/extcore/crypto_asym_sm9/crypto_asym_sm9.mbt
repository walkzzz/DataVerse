///===
/// extcore/crypto_asym_sm9

pub(all) struct Cryptoasymsm9Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_sm9_make_point(x : Double, y : Double) -> Cryptoasymsm9Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_sm9_make_point3(x : Double, y : Double, z : Double) -> Cryptoasymsm9Point {
  { x, y, z, label: 0 }
}

pub fn Cryptoasymsm9Point::x(self : Cryptoasymsm9Point) -> Double { self.x }

pub fn Cryptoasymsm9Point::y(self : Cryptoasymsm9Point) -> Double { self.y }

pub fn Cryptoasymsm9Point::z(self : Cryptoasymsm9Point) -> Double { self.z }

pub fn Cryptoasymsm9Point::label(self : Cryptoasymsm9Point) -> Int { self.label }

pub fn Cryptoasymsm9Point::dist(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptoasymsm9Point::add(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptoasymsm9Point::sub(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptoasymsm9Point::scale(self : Cryptoasymsm9Point, s : Double) -> Cryptoasymsm9Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptoasymsm9Point::dot(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptoasymsm9Point::cross(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptoasymsm9Point::norm(self : Cryptoasymsm9Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptoasymsm9Point::normalize(self : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptoasymsm9Point::negate(self : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptoasymsm9Point::mid(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point) -> Cryptoasymsm9Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptoasymsm9Point::lerp(self : Cryptoasymsm9Point, other : Cryptoasymsm9Point, t : Double) -> Cryptoasymsm9Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptoasymsm9Point::to_string(self : Cryptoasymsm9Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_sm9_make_series(vals : Array[Double], name : String) -> Cryptoasymsm9Series {
  { vals, name, meta: 0 }
}

pub fn Cryptoasymsm9Series::len(self : Cryptoasymsm9Series) -> Int { self.vals.length() }

pub fn Cryptoasymsm9Series::sum(self : Cryptoasymsm9Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptoasymsm9Series::mean(self : Cryptoasymsm9Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptoasymsm9Series::min(self : Cryptoasymsm9Series) -> Double { @_common.min(self.vals) }

pub fn Cryptoasymsm9Series::max(self : Cryptoasymsm9Series) -> Double { @_common.max(self.vals) }

pub fn Cryptoasymsm9Series::range(self : Cryptoasymsm9Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptoasymsm9Series::variance(self : Cryptoasymsm9Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptoasymsm9Series::std(self : Cryptoasymsm9Series) -> Double { @_common.std(self.vals) }

pub fn Cryptoasymsm9Series::median(self : Cryptoasymsm9Series) -> Double { @_common.median(self.vals) }

pub fn Cryptoasymsm9Series::scale(self : Cryptoasymsm9Series, f : Double) -> Cryptoasymsm9Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptoasymsm9Series::add(self : Cryptoasymsm9Series, other : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptoasymsm9Series::sub(self : Cryptoasymsm9Series, other : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptoasymsm9Series::normalize(self : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptoasymsm9Series::cumsum(self : Cryptoasymsm9Series) -> Cryptoasymsm9Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptoasymsm9Series::to_string(self : Cryptoasymsm9Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptoasymsm9Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_sm9_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptoasymsm9Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_sm9_matrix_identity(n : Int) -> Cryptoasymsm9Matrix {
  let m = crypto_asym_sm9_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptoasymsm9Matrix::get(self : Cryptoasymsm9Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptoasymsm9Matrix::transpose(self : Cryptoasymsm9Matrix) -> Cryptoasymsm9Matrix {
  let result = crypto_asym_sm9_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptoasymsm9Matrix::add(self : Cryptoasymsm9Matrix, other : Cryptoasymsm9Matrix) -> Cryptoasymsm9Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_sm9_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptoasymsm9Matrix::scale(self : Cryptoasymsm9Matrix, s : Double) -> Cryptoasymsm9Matrix {
  let result = crypto_asym_sm9_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptoasymsm9Matrix::multiply(self : Cryptoasymsm9Matrix, other : Cryptoasymsm9Matrix) -> Cryptoasymsm9Matrix {
  if self.cols != other.rows { return crypto_asym_sm9_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_sm9_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptoasymsm9Matrix::trace(self : Cryptoasymsm9Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptoasymsm9Matrix::det(self : Cryptoasymsm9Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptoasymsm9Matrix::norm(self : Cryptoasymsm9Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptoasymsm9Matrix::to_string(self : Cryptoasymsm9Matrix) -> String {
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

pub(all) struct Cryptoasymsm9Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_sm9_make_vector(comps : Array[Double]) -> Cryptoasymsm9Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_sm9_vector_zero(dim : Int) -> Cryptoasymsm9Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptoasymsm9Vector::add(self : Cryptoasymsm9Vector, other : Cryptoasymsm9Vector) -> Cryptoasymsm9Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptoasymsm9Vector::sub(self : Cryptoasymsm9Vector, other : Cryptoasymsm9Vector) -> Cryptoasymsm9Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptoasymsm9Vector::scale(self : Cryptoasymsm9Vector, s : Double) -> Cryptoasymsm9Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptoasymsm9Vector::dot(self : Cryptoasymsm9Vector, other : Cryptoasymsm9Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptoasymsm9Vector::norm(self : Cryptoasymsm9Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptoasymsm9Vector::normalize(self : Cryptoasymsm9Vector) -> Cryptoasymsm9Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptoasymsm9Vector::dist(self : Cryptoasymsm9Vector, other : Cryptoasymsm9Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptoasymsm9Vector::to_string(self : Cryptoasymsm9Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_sm9_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_sm9_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_sm9_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_sm9_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_sm9_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_sm9_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_sm9_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_sm9_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_sm9_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_sm9_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_sm9_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_sm9_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_sm9_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_sm9_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_sm9_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_sm9_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_sm9_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_sm9_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_sm9_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_sm9_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_sm9_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_sm9_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_sm9_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_sm9_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_sm9_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_sm9_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_sm9_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_sm9_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_sm9_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptoasymsm9Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_frame_make(size : Int) -> Cryptoasymsm9Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_frame_len(s : Cryptoasymsm9Frame) -> Int { s.size }

pub fn crypto_asym_sm9_frame_get(s : Cryptoasymsm9Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_frame_set(s : Cryptoasymsm9Frame, i : Int, v : Double) -> Cryptoasymsm9Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_sum(s : Cryptoasymsm9Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_frame_mean(s : Cryptoasymsm9Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_frame_scale(s : Cryptoasymsm9Frame, f : Double) -> Cryptoasymsm9Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_add(a : Cryptoasymsm9Frame, b : Cryptoasymsm9Frame) -> Cryptoasymsm9Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_frame_copy(s : Cryptoasymsm9Frame) -> Cryptoasymsm9Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_fill(s : Cryptoasymsm9Frame, v : Double) -> Cryptoasymsm9Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_frame_min(s : Cryptoasymsm9Frame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_frame_max(s : Cryptoasymsm9Frame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_frame_to_string(s : Cryptoasymsm9Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_table_make(size : Int) -> Cryptoasymsm9Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_table_len(s : Cryptoasymsm9Table) -> Int { s.size }

pub fn crypto_asym_sm9_table_get(s : Cryptoasymsm9Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_table_set(s : Cryptoasymsm9Table, i : Int, v : Double) -> Cryptoasymsm9Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_sum(s : Cryptoasymsm9Table) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_table_mean(s : Cryptoasymsm9Table) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_table_scale(s : Cryptoasymsm9Table, f : Double) -> Cryptoasymsm9Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_add(a : Cryptoasymsm9Table, b : Cryptoasymsm9Table) -> Cryptoasymsm9Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_table_copy(s : Cryptoasymsm9Table) -> Cryptoasymsm9Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_fill(s : Cryptoasymsm9Table, v : Double) -> Cryptoasymsm9Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_table_min(s : Cryptoasymsm9Table) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_table_max(s : Cryptoasymsm9Table) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_table_to_string(s : Cryptoasymsm9Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_graphn_make(size : Int) -> Cryptoasymsm9GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_graphn_len(s : Cryptoasymsm9GraphN) -> Int { s.size }

pub fn crypto_asym_sm9_graphn_get(s : Cryptoasymsm9GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_graphn_set(s : Cryptoasymsm9GraphN, i : Int, v : Double) -> Cryptoasymsm9GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_sum(s : Cryptoasymsm9GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_graphn_mean(s : Cryptoasymsm9GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_graphn_scale(s : Cryptoasymsm9GraphN, f : Double) -> Cryptoasymsm9GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_add(a : Cryptoasymsm9GraphN, b : Cryptoasymsm9GraphN) -> Cryptoasymsm9GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_graphn_copy(s : Cryptoasymsm9GraphN) -> Cryptoasymsm9GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_fill(s : Cryptoasymsm9GraphN, v : Double) -> Cryptoasymsm9GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_graphn_min(s : Cryptoasymsm9GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_graphn_max(s : Cryptoasymsm9GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_graphn_to_string(s : Cryptoasymsm9GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_node_make(size : Int) -> Cryptoasymsm9Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_node_len(s : Cryptoasymsm9Node) -> Int { s.size }

pub fn crypto_asym_sm9_node_get(s : Cryptoasymsm9Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_node_set(s : Cryptoasymsm9Node, i : Int, v : Double) -> Cryptoasymsm9Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_sum(s : Cryptoasymsm9Node) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_node_mean(s : Cryptoasymsm9Node) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_node_scale(s : Cryptoasymsm9Node, f : Double) -> Cryptoasymsm9Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_add(a : Cryptoasymsm9Node, b : Cryptoasymsm9Node) -> Cryptoasymsm9Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_node_copy(s : Cryptoasymsm9Node) -> Cryptoasymsm9Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_fill(s : Cryptoasymsm9Node, v : Double) -> Cryptoasymsm9Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_node_min(s : Cryptoasymsm9Node) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_node_max(s : Cryptoasymsm9Node) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_node_to_string(s : Cryptoasymsm9Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_edge_make(size : Int) -> Cryptoasymsm9Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_edge_len(s : Cryptoasymsm9Edge) -> Int { s.size }

pub fn crypto_asym_sm9_edge_get(s : Cryptoasymsm9Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_edge_set(s : Cryptoasymsm9Edge, i : Int, v : Double) -> Cryptoasymsm9Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_sum(s : Cryptoasymsm9Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_edge_mean(s : Cryptoasymsm9Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_edge_scale(s : Cryptoasymsm9Edge, f : Double) -> Cryptoasymsm9Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_add(a : Cryptoasymsm9Edge, b : Cryptoasymsm9Edge) -> Cryptoasymsm9Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_edge_copy(s : Cryptoasymsm9Edge) -> Cryptoasymsm9Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_fill(s : Cryptoasymsm9Edge, v : Double) -> Cryptoasymsm9Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_edge_min(s : Cryptoasymsm9Edge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_edge_max(s : Cryptoasymsm9Edge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_edge_to_string(s : Cryptoasymsm9Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_path_make(size : Int) -> Cryptoasymsm9Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_path_len(s : Cryptoasymsm9Path) -> Int { s.size }

pub fn crypto_asym_sm9_path_get(s : Cryptoasymsm9Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_path_set(s : Cryptoasymsm9Path, i : Int, v : Double) -> Cryptoasymsm9Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_sum(s : Cryptoasymsm9Path) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_path_mean(s : Cryptoasymsm9Path) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_path_scale(s : Cryptoasymsm9Path, f : Double) -> Cryptoasymsm9Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_add(a : Cryptoasymsm9Path, b : Cryptoasymsm9Path) -> Cryptoasymsm9Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_path_copy(s : Cryptoasymsm9Path) -> Cryptoasymsm9Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_fill(s : Cryptoasymsm9Path, v : Double) -> Cryptoasymsm9Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_path_min(s : Cryptoasymsm9Path) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_path_max(s : Cryptoasymsm9Path) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_path_to_string(s : Cryptoasymsm9Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_cluster_make(size : Int) -> Cryptoasymsm9Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_cluster_len(s : Cryptoasymsm9Cluster) -> Int { s.size }

pub fn crypto_asym_sm9_cluster_get(s : Cryptoasymsm9Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_cluster_set(s : Cryptoasymsm9Cluster, i : Int, v : Double) -> Cryptoasymsm9Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_sum(s : Cryptoasymsm9Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_cluster_mean(s : Cryptoasymsm9Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_cluster_scale(s : Cryptoasymsm9Cluster, f : Double) -> Cryptoasymsm9Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_add(a : Cryptoasymsm9Cluster, b : Cryptoasymsm9Cluster) -> Cryptoasymsm9Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_cluster_copy(s : Cryptoasymsm9Cluster) -> Cryptoasymsm9Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_fill(s : Cryptoasymsm9Cluster, v : Double) -> Cryptoasymsm9Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cluster_min(s : Cryptoasymsm9Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_cluster_max(s : Cryptoasymsm9Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_cluster_to_string(s : Cryptoasymsm9Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_model_make(size : Int) -> Cryptoasymsm9Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_model_len(s : Cryptoasymsm9Model) -> Int { s.size }

pub fn crypto_asym_sm9_model_get(s : Cryptoasymsm9Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_model_set(s : Cryptoasymsm9Model, i : Int, v : Double) -> Cryptoasymsm9Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_sum(s : Cryptoasymsm9Model) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_model_mean(s : Cryptoasymsm9Model) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_model_scale(s : Cryptoasymsm9Model, f : Double) -> Cryptoasymsm9Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_add(a : Cryptoasymsm9Model, b : Cryptoasymsm9Model) -> Cryptoasymsm9Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_model_copy(s : Cryptoasymsm9Model) -> Cryptoasymsm9Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_fill(s : Cryptoasymsm9Model, v : Double) -> Cryptoasymsm9Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_model_min(s : Cryptoasymsm9Model) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_model_max(s : Cryptoasymsm9Model) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_model_to_string(s : Cryptoasymsm9Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_layer_make(size : Int) -> Cryptoasymsm9Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_layer_len(s : Cryptoasymsm9Layer) -> Int { s.size }

pub fn crypto_asym_sm9_layer_get(s : Cryptoasymsm9Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_layer_set(s : Cryptoasymsm9Layer, i : Int, v : Double) -> Cryptoasymsm9Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_sum(s : Cryptoasymsm9Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_layer_mean(s : Cryptoasymsm9Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_layer_scale(s : Cryptoasymsm9Layer, f : Double) -> Cryptoasymsm9Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_add(a : Cryptoasymsm9Layer, b : Cryptoasymsm9Layer) -> Cryptoasymsm9Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_layer_copy(s : Cryptoasymsm9Layer) -> Cryptoasymsm9Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_fill(s : Cryptoasymsm9Layer, v : Double) -> Cryptoasymsm9Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_layer_min(s : Cryptoasymsm9Layer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_layer_max(s : Cryptoasymsm9Layer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_layer_to_string(s : Cryptoasymsm9Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_buffer_make(size : Int) -> Cryptoasymsm9Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_buffer_len(s : Cryptoasymsm9Buffer) -> Int { s.size }

pub fn crypto_asym_sm9_buffer_get(s : Cryptoasymsm9Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_buffer_set(s : Cryptoasymsm9Buffer, i : Int, v : Double) -> Cryptoasymsm9Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_sum(s : Cryptoasymsm9Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_buffer_mean(s : Cryptoasymsm9Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_buffer_scale(s : Cryptoasymsm9Buffer, f : Double) -> Cryptoasymsm9Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_add(a : Cryptoasymsm9Buffer, b : Cryptoasymsm9Buffer) -> Cryptoasymsm9Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_buffer_copy(s : Cryptoasymsm9Buffer) -> Cryptoasymsm9Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_fill(s : Cryptoasymsm9Buffer, v : Double) -> Cryptoasymsm9Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_buffer_min(s : Cryptoasymsm9Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_buffer_max(s : Cryptoasymsm9Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_buffer_to_string(s : Cryptoasymsm9Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_cursor_make(size : Int) -> Cryptoasymsm9Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_cursor_len(s : Cryptoasymsm9Cursor) -> Int { s.size }

pub fn crypto_asym_sm9_cursor_get(s : Cryptoasymsm9Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_cursor_set(s : Cryptoasymsm9Cursor, i : Int, v : Double) -> Cryptoasymsm9Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_sum(s : Cryptoasymsm9Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_cursor_mean(s : Cryptoasymsm9Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_cursor_scale(s : Cryptoasymsm9Cursor, f : Double) -> Cryptoasymsm9Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_add(a : Cryptoasymsm9Cursor, b : Cryptoasymsm9Cursor) -> Cryptoasymsm9Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_cursor_copy(s : Cryptoasymsm9Cursor) -> Cryptoasymsm9Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_fill(s : Cryptoasymsm9Cursor, v : Double) -> Cryptoasymsm9Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_cursor_min(s : Cryptoasymsm9Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_cursor_max(s : Cryptoasymsm9Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_cursor_to_string(s : Cryptoasymsm9Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_view_make(size : Int) -> Cryptoasymsm9View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_view_len(s : Cryptoasymsm9View) -> Int { s.size }

pub fn crypto_asym_sm9_view_get(s : Cryptoasymsm9View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_view_set(s : Cryptoasymsm9View, i : Int, v : Double) -> Cryptoasymsm9View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_sum(s : Cryptoasymsm9View) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_view_mean(s : Cryptoasymsm9View) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_view_scale(s : Cryptoasymsm9View, f : Double) -> Cryptoasymsm9View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_add(a : Cryptoasymsm9View, b : Cryptoasymsm9View) -> Cryptoasymsm9View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_view_copy(s : Cryptoasymsm9View) -> Cryptoasymsm9View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_fill(s : Cryptoasymsm9View, v : Double) -> Cryptoasymsm9View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_view_min(s : Cryptoasymsm9View) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_view_max(s : Cryptoasymsm9View) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_view_to_string(s : Cryptoasymsm9View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_range_make(size : Int) -> Cryptoasymsm9Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_range_len(s : Cryptoasymsm9Range) -> Int { s.size }

pub fn crypto_asym_sm9_range_get(s : Cryptoasymsm9Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_range_set(s : Cryptoasymsm9Range, i : Int, v : Double) -> Cryptoasymsm9Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_sum(s : Cryptoasymsm9Range) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_range_mean(s : Cryptoasymsm9Range) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_range_scale(s : Cryptoasymsm9Range, f : Double) -> Cryptoasymsm9Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_add(a : Cryptoasymsm9Range, b : Cryptoasymsm9Range) -> Cryptoasymsm9Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_range_copy(s : Cryptoasymsm9Range) -> Cryptoasymsm9Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_fill(s : Cryptoasymsm9Range, v : Double) -> Cryptoasymsm9Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_range_min(s : Cryptoasymsm9Range) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_range_max(s : Cryptoasymsm9Range) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_range_to_string(s : Cryptoasymsm9Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm9Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm9_slice_make(size : Int) -> Cryptoasymsm9Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm9_slice_len(s : Cryptoasymsm9Slice) -> Int { s.size }

pub fn crypto_asym_sm9_slice_get(s : Cryptoasymsm9Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm9_slice_set(s : Cryptoasymsm9Slice, i : Int, v : Double) -> Cryptoasymsm9Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_sum(s : Cryptoasymsm9Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm9_slice_mean(s : Cryptoasymsm9Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm9_slice_scale(s : Cryptoasymsm9Slice, f : Double) -> Cryptoasymsm9Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_add(a : Cryptoasymsm9Slice, b : Cryptoasymsm9Slice) -> Cryptoasymsm9Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm9_slice_copy(s : Cryptoasymsm9Slice) -> Cryptoasymsm9Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_fill(s : Cryptoasymsm9Slice, v : Double) -> Cryptoasymsm9Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm9_slice_min(s : Cryptoasymsm9Slice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm9_slice_max(s : Cryptoasymsm9Slice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm9_slice_to_string(s : Cryptoasymsm9Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

