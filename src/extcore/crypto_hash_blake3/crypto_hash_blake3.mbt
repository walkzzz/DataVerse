///===
/// extcore/crypto_hash_blake3

pub(all) struct Cryptohashblake3Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_blake3_make_point(x : Double, y : Double) -> Cryptohashblake3Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_blake3_make_point3(x : Double, y : Double, z : Double) -> Cryptohashblake3Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashblake3Point::x(self : Cryptohashblake3Point) -> Double { self.x }

pub fn Cryptohashblake3Point::y(self : Cryptohashblake3Point) -> Double { self.y }

pub fn Cryptohashblake3Point::z(self : Cryptohashblake3Point) -> Double { self.z }

pub fn Cryptohashblake3Point::label(self : Cryptohashblake3Point) -> Int { self.label }

pub fn Cryptohashblake3Point::dist(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashblake3Point::add(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashblake3Point::sub(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashblake3Point::scale(self : Cryptohashblake3Point, s : Double) -> Cryptohashblake3Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashblake3Point::dot(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashblake3Point::cross(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashblake3Point::norm(self : Cryptohashblake3Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashblake3Point::normalize(self : Cryptohashblake3Point) -> Cryptohashblake3Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashblake3Point::negate(self : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashblake3Point::mid(self : Cryptohashblake3Point, other : Cryptohashblake3Point) -> Cryptohashblake3Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashblake3Point::lerp(self : Cryptohashblake3Point, other : Cryptohashblake3Point, t : Double) -> Cryptohashblake3Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashblake3Point::to_string(self : Cryptohashblake3Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashblake3Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_blake3_make_series(vals : Array[Double], name : String) -> Cryptohashblake3Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashblake3Series::len(self : Cryptohashblake3Series) -> Int { self.vals.length() }

pub fn Cryptohashblake3Series::sum(self : Cryptohashblake3Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashblake3Series::mean(self : Cryptohashblake3Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashblake3Series::min(self : Cryptohashblake3Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashblake3Series::max(self : Cryptohashblake3Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashblake3Series::range(self : Cryptohashblake3Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashblake3Series::variance(self : Cryptohashblake3Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashblake3Series::std(self : Cryptohashblake3Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashblake3Series::median(self : Cryptohashblake3Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashblake3Series::scale(self : Cryptohashblake3Series, f : Double) -> Cryptohashblake3Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashblake3Series::add(self : Cryptohashblake3Series, other : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashblake3Series::sub(self : Cryptohashblake3Series, other : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashblake3Series::normalize(self : Cryptohashblake3Series) -> Cryptohashblake3Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashblake3Series::cumsum(self : Cryptohashblake3Series) -> Cryptohashblake3Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashblake3Series::to_string(self : Cryptohashblake3Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashblake3Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_blake3_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashblake3Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_blake3_matrix_identity(n : Int) -> Cryptohashblake3Matrix {
  let m = crypto_hash_blake3_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashblake3Matrix::get(self : Cryptohashblake3Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashblake3Matrix::transpose(self : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  let result = crypto_hash_blake3_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashblake3Matrix::add(self : Cryptohashblake3Matrix, other : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_blake3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashblake3Matrix::scale(self : Cryptohashblake3Matrix, s : Double) -> Cryptohashblake3Matrix {
  let result = crypto_hash_blake3_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashblake3Matrix::multiply(self : Cryptohashblake3Matrix, other : Cryptohashblake3Matrix) -> Cryptohashblake3Matrix {
  if self.cols != other.rows { return crypto_hash_blake3_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_blake3_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashblake3Matrix::trace(self : Cryptohashblake3Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashblake3Matrix::det(self : Cryptohashblake3Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashblake3Matrix::norm(self : Cryptohashblake3Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashblake3Matrix::to_string(self : Cryptohashblake3Matrix) -> String {
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

pub(all) struct Cryptohashblake3Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_blake3_make_vector(comps : Array[Double]) -> Cryptohashblake3Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_blake3_vector_zero(dim : Int) -> Cryptohashblake3Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashblake3Vector::add(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashblake3Vector::sub(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashblake3Vector::scale(self : Cryptohashblake3Vector, s : Double) -> Cryptohashblake3Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashblake3Vector::dot(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashblake3Vector::norm(self : Cryptohashblake3Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashblake3Vector::normalize(self : Cryptohashblake3Vector) -> Cryptohashblake3Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashblake3Vector::dist(self : Cryptohashblake3Vector, other : Cryptohashblake3Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashblake3Vector::to_string(self : Cryptohashblake3Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_blake3_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_blake3_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_blake3_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_blake3_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_blake3_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_blake3_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_blake3_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_blake3_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_blake3_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_blake3_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_blake3_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_blake3_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_blake3_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_blake3_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_blake3_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_blake3_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_blake3_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_blake3_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_blake3_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_blake3_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_blake3_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_blake3_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_blake3_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_blake3_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_blake3_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_blake3_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_blake3_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_blake3_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_blake3_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashblake3Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_frame_make(size : Int) -> Cryptohashblake3Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_frame_len(s : Cryptohashblake3Frame) -> Int { s.size }

pub fn crypto_hash_blake3_frame_get(s : Cryptohashblake3Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_frame_set(s : Cryptohashblake3Frame, i : Int, v : Double) -> Cryptohashblake3Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_frame_sum(s : Cryptohashblake3Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_frame_mean(s : Cryptohashblake3Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_frame_scale(s : Cryptohashblake3Frame, f : Double) -> Cryptohashblake3Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_frame_add(a : Cryptohashblake3Frame, b : Cryptohashblake3Frame) -> Cryptohashblake3Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_frame_copy(s : Cryptohashblake3Frame) -> Cryptohashblake3Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_frame_fill(s : Cryptohashblake3Frame, v : Double) -> Cryptohashblake3Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_frame_min(s : Cryptohashblake3Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_frame_max(s : Cryptohashblake3Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_frame_to_string(s : Cryptohashblake3Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_table_make(size : Int) -> Cryptohashblake3Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_table_len(s : Cryptohashblake3Table) -> Int { s.size }

pub fn crypto_hash_blake3_table_get(s : Cryptohashblake3Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_table_set(s : Cryptohashblake3Table, i : Int, v : Double) -> Cryptohashblake3Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_table_sum(s : Cryptohashblake3Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_table_mean(s : Cryptohashblake3Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_table_scale(s : Cryptohashblake3Table, f : Double) -> Cryptohashblake3Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_table_add(a : Cryptohashblake3Table, b : Cryptohashblake3Table) -> Cryptohashblake3Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_table_copy(s : Cryptohashblake3Table) -> Cryptohashblake3Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_table_fill(s : Cryptohashblake3Table, v : Double) -> Cryptohashblake3Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_table_min(s : Cryptohashblake3Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_table_max(s : Cryptohashblake3Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_table_to_string(s : Cryptohashblake3Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_graphn_make(size : Int) -> Cryptohashblake3GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_graphn_len(s : Cryptohashblake3GraphN) -> Int { s.size }

pub fn crypto_hash_blake3_graphn_get(s : Cryptohashblake3GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_graphn_set(s : Cryptohashblake3GraphN, i : Int, v : Double) -> Cryptohashblake3GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_graphn_sum(s : Cryptohashblake3GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_graphn_mean(s : Cryptohashblake3GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_graphn_scale(s : Cryptohashblake3GraphN, f : Double) -> Cryptohashblake3GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_graphn_add(a : Cryptohashblake3GraphN, b : Cryptohashblake3GraphN) -> Cryptohashblake3GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_graphn_copy(s : Cryptohashblake3GraphN) -> Cryptohashblake3GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_graphn_fill(s : Cryptohashblake3GraphN, v : Double) -> Cryptohashblake3GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_graphn_min(s : Cryptohashblake3GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_graphn_max(s : Cryptohashblake3GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_graphn_to_string(s : Cryptohashblake3GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_node_make(size : Int) -> Cryptohashblake3Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_node_len(s : Cryptohashblake3Node) -> Int { s.size }

pub fn crypto_hash_blake3_node_get(s : Cryptohashblake3Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_node_set(s : Cryptohashblake3Node, i : Int, v : Double) -> Cryptohashblake3Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_node_sum(s : Cryptohashblake3Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_node_mean(s : Cryptohashblake3Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_node_scale(s : Cryptohashblake3Node, f : Double) -> Cryptohashblake3Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_node_add(a : Cryptohashblake3Node, b : Cryptohashblake3Node) -> Cryptohashblake3Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_node_copy(s : Cryptohashblake3Node) -> Cryptohashblake3Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_node_fill(s : Cryptohashblake3Node, v : Double) -> Cryptohashblake3Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_node_min(s : Cryptohashblake3Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_node_max(s : Cryptohashblake3Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_node_to_string(s : Cryptohashblake3Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_edge_make(size : Int) -> Cryptohashblake3Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_edge_len(s : Cryptohashblake3Edge) -> Int { s.size }

pub fn crypto_hash_blake3_edge_get(s : Cryptohashblake3Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_edge_set(s : Cryptohashblake3Edge, i : Int, v : Double) -> Cryptohashblake3Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_edge_sum(s : Cryptohashblake3Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_edge_mean(s : Cryptohashblake3Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_edge_scale(s : Cryptohashblake3Edge, f : Double) -> Cryptohashblake3Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_edge_add(a : Cryptohashblake3Edge, b : Cryptohashblake3Edge) -> Cryptohashblake3Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_edge_copy(s : Cryptohashblake3Edge) -> Cryptohashblake3Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_edge_fill(s : Cryptohashblake3Edge, v : Double) -> Cryptohashblake3Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_edge_min(s : Cryptohashblake3Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_edge_max(s : Cryptohashblake3Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_edge_to_string(s : Cryptohashblake3Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_path_make(size : Int) -> Cryptohashblake3Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_path_len(s : Cryptohashblake3Path) -> Int { s.size }

pub fn crypto_hash_blake3_path_get(s : Cryptohashblake3Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_path_set(s : Cryptohashblake3Path, i : Int, v : Double) -> Cryptohashblake3Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_path_sum(s : Cryptohashblake3Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_path_mean(s : Cryptohashblake3Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_path_scale(s : Cryptohashblake3Path, f : Double) -> Cryptohashblake3Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_path_add(a : Cryptohashblake3Path, b : Cryptohashblake3Path) -> Cryptohashblake3Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_path_copy(s : Cryptohashblake3Path) -> Cryptohashblake3Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_path_fill(s : Cryptohashblake3Path, v : Double) -> Cryptohashblake3Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_path_min(s : Cryptohashblake3Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_path_max(s : Cryptohashblake3Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_path_to_string(s : Cryptohashblake3Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_cluster_make(size : Int) -> Cryptohashblake3Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_cluster_len(s : Cryptohashblake3Cluster) -> Int { s.size }

pub fn crypto_hash_blake3_cluster_get(s : Cryptohashblake3Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_cluster_set(s : Cryptohashblake3Cluster, i : Int, v : Double) -> Cryptohashblake3Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cluster_sum(s : Cryptohashblake3Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_cluster_mean(s : Cryptohashblake3Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_cluster_scale(s : Cryptohashblake3Cluster, f : Double) -> Cryptohashblake3Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cluster_add(a : Cryptohashblake3Cluster, b : Cryptohashblake3Cluster) -> Cryptohashblake3Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_cluster_copy(s : Cryptohashblake3Cluster) -> Cryptohashblake3Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cluster_fill(s : Cryptohashblake3Cluster, v : Double) -> Cryptohashblake3Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cluster_min(s : Cryptohashblake3Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_cluster_max(s : Cryptohashblake3Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_cluster_to_string(s : Cryptohashblake3Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_model_make(size : Int) -> Cryptohashblake3Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_model_len(s : Cryptohashblake3Model) -> Int { s.size }

pub fn crypto_hash_blake3_model_get(s : Cryptohashblake3Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_model_set(s : Cryptohashblake3Model, i : Int, v : Double) -> Cryptohashblake3Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_model_sum(s : Cryptohashblake3Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_model_mean(s : Cryptohashblake3Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_model_scale(s : Cryptohashblake3Model, f : Double) -> Cryptohashblake3Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_model_add(a : Cryptohashblake3Model, b : Cryptohashblake3Model) -> Cryptohashblake3Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_model_copy(s : Cryptohashblake3Model) -> Cryptohashblake3Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_model_fill(s : Cryptohashblake3Model, v : Double) -> Cryptohashblake3Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_model_min(s : Cryptohashblake3Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_model_max(s : Cryptohashblake3Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_model_to_string(s : Cryptohashblake3Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_layer_make(size : Int) -> Cryptohashblake3Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_layer_len(s : Cryptohashblake3Layer) -> Int { s.size }

pub fn crypto_hash_blake3_layer_get(s : Cryptohashblake3Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_layer_set(s : Cryptohashblake3Layer, i : Int, v : Double) -> Cryptohashblake3Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_layer_sum(s : Cryptohashblake3Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_layer_mean(s : Cryptohashblake3Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_layer_scale(s : Cryptohashblake3Layer, f : Double) -> Cryptohashblake3Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_layer_add(a : Cryptohashblake3Layer, b : Cryptohashblake3Layer) -> Cryptohashblake3Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_layer_copy(s : Cryptohashblake3Layer) -> Cryptohashblake3Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_layer_fill(s : Cryptohashblake3Layer, v : Double) -> Cryptohashblake3Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_layer_min(s : Cryptohashblake3Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_layer_max(s : Cryptohashblake3Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_layer_to_string(s : Cryptohashblake3Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_buffer_make(size : Int) -> Cryptohashblake3Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_buffer_len(s : Cryptohashblake3Buffer) -> Int { s.size }

pub fn crypto_hash_blake3_buffer_get(s : Cryptohashblake3Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_buffer_set(s : Cryptohashblake3Buffer, i : Int, v : Double) -> Cryptohashblake3Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_buffer_sum(s : Cryptohashblake3Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_buffer_mean(s : Cryptohashblake3Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_buffer_scale(s : Cryptohashblake3Buffer, f : Double) -> Cryptohashblake3Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_buffer_add(a : Cryptohashblake3Buffer, b : Cryptohashblake3Buffer) -> Cryptohashblake3Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_buffer_copy(s : Cryptohashblake3Buffer) -> Cryptohashblake3Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_buffer_fill(s : Cryptohashblake3Buffer, v : Double) -> Cryptohashblake3Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_buffer_min(s : Cryptohashblake3Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_buffer_max(s : Cryptohashblake3Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_buffer_to_string(s : Cryptohashblake3Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_cursor_make(size : Int) -> Cryptohashblake3Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_cursor_len(s : Cryptohashblake3Cursor) -> Int { s.size }

pub fn crypto_hash_blake3_cursor_get(s : Cryptohashblake3Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_cursor_set(s : Cryptohashblake3Cursor, i : Int, v : Double) -> Cryptohashblake3Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cursor_sum(s : Cryptohashblake3Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_cursor_mean(s : Cryptohashblake3Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_cursor_scale(s : Cryptohashblake3Cursor, f : Double) -> Cryptohashblake3Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cursor_add(a : Cryptohashblake3Cursor, b : Cryptohashblake3Cursor) -> Cryptohashblake3Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_cursor_copy(s : Cryptohashblake3Cursor) -> Cryptohashblake3Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cursor_fill(s : Cryptohashblake3Cursor, v : Double) -> Cryptohashblake3Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_cursor_min(s : Cryptohashblake3Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_cursor_max(s : Cryptohashblake3Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_cursor_to_string(s : Cryptohashblake3Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_view_make(size : Int) -> Cryptohashblake3View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_view_len(s : Cryptohashblake3View) -> Int { s.size }

pub fn crypto_hash_blake3_view_get(s : Cryptohashblake3View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_view_set(s : Cryptohashblake3View, i : Int, v : Double) -> Cryptohashblake3View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_view_sum(s : Cryptohashblake3View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_view_mean(s : Cryptohashblake3View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_view_scale(s : Cryptohashblake3View, f : Double) -> Cryptohashblake3View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_view_add(a : Cryptohashblake3View, b : Cryptohashblake3View) -> Cryptohashblake3View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_view_copy(s : Cryptohashblake3View) -> Cryptohashblake3View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_view_fill(s : Cryptohashblake3View, v : Double) -> Cryptohashblake3View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_view_min(s : Cryptohashblake3View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_view_max(s : Cryptohashblake3View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_view_to_string(s : Cryptohashblake3View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_range_make(size : Int) -> Cryptohashblake3Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_range_len(s : Cryptohashblake3Range) -> Int { s.size }

pub fn crypto_hash_blake3_range_get(s : Cryptohashblake3Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_range_set(s : Cryptohashblake3Range, i : Int, v : Double) -> Cryptohashblake3Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_range_sum(s : Cryptohashblake3Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_range_mean(s : Cryptohashblake3Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_range_scale(s : Cryptohashblake3Range, f : Double) -> Cryptohashblake3Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_range_add(a : Cryptohashblake3Range, b : Cryptohashblake3Range) -> Cryptohashblake3Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_range_copy(s : Cryptohashblake3Range) -> Cryptohashblake3Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_range_fill(s : Cryptohashblake3Range, v : Double) -> Cryptohashblake3Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_range_min(s : Cryptohashblake3Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_range_max(s : Cryptohashblake3Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_range_to_string(s : Cryptohashblake3Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashblake3Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_blake3_slice_make(size : Int) -> Cryptohashblake3Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_blake3_slice_len(s : Cryptohashblake3Slice) -> Int { s.size }

pub fn crypto_hash_blake3_slice_get(s : Cryptohashblake3Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_blake3_slice_set(s : Cryptohashblake3Slice, i : Int, v : Double) -> Cryptohashblake3Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_slice_sum(s : Cryptohashblake3Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_blake3_slice_mean(s : Cryptohashblake3Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_blake3_slice_scale(s : Cryptohashblake3Slice, f : Double) -> Cryptohashblake3Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_slice_add(a : Cryptohashblake3Slice, b : Cryptohashblake3Slice) -> Cryptohashblake3Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_blake3_slice_copy(s : Cryptohashblake3Slice) -> Cryptohashblake3Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_slice_fill(s : Cryptohashblake3Slice, v : Double) -> Cryptohashblake3Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_blake3_slice_min(s : Cryptohashblake3Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_blake3_slice_max(s : Cryptohashblake3Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_blake3_slice_to_string(s : Cryptohashblake3Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

