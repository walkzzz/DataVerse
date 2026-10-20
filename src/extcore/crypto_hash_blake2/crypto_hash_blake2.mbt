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

pub fn Cryptohashblake2Frame::len(self : Cryptohashblake2Frame) -> Int { self.size }

pub fn Cryptohashblake2Frame::get(self : Cryptohashblake2Frame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Frame::set(self : Cryptohashblake2Frame, i : Int, v : Double) -> Cryptohashblake2Frame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Frame::sum(self : Cryptohashblake2Frame) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Frame::mean(self : Cryptohashblake2Frame) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Frame::scale(self : Cryptohashblake2Frame, f : Double) -> Cryptohashblake2Frame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Frame::add(self : Cryptohashblake2Frame, other : Cryptohashblake2Frame) -> Cryptohashblake2Frame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Frame::copy(self : Cryptohashblake2Frame) -> Cryptohashblake2Frame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Frame::fill(self : Cryptohashblake2Frame, v : Double) -> Cryptohashblake2Frame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Frame::min(self : Cryptohashblake2Frame) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Frame::max(self : Cryptohashblake2Frame) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Frame::to_string(self : Cryptohashblake2Frame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_table_make(size : Int) -> Cryptohashblake2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Table::len(self : Cryptohashblake2Table) -> Int { self.size }

pub fn Cryptohashblake2Table::get(self : Cryptohashblake2Table, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Table::set(self : Cryptohashblake2Table, i : Int, v : Double) -> Cryptohashblake2Table {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Table::sum(self : Cryptohashblake2Table) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Table::mean(self : Cryptohashblake2Table) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Table::scale(self : Cryptohashblake2Table, f : Double) -> Cryptohashblake2Table {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Table::add(self : Cryptohashblake2Table, other : Cryptohashblake2Table) -> Cryptohashblake2Table {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Table::copy(self : Cryptohashblake2Table) -> Cryptohashblake2Table {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Table::fill(self : Cryptohashblake2Table, v : Double) -> Cryptohashblake2Table {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Table::min(self : Cryptohashblake2Table) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Table::max(self : Cryptohashblake2Table) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Table::to_string(self : Cryptohashblake2Table) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_graphn_make(size : Int) -> Cryptohashblake2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2GraphN::len(self : Cryptohashblake2GraphN) -> Int { self.size }

pub fn Cryptohashblake2GraphN::get(self : Cryptohashblake2GraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2GraphN::set(self : Cryptohashblake2GraphN, i : Int, v : Double) -> Cryptohashblake2GraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2GraphN::sum(self : Cryptohashblake2GraphN) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2GraphN::mean(self : Cryptohashblake2GraphN) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2GraphN::scale(self : Cryptohashblake2GraphN, f : Double) -> Cryptohashblake2GraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2GraphN::add(self : Cryptohashblake2GraphN, other : Cryptohashblake2GraphN) -> Cryptohashblake2GraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2GraphN::copy(self : Cryptohashblake2GraphN) -> Cryptohashblake2GraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2GraphN::fill(self : Cryptohashblake2GraphN, v : Double) -> Cryptohashblake2GraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2GraphN::min(self : Cryptohashblake2GraphN) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2GraphN::max(self : Cryptohashblake2GraphN) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2GraphN::to_string(self : Cryptohashblake2GraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_node_make(size : Int) -> Cryptohashblake2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Node::len(self : Cryptohashblake2Node) -> Int { self.size }

pub fn Cryptohashblake2Node::get(self : Cryptohashblake2Node, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Node::set(self : Cryptohashblake2Node, i : Int, v : Double) -> Cryptohashblake2Node {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Node::sum(self : Cryptohashblake2Node) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Node::mean(self : Cryptohashblake2Node) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Node::scale(self : Cryptohashblake2Node, f : Double) -> Cryptohashblake2Node {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Node::add(self : Cryptohashblake2Node, other : Cryptohashblake2Node) -> Cryptohashblake2Node {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Node::copy(self : Cryptohashblake2Node) -> Cryptohashblake2Node {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Node::fill(self : Cryptohashblake2Node, v : Double) -> Cryptohashblake2Node {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Node::min(self : Cryptohashblake2Node) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Node::max(self : Cryptohashblake2Node) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Node::to_string(self : Cryptohashblake2Node) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_edge_make(size : Int) -> Cryptohashblake2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Edge::len(self : Cryptohashblake2Edge) -> Int { self.size }

pub fn Cryptohashblake2Edge::get(self : Cryptohashblake2Edge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Edge::set(self : Cryptohashblake2Edge, i : Int, v : Double) -> Cryptohashblake2Edge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Edge::sum(self : Cryptohashblake2Edge) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Edge::mean(self : Cryptohashblake2Edge) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Edge::scale(self : Cryptohashblake2Edge, f : Double) -> Cryptohashblake2Edge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Edge::add(self : Cryptohashblake2Edge, other : Cryptohashblake2Edge) -> Cryptohashblake2Edge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Edge::copy(self : Cryptohashblake2Edge) -> Cryptohashblake2Edge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Edge::fill(self : Cryptohashblake2Edge, v : Double) -> Cryptohashblake2Edge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Edge::min(self : Cryptohashblake2Edge) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Edge::max(self : Cryptohashblake2Edge) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Edge::to_string(self : Cryptohashblake2Edge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_path_make(size : Int) -> Cryptohashblake2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Path::len(self : Cryptohashblake2Path) -> Int { self.size }

pub fn Cryptohashblake2Path::get(self : Cryptohashblake2Path, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Path::set(self : Cryptohashblake2Path, i : Int, v : Double) -> Cryptohashblake2Path {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Path::sum(self : Cryptohashblake2Path) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Path::mean(self : Cryptohashblake2Path) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Path::scale(self : Cryptohashblake2Path, f : Double) -> Cryptohashblake2Path {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Path::add(self : Cryptohashblake2Path, other : Cryptohashblake2Path) -> Cryptohashblake2Path {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Path::copy(self : Cryptohashblake2Path) -> Cryptohashblake2Path {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Path::fill(self : Cryptohashblake2Path, v : Double) -> Cryptohashblake2Path {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Path::min(self : Cryptohashblake2Path) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Path::max(self : Cryptohashblake2Path) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Path::to_string(self : Cryptohashblake2Path) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_cluster_make(size : Int) -> Cryptohashblake2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Cluster::len(self : Cryptohashblake2Cluster) -> Int { self.size }

pub fn Cryptohashblake2Cluster::get(self : Cryptohashblake2Cluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Cluster::set(self : Cryptohashblake2Cluster, i : Int, v : Double) -> Cryptohashblake2Cluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cluster::sum(self : Cryptohashblake2Cluster) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Cluster::mean(self : Cryptohashblake2Cluster) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Cluster::scale(self : Cryptohashblake2Cluster, f : Double) -> Cryptohashblake2Cluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cluster::add(self : Cryptohashblake2Cluster, other : Cryptohashblake2Cluster) -> Cryptohashblake2Cluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Cluster::copy(self : Cryptohashblake2Cluster) -> Cryptohashblake2Cluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cluster::fill(self : Cryptohashblake2Cluster, v : Double) -> Cryptohashblake2Cluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cluster::min(self : Cryptohashblake2Cluster) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Cluster::max(self : Cryptohashblake2Cluster) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Cluster::to_string(self : Cryptohashblake2Cluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_model_make(size : Int) -> Cryptohashblake2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Model::len(self : Cryptohashblake2Model) -> Int { self.size }

pub fn Cryptohashblake2Model::get(self : Cryptohashblake2Model, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Model::set(self : Cryptohashblake2Model, i : Int, v : Double) -> Cryptohashblake2Model {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Model::sum(self : Cryptohashblake2Model) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Model::mean(self : Cryptohashblake2Model) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Model::scale(self : Cryptohashblake2Model, f : Double) -> Cryptohashblake2Model {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Model::add(self : Cryptohashblake2Model, other : Cryptohashblake2Model) -> Cryptohashblake2Model {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Model::copy(self : Cryptohashblake2Model) -> Cryptohashblake2Model {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Model::fill(self : Cryptohashblake2Model, v : Double) -> Cryptohashblake2Model {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Model::min(self : Cryptohashblake2Model) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Model::max(self : Cryptohashblake2Model) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Model::to_string(self : Cryptohashblake2Model) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_layer_make(size : Int) -> Cryptohashblake2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Layer::len(self : Cryptohashblake2Layer) -> Int { self.size }

pub fn Cryptohashblake2Layer::get(self : Cryptohashblake2Layer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Layer::set(self : Cryptohashblake2Layer, i : Int, v : Double) -> Cryptohashblake2Layer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Layer::sum(self : Cryptohashblake2Layer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Layer::mean(self : Cryptohashblake2Layer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Layer::scale(self : Cryptohashblake2Layer, f : Double) -> Cryptohashblake2Layer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Layer::add(self : Cryptohashblake2Layer, other : Cryptohashblake2Layer) -> Cryptohashblake2Layer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Layer::copy(self : Cryptohashblake2Layer) -> Cryptohashblake2Layer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Layer::fill(self : Cryptohashblake2Layer, v : Double) -> Cryptohashblake2Layer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Layer::min(self : Cryptohashblake2Layer) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Layer::max(self : Cryptohashblake2Layer) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Layer::to_string(self : Cryptohashblake2Layer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_buffer_make(size : Int) -> Cryptohashblake2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Buffer::len(self : Cryptohashblake2Buffer) -> Int { self.size }

pub fn Cryptohashblake2Buffer::get(self : Cryptohashblake2Buffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Buffer::set(self : Cryptohashblake2Buffer, i : Int, v : Double) -> Cryptohashblake2Buffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Buffer::sum(self : Cryptohashblake2Buffer) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Buffer::mean(self : Cryptohashblake2Buffer) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Buffer::scale(self : Cryptohashblake2Buffer, f : Double) -> Cryptohashblake2Buffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Buffer::add(self : Cryptohashblake2Buffer, other : Cryptohashblake2Buffer) -> Cryptohashblake2Buffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Buffer::copy(self : Cryptohashblake2Buffer) -> Cryptohashblake2Buffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Buffer::fill(self : Cryptohashblake2Buffer, v : Double) -> Cryptohashblake2Buffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Buffer::min(self : Cryptohashblake2Buffer) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Buffer::max(self : Cryptohashblake2Buffer) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Buffer::to_string(self : Cryptohashblake2Buffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_cursor_make(size : Int) -> Cryptohashblake2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Cursor::len(self : Cryptohashblake2Cursor) -> Int { self.size }

pub fn Cryptohashblake2Cursor::get(self : Cryptohashblake2Cursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Cursor::set(self : Cryptohashblake2Cursor, i : Int, v : Double) -> Cryptohashblake2Cursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cursor::sum(self : Cryptohashblake2Cursor) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Cursor::mean(self : Cryptohashblake2Cursor) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Cursor::scale(self : Cryptohashblake2Cursor, f : Double) -> Cryptohashblake2Cursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cursor::add(self : Cryptohashblake2Cursor, other : Cryptohashblake2Cursor) -> Cryptohashblake2Cursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Cursor::copy(self : Cryptohashblake2Cursor) -> Cryptohashblake2Cursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cursor::fill(self : Cryptohashblake2Cursor, v : Double) -> Cryptohashblake2Cursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Cursor::min(self : Cryptohashblake2Cursor) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Cursor::max(self : Cryptohashblake2Cursor) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Cursor::to_string(self : Cryptohashblake2Cursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_view_make(size : Int) -> Cryptohashblake2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2View::len(self : Cryptohashblake2View) -> Int { self.size }

pub fn Cryptohashblake2View::get(self : Cryptohashblake2View, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2View::set(self : Cryptohashblake2View, i : Int, v : Double) -> Cryptohashblake2View {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2View::sum(self : Cryptohashblake2View) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2View::mean(self : Cryptohashblake2View) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2View::scale(self : Cryptohashblake2View, f : Double) -> Cryptohashblake2View {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2View::add(self : Cryptohashblake2View, other : Cryptohashblake2View) -> Cryptohashblake2View {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2View::copy(self : Cryptohashblake2View) -> Cryptohashblake2View {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2View::fill(self : Cryptohashblake2View, v : Double) -> Cryptohashblake2View {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2View::min(self : Cryptohashblake2View) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2View::max(self : Cryptohashblake2View) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2View::to_string(self : Cryptohashblake2View) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_range_make(size : Int) -> Cryptohashblake2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Range::len(self : Cryptohashblake2Range) -> Int { self.size }

pub fn Cryptohashblake2Range::get(self : Cryptohashblake2Range, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Range::set(self : Cryptohashblake2Range, i : Int, v : Double) -> Cryptohashblake2Range {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Range::sum(self : Cryptohashblake2Range) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Range::mean(self : Cryptohashblake2Range) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Range::scale(self : Cryptohashblake2Range, f : Double) -> Cryptohashblake2Range {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Range::add(self : Cryptohashblake2Range, other : Cryptohashblake2Range) -> Cryptohashblake2Range {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Range::copy(self : Cryptohashblake2Range) -> Cryptohashblake2Range {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Range::fill(self : Cryptohashblake2Range, v : Double) -> Cryptohashblake2Range {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Range::min(self : Cryptohashblake2Range) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Range::max(self : Cryptohashblake2Range) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Range::to_string(self : Cryptohashblake2Range) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake2_slice_make(size : Int) -> Cryptohashblake2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Cryptohashblake2Slice::len(self : Cryptohashblake2Slice) -> Int { self.size }

pub fn Cryptohashblake2Slice::get(self : Cryptohashblake2Slice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Cryptohashblake2Slice::set(self : Cryptohashblake2Slice, i : Int, v : Double) -> Cryptohashblake2Slice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Slice::sum(self : Cryptohashblake2Slice) -> Double { @_common.sum(self.data) }

pub fn Cryptohashblake2Slice::mean(self : Cryptohashblake2Slice) -> Double { @_common.mean(self.data) }

pub fn Cryptohashblake2Slice::scale(self : Cryptohashblake2Slice, f : Double) -> Cryptohashblake2Slice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Slice::add(self : Cryptohashblake2Slice, other : Cryptohashblake2Slice) -> Cryptohashblake2Slice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Cryptohashblake2Slice::copy(self : Cryptohashblake2Slice) -> Cryptohashblake2Slice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Slice::fill(self : Cryptohashblake2Slice, v : Double) -> Cryptohashblake2Slice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Cryptohashblake2Slice::min(self : Cryptohashblake2Slice) -> Double { @_common.min(self.data) }

pub fn Cryptohashblake2Slice::max(self : Cryptohashblake2Slice) -> Double { @_common.max(self.data) }

pub fn Cryptohashblake2Slice::to_string(self : Cryptohashblake2Slice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

