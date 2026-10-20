///===
/// extcore/crypto_hash_blake2

pub(all) struct Cryptohashblake2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_blake2_make_point(x : Double, y : Double) -> Cryptohashblake2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_blake2_make_point3(x : Double, y : Double, z : Double) -> Cryptohashblake2Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashblake2Point::x(self : Cryptohashblake2Point) -> Double { self.x }

pub fn Cryptohashblake2Point::y(self : Cryptohashblake2Point) -> Double { self.y }

pub fn Cryptohashblake2Point::z(self : Cryptohashblake2Point) -> Double { self.z }

pub fn Cryptohashblake2Point::label(self : Cryptohashblake2Point) -> Int { self.label }

pub fn Cryptohashblake2Point::dist(self : Cryptohashblake2Point, other : Cryptohashblake2Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashblake2Point::add(self : Cryptohashblake2Point, other : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashblake2Point::sub(self : Cryptohashblake2Point, other : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashblake2Point::scale(self : Cryptohashblake2Point, s : Double) -> Cryptohashblake2Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashblake2Point::dot(self : Cryptohashblake2Point, other : Cryptohashblake2Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashblake2Point::cross(self : Cryptohashblake2Point, other : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashblake2Point::norm(self : Cryptohashblake2Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashblake2Point::normalize(self : Cryptohashblake2Point) -> Cryptohashblake2Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashblake2Point::negate(self : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashblake2Point::mid(self : Cryptohashblake2Point, other : Cryptohashblake2Point) -> Cryptohashblake2Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashblake2Point::lerp(self : Cryptohashblake2Point, other : Cryptohashblake2Point, t : Double) -> Cryptohashblake2Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashblake2Point::to_string(self : Cryptohashblake2Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashblake2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_blake2_make_series(vals : Array[Double], name : String) -> Cryptohashblake2Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashblake2Series::len(self : Cryptohashblake2Series) -> Int { self.vals.length() }

pub fn Cryptohashblake2Series::sum(self : Cryptohashblake2Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashblake2Series::mean(self : Cryptohashblake2Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashblake2Series::min(self : Cryptohashblake2Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashblake2Series::max(self : Cryptohashblake2Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashblake2Series::range(self : Cryptohashblake2Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashblake2Series::variance(self : Cryptohashblake2Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashblake2Series::std(self : Cryptohashblake2Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashblake2Series::median(self : Cryptohashblake2Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashblake2Series::scale(self : Cryptohashblake2Series, f : Double) -> Cryptohashblake2Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashblake2Series::add(self : Cryptohashblake2Series, other : Cryptohashblake2Series) -> Cryptohashblake2Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashblake2Series::sub(self : Cryptohashblake2Series, other : Cryptohashblake2Series) -> Cryptohashblake2Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashblake2Series::normalize(self : Cryptohashblake2Series) -> Cryptohashblake2Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashblake2Series::cumsum(self : Cryptohashblake2Series) -> Cryptohashblake2Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashblake2Series::to_string(self : Cryptohashblake2Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashblake2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_blake2_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashblake2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_blake2_matrix_identity(n : Int) -> Cryptohashblake2Matrix {
  let m = crypto_hash_blake2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashblake2Matrix::get(self : Cryptohashblake2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashblake2Matrix::transpose(self : Cryptohashblake2Matrix) -> Cryptohashblake2Matrix {
  let result = crypto_hash_blake2_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashblake2Matrix::add(self : Cryptohashblake2Matrix, other : Cryptohashblake2Matrix) -> Cryptohashblake2Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_blake2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashblake2Matrix::scale(self : Cryptohashblake2Matrix, s : Double) -> Cryptohashblake2Matrix {
  let result = crypto_hash_blake2_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashblake2Matrix::multiply(self : Cryptohashblake2Matrix, other : Cryptohashblake2Matrix) -> Cryptohashblake2Matrix {
  if self.cols != other.rows { return crypto_hash_blake2_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_blake2_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashblake2Matrix::trace(self : Cryptohashblake2Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashblake2Matrix::det(self : Cryptohashblake2Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashblake2Matrix::norm(self : Cryptohashblake2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashblake2Matrix::to_string(self : Cryptohashblake2Matrix) -> String {
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

pub(all) struct Cryptohashblake2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_blake2_make_vector(comps : Array[Double]) -> Cryptohashblake2Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_blake2_vector_zero(dim : Int) -> Cryptohashblake2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashblake2Vector::add(self : Cryptohashblake2Vector, other : Cryptohashblake2Vector) -> Cryptohashblake2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashblake2Vector::sub(self : Cryptohashblake2Vector, other : Cryptohashblake2Vector) -> Cryptohashblake2Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashblake2Vector::scale(self : Cryptohashblake2Vector, s : Double) -> Cryptohashblake2Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashblake2Vector::dot(self : Cryptohashblake2Vector, other : Cryptohashblake2Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashblake2Vector::norm(self : Cryptohashblake2Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashblake2Vector::normalize(self : Cryptohashblake2Vector) -> Cryptohashblake2Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashblake2Vector::dist(self : Cryptohashblake2Vector, other : Cryptohashblake2Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashblake2Vector::to_string(self : Cryptohashblake2Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_blake2_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_blake2_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_blake2_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_blake2_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_blake2_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_blake2_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_blake2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_blake2_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_blake2_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_blake2_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_blake2_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_blake2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_blake2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_blake2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_blake2_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_blake2_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_blake2_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_blake2_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_blake2_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_blake2_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_blake2_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_blake2_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_blake2_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_blake2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_blake2_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_blake2_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_blake2_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_blake2_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_blake2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashblake2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_frame_make(size : Int) -> Cryptohashblake2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_frame_len(s : Cryptohashblake2Frame) -> Int { s.size }

pub fn crypto_hash_blake2_frame_get(s : Cryptohashblake2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_frame_set(s : Cryptohashblake2Frame, i : Int, v : Double) -> Cryptohashblake2Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_sum(s : Cryptohashblake2Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_frame_mean(s : Cryptohashblake2Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_frame_scale(s : Cryptohashblake2Frame, f : Double) -> Cryptohashblake2Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_add(a : Cryptohashblake2Frame, b : Cryptohashblake2Frame) -> Cryptohashblake2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_frame_copy(s : Cryptohashblake2Frame) -> Cryptohashblake2Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_fill(s : Cryptohashblake2Frame, v : Double) -> Cryptohashblake2Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_frame_min(s : Cryptohashblake2Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_frame_max(s : Cryptohashblake2Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_frame_to_string(s : Cryptohashblake2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_table_make(size : Int) -> Cryptohashblake2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_table_len(s : Cryptohashblake2Table) -> Int { s.size }

pub fn crypto_hash_blake2_table_get(s : Cryptohashblake2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_table_set(s : Cryptohashblake2Table, i : Int, v : Double) -> Cryptohashblake2Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_sum(s : Cryptohashblake2Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_table_mean(s : Cryptohashblake2Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_table_scale(s : Cryptohashblake2Table, f : Double) -> Cryptohashblake2Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_add(a : Cryptohashblake2Table, b : Cryptohashblake2Table) -> Cryptohashblake2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_table_copy(s : Cryptohashblake2Table) -> Cryptohashblake2Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_fill(s : Cryptohashblake2Table, v : Double) -> Cryptohashblake2Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_table_min(s : Cryptohashblake2Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_table_max(s : Cryptohashblake2Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_table_to_string(s : Cryptohashblake2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_graphn_make(size : Int) -> Cryptohashblake2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_graphn_len(s : Cryptohashblake2GraphN) -> Int { s.size }

pub fn crypto_hash_blake2_graphn_get(s : Cryptohashblake2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_graphn_set(s : Cryptohashblake2GraphN, i : Int, v : Double) -> Cryptohashblake2GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_sum(s : Cryptohashblake2GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_graphn_mean(s : Cryptohashblake2GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_graphn_scale(s : Cryptohashblake2GraphN, f : Double) -> Cryptohashblake2GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_add(a : Cryptohashblake2GraphN, b : Cryptohashblake2GraphN) -> Cryptohashblake2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_graphn_copy(s : Cryptohashblake2GraphN) -> Cryptohashblake2GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_fill(s : Cryptohashblake2GraphN, v : Double) -> Cryptohashblake2GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_graphn_min(s : Cryptohashblake2GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_graphn_max(s : Cryptohashblake2GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_graphn_to_string(s : Cryptohashblake2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_node_make(size : Int) -> Cryptohashblake2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_node_len(s : Cryptohashblake2Node) -> Int { s.size }

pub fn crypto_hash_blake2_node_get(s : Cryptohashblake2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_node_set(s : Cryptohashblake2Node, i : Int, v : Double) -> Cryptohashblake2Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_sum(s : Cryptohashblake2Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_node_mean(s : Cryptohashblake2Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_node_scale(s : Cryptohashblake2Node, f : Double) -> Cryptohashblake2Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_add(a : Cryptohashblake2Node, b : Cryptohashblake2Node) -> Cryptohashblake2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_node_copy(s : Cryptohashblake2Node) -> Cryptohashblake2Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_fill(s : Cryptohashblake2Node, v : Double) -> Cryptohashblake2Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_node_min(s : Cryptohashblake2Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_node_max(s : Cryptohashblake2Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_node_to_string(s : Cryptohashblake2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_edge_make(size : Int) -> Cryptohashblake2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_edge_len(s : Cryptohashblake2Edge) -> Int { s.size }

pub fn crypto_hash_blake2_edge_get(s : Cryptohashblake2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_edge_set(s : Cryptohashblake2Edge, i : Int, v : Double) -> Cryptohashblake2Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_sum(s : Cryptohashblake2Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_edge_mean(s : Cryptohashblake2Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_edge_scale(s : Cryptohashblake2Edge, f : Double) -> Cryptohashblake2Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_add(a : Cryptohashblake2Edge, b : Cryptohashblake2Edge) -> Cryptohashblake2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_edge_copy(s : Cryptohashblake2Edge) -> Cryptohashblake2Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_fill(s : Cryptohashblake2Edge, v : Double) -> Cryptohashblake2Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_edge_min(s : Cryptohashblake2Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_edge_max(s : Cryptohashblake2Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_edge_to_string(s : Cryptohashblake2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_path_make(size : Int) -> Cryptohashblake2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_path_len(s : Cryptohashblake2Path) -> Int { s.size }

pub fn crypto_hash_blake2_path_get(s : Cryptohashblake2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_path_set(s : Cryptohashblake2Path, i : Int, v : Double) -> Cryptohashblake2Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_sum(s : Cryptohashblake2Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_path_mean(s : Cryptohashblake2Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_path_scale(s : Cryptohashblake2Path, f : Double) -> Cryptohashblake2Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_add(a : Cryptohashblake2Path, b : Cryptohashblake2Path) -> Cryptohashblake2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_path_copy(s : Cryptohashblake2Path) -> Cryptohashblake2Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_fill(s : Cryptohashblake2Path, v : Double) -> Cryptohashblake2Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_path_min(s : Cryptohashblake2Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_path_max(s : Cryptohashblake2Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_path_to_string(s : Cryptohashblake2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_cluster_make(size : Int) -> Cryptohashblake2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_cluster_len(s : Cryptohashblake2Cluster) -> Int { s.size }

pub fn crypto_hash_blake2_cluster_get(s : Cryptohashblake2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_cluster_set(s : Cryptohashblake2Cluster, i : Int, v : Double) -> Cryptohashblake2Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_sum(s : Cryptohashblake2Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_cluster_mean(s : Cryptohashblake2Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_cluster_scale(s : Cryptohashblake2Cluster, f : Double) -> Cryptohashblake2Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_add(a : Cryptohashblake2Cluster, b : Cryptohashblake2Cluster) -> Cryptohashblake2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_cluster_copy(s : Cryptohashblake2Cluster) -> Cryptohashblake2Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_fill(s : Cryptohashblake2Cluster, v : Double) -> Cryptohashblake2Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cluster_min(s : Cryptohashblake2Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_cluster_max(s : Cryptohashblake2Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_cluster_to_string(s : Cryptohashblake2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_model_make(size : Int) -> Cryptohashblake2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_model_len(s : Cryptohashblake2Model) -> Int { s.size }

pub fn crypto_hash_blake2_model_get(s : Cryptohashblake2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_model_set(s : Cryptohashblake2Model, i : Int, v : Double) -> Cryptohashblake2Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_sum(s : Cryptohashblake2Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_model_mean(s : Cryptohashblake2Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_model_scale(s : Cryptohashblake2Model, f : Double) -> Cryptohashblake2Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_add(a : Cryptohashblake2Model, b : Cryptohashblake2Model) -> Cryptohashblake2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_model_copy(s : Cryptohashblake2Model) -> Cryptohashblake2Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_fill(s : Cryptohashblake2Model, v : Double) -> Cryptohashblake2Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_model_min(s : Cryptohashblake2Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_model_max(s : Cryptohashblake2Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_model_to_string(s : Cryptohashblake2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_layer_make(size : Int) -> Cryptohashblake2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_layer_len(s : Cryptohashblake2Layer) -> Int { s.size }

pub fn crypto_hash_blake2_layer_get(s : Cryptohashblake2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_layer_set(s : Cryptohashblake2Layer, i : Int, v : Double) -> Cryptohashblake2Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_sum(s : Cryptohashblake2Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_layer_mean(s : Cryptohashblake2Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_layer_scale(s : Cryptohashblake2Layer, f : Double) -> Cryptohashblake2Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_add(a : Cryptohashblake2Layer, b : Cryptohashblake2Layer) -> Cryptohashblake2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_layer_copy(s : Cryptohashblake2Layer) -> Cryptohashblake2Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_fill(s : Cryptohashblake2Layer, v : Double) -> Cryptohashblake2Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_layer_min(s : Cryptohashblake2Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_layer_max(s : Cryptohashblake2Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_layer_to_string(s : Cryptohashblake2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_buffer_make(size : Int) -> Cryptohashblake2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_buffer_len(s : Cryptohashblake2Buffer) -> Int { s.size }

pub fn crypto_hash_blake2_buffer_get(s : Cryptohashblake2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_buffer_set(s : Cryptohashblake2Buffer, i : Int, v : Double) -> Cryptohashblake2Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_sum(s : Cryptohashblake2Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_buffer_mean(s : Cryptohashblake2Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_buffer_scale(s : Cryptohashblake2Buffer, f : Double) -> Cryptohashblake2Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_add(a : Cryptohashblake2Buffer, b : Cryptohashblake2Buffer) -> Cryptohashblake2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_buffer_copy(s : Cryptohashblake2Buffer) -> Cryptohashblake2Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_fill(s : Cryptohashblake2Buffer, v : Double) -> Cryptohashblake2Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_buffer_min(s : Cryptohashblake2Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_buffer_max(s : Cryptohashblake2Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_buffer_to_string(s : Cryptohashblake2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_cursor_make(size : Int) -> Cryptohashblake2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_cursor_len(s : Cryptohashblake2Cursor) -> Int { s.size }

pub fn crypto_hash_blake2_cursor_get(s : Cryptohashblake2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_cursor_set(s : Cryptohashblake2Cursor, i : Int, v : Double) -> Cryptohashblake2Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_sum(s : Cryptohashblake2Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_cursor_mean(s : Cryptohashblake2Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_cursor_scale(s : Cryptohashblake2Cursor, f : Double) -> Cryptohashblake2Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_add(a : Cryptohashblake2Cursor, b : Cryptohashblake2Cursor) -> Cryptohashblake2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_cursor_copy(s : Cryptohashblake2Cursor) -> Cryptohashblake2Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_fill(s : Cryptohashblake2Cursor, v : Double) -> Cryptohashblake2Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_cursor_min(s : Cryptohashblake2Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_cursor_max(s : Cryptohashblake2Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_cursor_to_string(s : Cryptohashblake2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_view_make(size : Int) -> Cryptohashblake2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_view_len(s : Cryptohashblake2View) -> Int { s.size }

pub fn crypto_hash_blake2_view_get(s : Cryptohashblake2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_view_set(s : Cryptohashblake2View, i : Int, v : Double) -> Cryptohashblake2View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_sum(s : Cryptohashblake2View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_view_mean(s : Cryptohashblake2View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_view_scale(s : Cryptohashblake2View, f : Double) -> Cryptohashblake2View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_add(a : Cryptohashblake2View, b : Cryptohashblake2View) -> Cryptohashblake2View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_view_copy(s : Cryptohashblake2View) -> Cryptohashblake2View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_fill(s : Cryptohashblake2View, v : Double) -> Cryptohashblake2View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_view_min(s : Cryptohashblake2View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_view_max(s : Cryptohashblake2View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_view_to_string(s : Cryptohashblake2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_range_make(size : Int) -> Cryptohashblake2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_range_len(s : Cryptohashblake2Range) -> Int { s.size }

pub fn crypto_hash_blake2_range_get(s : Cryptohashblake2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_range_set(s : Cryptohashblake2Range, i : Int, v : Double) -> Cryptohashblake2Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_sum(s : Cryptohashblake2Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_range_mean(s : Cryptohashblake2Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_range_scale(s : Cryptohashblake2Range, f : Double) -> Cryptohashblake2Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_add(a : Cryptohashblake2Range, b : Cryptohashblake2Range) -> Cryptohashblake2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_range_copy(s : Cryptohashblake2Range) -> Cryptohashblake2Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_fill(s : Cryptohashblake2Range, v : Double) -> Cryptohashblake2Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_range_min(s : Cryptohashblake2Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_range_max(s : Cryptohashblake2Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_range_to_string(s : Cryptohashblake2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_slice_make(size : Int) -> Cryptohashblake2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake2_slice_len(s : Cryptohashblake2Slice) -> Int { s.size }

pub fn crypto_hash_blake2_slice_get(s : Cryptohashblake2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake2_slice_set(s : Cryptohashblake2Slice, i : Int, v : Double) -> Cryptohashblake2Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_sum(s : Cryptohashblake2Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake2_slice_mean(s : Cryptohashblake2Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake2_slice_scale(s : Cryptohashblake2Slice, f : Double) -> Cryptohashblake2Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_add(a : Cryptohashblake2Slice, b : Cryptohashblake2Slice) -> Cryptohashblake2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake2_slice_copy(s : Cryptohashblake2Slice) -> Cryptohashblake2Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_fill(s : Cryptohashblake2Slice, v : Double) -> Cryptohashblake2Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake2_slice_min(s : Cryptohashblake2Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake2_slice_max(s : Cryptohashblake2Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake2_slice_to_string(s : Cryptohashblake2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

