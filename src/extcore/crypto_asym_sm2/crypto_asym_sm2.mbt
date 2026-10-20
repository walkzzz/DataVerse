///===
/// extcore/crypto_asym_sm2

pub(all) struct Cryptoasymsm2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_sm2_make_point(x : Double, y : Double) -> Cryptoasymsm2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_sm2_make_point3(x : Double, y : Double, z : Double) -> Cryptoasymsm2Point {
  { x, y, z, label: 0 }
}

pub fn Cryptoasymsm2Point::x(self : Cryptoasymsm2Point) -> Double { self.x }

pub fn Cryptoasymsm2Point::y(self : Cryptoasymsm2Point) -> Double { self.y }

pub fn Cryptoasymsm2Point::z(self : Cryptoasymsm2Point) -> Double { self.z }

pub fn Cryptoasymsm2Point::label(self : Cryptoasymsm2Point) -> Int { self.label }

pub fn Cryptoasymsm2Point::dist(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptoasymsm2Point::add(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptoasymsm2Point::sub(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptoasymsm2Point::scale(self : Cryptoasymsm2Point, s : Double) -> Cryptoasymsm2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptoasymsm2Point::dot(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptoasymsm2Point::cross(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptoasymsm2Point::norm(self : Cryptoasymsm2Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptoasymsm2Point::normalize(self : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptoasymsm2Point::negate(self : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptoasymsm2Point::mid(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point) -> Cryptoasymsm2Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptoasymsm2Point::lerp(self : Cryptoasymsm2Point, other : Cryptoasymsm2Point, t : Double) -> Cryptoasymsm2Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptoasymsm2Point::to_string(self : Cryptoasymsm2Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_sm2_make_series(vals : Array[Double], name : String) -> Cryptoasymsm2Series {
  { vals, name, meta: 0 }
}

pub fn Cryptoasymsm2Series::len(self : Cryptoasymsm2Series) -> Int { self.vals.length() }

pub fn Cryptoasymsm2Series::sum(self : Cryptoasymsm2Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptoasymsm2Series::mean(self : Cryptoasymsm2Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptoasymsm2Series::min(self : Cryptoasymsm2Series) -> Double { @_common.min(self.vals) }

pub fn Cryptoasymsm2Series::max(self : Cryptoasymsm2Series) -> Double { @_common.max(self.vals) }

pub fn Cryptoasymsm2Series::range(self : Cryptoasymsm2Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptoasymsm2Series::variance(self : Cryptoasymsm2Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptoasymsm2Series::std(self : Cryptoasymsm2Series) -> Double { @_common.std(self.vals) }

pub fn Cryptoasymsm2Series::median(self : Cryptoasymsm2Series) -> Double { @_common.median(self.vals) }

pub fn Cryptoasymsm2Series::scale(self : Cryptoasymsm2Series, f : Double) -> Cryptoasymsm2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptoasymsm2Series::add(self : Cryptoasymsm2Series, other : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptoasymsm2Series::sub(self : Cryptoasymsm2Series, other : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptoasymsm2Series::normalize(self : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptoasymsm2Series::cumsum(self : Cryptoasymsm2Series) -> Cryptoasymsm2Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptoasymsm2Series::to_string(self : Cryptoasymsm2Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptoasymsm2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_sm2_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptoasymsm2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_sm2_matrix_identity(n : Int) -> Cryptoasymsm2Matrix {
  let m = crypto_asym_sm2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptoasymsm2Matrix::get(self : Cryptoasymsm2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptoasymsm2Matrix::transpose(self : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  let result = crypto_asym_sm2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptoasymsm2Matrix::add(self : Cryptoasymsm2Matrix, other : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_sm2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptoasymsm2Matrix::scale(self : Cryptoasymsm2Matrix, s : Double) -> Cryptoasymsm2Matrix {
  let result = crypto_asym_sm2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptoasymsm2Matrix::multiply(self : Cryptoasymsm2Matrix, other : Cryptoasymsm2Matrix) -> Cryptoasymsm2Matrix {
  if self.cols != other.rows { return crypto_asym_sm2_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_sm2_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptoasymsm2Matrix::trace(self : Cryptoasymsm2Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptoasymsm2Matrix::det(self : Cryptoasymsm2Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptoasymsm2Matrix::norm(self : Cryptoasymsm2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptoasymsm2Matrix::to_string(self : Cryptoasymsm2Matrix) -> String {
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

pub(all) struct Cryptoasymsm2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_sm2_make_vector(comps : Array[Double]) -> Cryptoasymsm2Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_sm2_vector_zero(dim : Int) -> Cryptoasymsm2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptoasymsm2Vector::add(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptoasymsm2Vector::sub(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptoasymsm2Vector::scale(self : Cryptoasymsm2Vector, s : Double) -> Cryptoasymsm2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptoasymsm2Vector::dot(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptoasymsm2Vector::norm(self : Cryptoasymsm2Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptoasymsm2Vector::normalize(self : Cryptoasymsm2Vector) -> Cryptoasymsm2Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptoasymsm2Vector::dist(self : Cryptoasymsm2Vector, other : Cryptoasymsm2Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptoasymsm2Vector::to_string(self : Cryptoasymsm2Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_sm2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_sm2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_sm2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_sm2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_sm2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_sm2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_sm2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_sm2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_sm2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_sm2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_sm2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_sm2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_sm2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_sm2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_sm2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_sm2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_sm2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_sm2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_sm2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_sm2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_sm2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_sm2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_sm2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_sm2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_sm2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_sm2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_sm2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_sm2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_sm2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptoasymsm2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_frame_make(size : Int) -> Cryptoasymsm2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_frame_len(s : Cryptoasymsm2Frame) -> Int { s.size }

pub fn crypto_asym_sm2_frame_get(s : Cryptoasymsm2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_frame_set(s : Cryptoasymsm2Frame, i : Int, v : Double) -> Cryptoasymsm2Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_frame_sum(s : Cryptoasymsm2Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_frame_mean(s : Cryptoasymsm2Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_frame_scale(s : Cryptoasymsm2Frame, f : Double) -> Cryptoasymsm2Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_frame_add(a : Cryptoasymsm2Frame, b : Cryptoasymsm2Frame) -> Cryptoasymsm2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_frame_copy(s : Cryptoasymsm2Frame) -> Cryptoasymsm2Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_frame_fill(s : Cryptoasymsm2Frame, v : Double) -> Cryptoasymsm2Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_frame_min(s : Cryptoasymsm2Frame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_frame_max(s : Cryptoasymsm2Frame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_frame_to_string(s : Cryptoasymsm2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_table_make(size : Int) -> Cryptoasymsm2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_table_len(s : Cryptoasymsm2Table) -> Int { s.size }

pub fn crypto_asym_sm2_table_get(s : Cryptoasymsm2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_table_set(s : Cryptoasymsm2Table, i : Int, v : Double) -> Cryptoasymsm2Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_table_sum(s : Cryptoasymsm2Table) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_table_mean(s : Cryptoasymsm2Table) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_table_scale(s : Cryptoasymsm2Table, f : Double) -> Cryptoasymsm2Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_table_add(a : Cryptoasymsm2Table, b : Cryptoasymsm2Table) -> Cryptoasymsm2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_table_copy(s : Cryptoasymsm2Table) -> Cryptoasymsm2Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_table_fill(s : Cryptoasymsm2Table, v : Double) -> Cryptoasymsm2Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_table_min(s : Cryptoasymsm2Table) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_table_max(s : Cryptoasymsm2Table) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_table_to_string(s : Cryptoasymsm2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_graphn_make(size : Int) -> Cryptoasymsm2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_graphn_len(s : Cryptoasymsm2GraphN) -> Int { s.size }

pub fn crypto_asym_sm2_graphn_get(s : Cryptoasymsm2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_graphn_set(s : Cryptoasymsm2GraphN, i : Int, v : Double) -> Cryptoasymsm2GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_graphn_sum(s : Cryptoasymsm2GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_graphn_mean(s : Cryptoasymsm2GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_graphn_scale(s : Cryptoasymsm2GraphN, f : Double) -> Cryptoasymsm2GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_graphn_add(a : Cryptoasymsm2GraphN, b : Cryptoasymsm2GraphN) -> Cryptoasymsm2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_graphn_copy(s : Cryptoasymsm2GraphN) -> Cryptoasymsm2GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_graphn_fill(s : Cryptoasymsm2GraphN, v : Double) -> Cryptoasymsm2GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_graphn_min(s : Cryptoasymsm2GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_graphn_max(s : Cryptoasymsm2GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_graphn_to_string(s : Cryptoasymsm2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_node_make(size : Int) -> Cryptoasymsm2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_node_len(s : Cryptoasymsm2Node) -> Int { s.size }

pub fn crypto_asym_sm2_node_get(s : Cryptoasymsm2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_node_set(s : Cryptoasymsm2Node, i : Int, v : Double) -> Cryptoasymsm2Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_node_sum(s : Cryptoasymsm2Node) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_node_mean(s : Cryptoasymsm2Node) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_node_scale(s : Cryptoasymsm2Node, f : Double) -> Cryptoasymsm2Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_node_add(a : Cryptoasymsm2Node, b : Cryptoasymsm2Node) -> Cryptoasymsm2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_node_copy(s : Cryptoasymsm2Node) -> Cryptoasymsm2Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_node_fill(s : Cryptoasymsm2Node, v : Double) -> Cryptoasymsm2Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_node_min(s : Cryptoasymsm2Node) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_node_max(s : Cryptoasymsm2Node) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_node_to_string(s : Cryptoasymsm2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_edge_make(size : Int) -> Cryptoasymsm2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_edge_len(s : Cryptoasymsm2Edge) -> Int { s.size }

pub fn crypto_asym_sm2_edge_get(s : Cryptoasymsm2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_edge_set(s : Cryptoasymsm2Edge, i : Int, v : Double) -> Cryptoasymsm2Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_edge_sum(s : Cryptoasymsm2Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_edge_mean(s : Cryptoasymsm2Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_edge_scale(s : Cryptoasymsm2Edge, f : Double) -> Cryptoasymsm2Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_edge_add(a : Cryptoasymsm2Edge, b : Cryptoasymsm2Edge) -> Cryptoasymsm2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_edge_copy(s : Cryptoasymsm2Edge) -> Cryptoasymsm2Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_edge_fill(s : Cryptoasymsm2Edge, v : Double) -> Cryptoasymsm2Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_edge_min(s : Cryptoasymsm2Edge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_edge_max(s : Cryptoasymsm2Edge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_edge_to_string(s : Cryptoasymsm2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_path_make(size : Int) -> Cryptoasymsm2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_path_len(s : Cryptoasymsm2Path) -> Int { s.size }

pub fn crypto_asym_sm2_path_get(s : Cryptoasymsm2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_path_set(s : Cryptoasymsm2Path, i : Int, v : Double) -> Cryptoasymsm2Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_path_sum(s : Cryptoasymsm2Path) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_path_mean(s : Cryptoasymsm2Path) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_path_scale(s : Cryptoasymsm2Path, f : Double) -> Cryptoasymsm2Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_path_add(a : Cryptoasymsm2Path, b : Cryptoasymsm2Path) -> Cryptoasymsm2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_path_copy(s : Cryptoasymsm2Path) -> Cryptoasymsm2Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_path_fill(s : Cryptoasymsm2Path, v : Double) -> Cryptoasymsm2Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_path_min(s : Cryptoasymsm2Path) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_path_max(s : Cryptoasymsm2Path) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_path_to_string(s : Cryptoasymsm2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_cluster_make(size : Int) -> Cryptoasymsm2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_cluster_len(s : Cryptoasymsm2Cluster) -> Int { s.size }

pub fn crypto_asym_sm2_cluster_get(s : Cryptoasymsm2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_cluster_set(s : Cryptoasymsm2Cluster, i : Int, v : Double) -> Cryptoasymsm2Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cluster_sum(s : Cryptoasymsm2Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_cluster_mean(s : Cryptoasymsm2Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_cluster_scale(s : Cryptoasymsm2Cluster, f : Double) -> Cryptoasymsm2Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cluster_add(a : Cryptoasymsm2Cluster, b : Cryptoasymsm2Cluster) -> Cryptoasymsm2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_cluster_copy(s : Cryptoasymsm2Cluster) -> Cryptoasymsm2Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cluster_fill(s : Cryptoasymsm2Cluster, v : Double) -> Cryptoasymsm2Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cluster_min(s : Cryptoasymsm2Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_cluster_max(s : Cryptoasymsm2Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_cluster_to_string(s : Cryptoasymsm2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_model_make(size : Int) -> Cryptoasymsm2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_model_len(s : Cryptoasymsm2Model) -> Int { s.size }

pub fn crypto_asym_sm2_model_get(s : Cryptoasymsm2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_model_set(s : Cryptoasymsm2Model, i : Int, v : Double) -> Cryptoasymsm2Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_model_sum(s : Cryptoasymsm2Model) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_model_mean(s : Cryptoasymsm2Model) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_model_scale(s : Cryptoasymsm2Model, f : Double) -> Cryptoasymsm2Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_model_add(a : Cryptoasymsm2Model, b : Cryptoasymsm2Model) -> Cryptoasymsm2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_model_copy(s : Cryptoasymsm2Model) -> Cryptoasymsm2Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_model_fill(s : Cryptoasymsm2Model, v : Double) -> Cryptoasymsm2Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_model_min(s : Cryptoasymsm2Model) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_model_max(s : Cryptoasymsm2Model) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_model_to_string(s : Cryptoasymsm2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_layer_make(size : Int) -> Cryptoasymsm2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_layer_len(s : Cryptoasymsm2Layer) -> Int { s.size }

pub fn crypto_asym_sm2_layer_get(s : Cryptoasymsm2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_layer_set(s : Cryptoasymsm2Layer, i : Int, v : Double) -> Cryptoasymsm2Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_layer_sum(s : Cryptoasymsm2Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_layer_mean(s : Cryptoasymsm2Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_layer_scale(s : Cryptoasymsm2Layer, f : Double) -> Cryptoasymsm2Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_layer_add(a : Cryptoasymsm2Layer, b : Cryptoasymsm2Layer) -> Cryptoasymsm2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_layer_copy(s : Cryptoasymsm2Layer) -> Cryptoasymsm2Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_layer_fill(s : Cryptoasymsm2Layer, v : Double) -> Cryptoasymsm2Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_layer_min(s : Cryptoasymsm2Layer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_layer_max(s : Cryptoasymsm2Layer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_layer_to_string(s : Cryptoasymsm2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_buffer_make(size : Int) -> Cryptoasymsm2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_buffer_len(s : Cryptoasymsm2Buffer) -> Int { s.size }

pub fn crypto_asym_sm2_buffer_get(s : Cryptoasymsm2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_buffer_set(s : Cryptoasymsm2Buffer, i : Int, v : Double) -> Cryptoasymsm2Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_buffer_sum(s : Cryptoasymsm2Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_buffer_mean(s : Cryptoasymsm2Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_buffer_scale(s : Cryptoasymsm2Buffer, f : Double) -> Cryptoasymsm2Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_buffer_add(a : Cryptoasymsm2Buffer, b : Cryptoasymsm2Buffer) -> Cryptoasymsm2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_buffer_copy(s : Cryptoasymsm2Buffer) -> Cryptoasymsm2Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_buffer_fill(s : Cryptoasymsm2Buffer, v : Double) -> Cryptoasymsm2Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_buffer_min(s : Cryptoasymsm2Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_buffer_max(s : Cryptoasymsm2Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_buffer_to_string(s : Cryptoasymsm2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_cursor_make(size : Int) -> Cryptoasymsm2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_cursor_len(s : Cryptoasymsm2Cursor) -> Int { s.size }

pub fn crypto_asym_sm2_cursor_get(s : Cryptoasymsm2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_cursor_set(s : Cryptoasymsm2Cursor, i : Int, v : Double) -> Cryptoasymsm2Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cursor_sum(s : Cryptoasymsm2Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_cursor_mean(s : Cryptoasymsm2Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_cursor_scale(s : Cryptoasymsm2Cursor, f : Double) -> Cryptoasymsm2Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cursor_add(a : Cryptoasymsm2Cursor, b : Cryptoasymsm2Cursor) -> Cryptoasymsm2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_cursor_copy(s : Cryptoasymsm2Cursor) -> Cryptoasymsm2Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cursor_fill(s : Cryptoasymsm2Cursor, v : Double) -> Cryptoasymsm2Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_cursor_min(s : Cryptoasymsm2Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_cursor_max(s : Cryptoasymsm2Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_cursor_to_string(s : Cryptoasymsm2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_view_make(size : Int) -> Cryptoasymsm2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_view_len(s : Cryptoasymsm2View) -> Int { s.size }

pub fn crypto_asym_sm2_view_get(s : Cryptoasymsm2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_view_set(s : Cryptoasymsm2View, i : Int, v : Double) -> Cryptoasymsm2View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_view_sum(s : Cryptoasymsm2View) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_view_mean(s : Cryptoasymsm2View) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_view_scale(s : Cryptoasymsm2View, f : Double) -> Cryptoasymsm2View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_view_add(a : Cryptoasymsm2View, b : Cryptoasymsm2View) -> Cryptoasymsm2View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_view_copy(s : Cryptoasymsm2View) -> Cryptoasymsm2View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_view_fill(s : Cryptoasymsm2View, v : Double) -> Cryptoasymsm2View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_view_min(s : Cryptoasymsm2View) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_view_max(s : Cryptoasymsm2View) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_view_to_string(s : Cryptoasymsm2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_range_make(size : Int) -> Cryptoasymsm2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_range_len(s : Cryptoasymsm2Range) -> Int { s.size }

pub fn crypto_asym_sm2_range_get(s : Cryptoasymsm2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_range_set(s : Cryptoasymsm2Range, i : Int, v : Double) -> Cryptoasymsm2Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_range_sum(s : Cryptoasymsm2Range) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_range_mean(s : Cryptoasymsm2Range) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_range_scale(s : Cryptoasymsm2Range, f : Double) -> Cryptoasymsm2Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_range_add(a : Cryptoasymsm2Range, b : Cryptoasymsm2Range) -> Cryptoasymsm2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_range_copy(s : Cryptoasymsm2Range) -> Cryptoasymsm2Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_range_fill(s : Cryptoasymsm2Range, v : Double) -> Cryptoasymsm2Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_range_min(s : Cryptoasymsm2Range) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_range_max(s : Cryptoasymsm2Range) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_range_to_string(s : Cryptoasymsm2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptoasymsm2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_sm2_slice_make(size : Int) -> Cryptoasymsm2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_sm2_slice_len(s : Cryptoasymsm2Slice) -> Int { s.size }

pub fn crypto_asym_sm2_slice_get(s : Cryptoasymsm2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_sm2_slice_set(s : Cryptoasymsm2Slice, i : Int, v : Double) -> Cryptoasymsm2Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_slice_sum(s : Cryptoasymsm2Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_sm2_slice_mean(s : Cryptoasymsm2Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_sm2_slice_scale(s : Cryptoasymsm2Slice, f : Double) -> Cryptoasymsm2Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_slice_add(a : Cryptoasymsm2Slice, b : Cryptoasymsm2Slice) -> Cryptoasymsm2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_sm2_slice_copy(s : Cryptoasymsm2Slice) -> Cryptoasymsm2Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_slice_fill(s : Cryptoasymsm2Slice, v : Double) -> Cryptoasymsm2Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_sm2_slice_min(s : Cryptoasymsm2Slice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_sm2_slice_max(s : Cryptoasymsm2Slice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_sm2_slice_to_string(s : Cryptoasymsm2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

