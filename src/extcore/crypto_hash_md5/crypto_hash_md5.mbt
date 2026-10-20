///===
/// extcore/crypto_hash_md5

pub(all) struct Cryptohashmd5Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_md5_make_point(x : Double, y : Double) -> Cryptohashmd5Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_md5_make_point3(x : Double, y : Double, z : Double) -> Cryptohashmd5Point {
  { x, y, z, label: 0 }
}

pub fn Cryptohashmd5Point::x(self : Cryptohashmd5Point) -> Double { self.x }

pub fn Cryptohashmd5Point::y(self : Cryptohashmd5Point) -> Double { self.y }

pub fn Cryptohashmd5Point::z(self : Cryptohashmd5Point) -> Double { self.z }

pub fn Cryptohashmd5Point::label(self : Cryptohashmd5Point) -> Int { self.label }

pub fn Cryptohashmd5Point::dist(self : Cryptohashmd5Point, other : Cryptohashmd5Point) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Cryptohashmd5Point::add(self : Cryptohashmd5Point, other : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Cryptohashmd5Point::sub(self : Cryptohashmd5Point, other : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Cryptohashmd5Point::scale(self : Cryptohashmd5Point, s : Double) -> Cryptohashmd5Point {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Cryptohashmd5Point::dot(self : Cryptohashmd5Point, other : Cryptohashmd5Point) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Cryptohashmd5Point::cross(self : Cryptohashmd5Point, other : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Cryptohashmd5Point::norm(self : Cryptohashmd5Point) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Cryptohashmd5Point::normalize(self : Cryptohashmd5Point) -> Cryptohashmd5Point {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashmd5Point::negate(self : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Cryptohashmd5Point::mid(self : Cryptohashmd5Point, other : Cryptohashmd5Point) -> Cryptohashmd5Point {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Cryptohashmd5Point::lerp(self : Cryptohashmd5Point, other : Cryptohashmd5Point, t : Double) -> Cryptohashmd5Point {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Cryptohashmd5Point::to_string(self : Cryptohashmd5Point) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Cryptohashmd5Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_md5_make_series(vals : Array[Double], name : String) -> Cryptohashmd5Series {
  { vals, name, meta: 0 }
}

pub fn Cryptohashmd5Series::len(self : Cryptohashmd5Series) -> Int { self.vals.length() }

pub fn Cryptohashmd5Series::sum(self : Cryptohashmd5Series) -> Double { @_common.sum(self.vals) }

pub fn Cryptohashmd5Series::mean(self : Cryptohashmd5Series) -> Double { @_common.mean(self.vals) }

pub fn Cryptohashmd5Series::min(self : Cryptohashmd5Series) -> Double { @_common.min(self.vals) }

pub fn Cryptohashmd5Series::max(self : Cryptohashmd5Series) -> Double { @_common.max(self.vals) }

pub fn Cryptohashmd5Series::range(self : Cryptohashmd5Series) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Cryptohashmd5Series::variance(self : Cryptohashmd5Series) -> Double { @_common.variance(self.vals) }

pub fn Cryptohashmd5Series::std(self : Cryptohashmd5Series) -> Double { @_common.std(self.vals) }

pub fn Cryptohashmd5Series::median(self : Cryptohashmd5Series) -> Double { @_common.median(self.vals) }

pub fn Cryptohashmd5Series::scale(self : Cryptohashmd5Series, f : Double) -> Cryptohashmd5Series {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Cryptohashmd5Series::add(self : Cryptohashmd5Series, other : Cryptohashmd5Series) -> Cryptohashmd5Series {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Cryptohashmd5Series::sub(self : Cryptohashmd5Series, other : Cryptohashmd5Series) -> Cryptohashmd5Series {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Cryptohashmd5Series::normalize(self : Cryptohashmd5Series) -> Cryptohashmd5Series {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Cryptohashmd5Series::cumsum(self : Cryptohashmd5Series) -> Cryptohashmd5Series {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Cryptohashmd5Series::to_string(self : Cryptohashmd5Series) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Cryptohashmd5Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_md5_make_matrix(rows : Int, cols : Int, val : Double) -> Cryptohashmd5Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_md5_matrix_identity(n : Int) -> Cryptohashmd5Matrix {
  let m = crypto_hash_md5_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Cryptohashmd5Matrix::get(self : Cryptohashmd5Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Cryptohashmd5Matrix::transpose(self : Cryptohashmd5Matrix) -> Cryptohashmd5Matrix {
  let result = crypto_hash_md5_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Cryptohashmd5Matrix::add(self : Cryptohashmd5Matrix, other : Cryptohashmd5Matrix) -> Cryptohashmd5Matrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_md5_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Cryptohashmd5Matrix::scale(self : Cryptohashmd5Matrix, s : Double) -> Cryptohashmd5Matrix {
  let result = crypto_hash_md5_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Cryptohashmd5Matrix::multiply(self : Cryptohashmd5Matrix, other : Cryptohashmd5Matrix) -> Cryptohashmd5Matrix {
  if self.cols != other.rows { return crypto_hash_md5_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_md5_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Cryptohashmd5Matrix::trace(self : Cryptohashmd5Matrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Cryptohashmd5Matrix::det(self : Cryptohashmd5Matrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Cryptohashmd5Matrix::norm(self : Cryptohashmd5Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Cryptohashmd5Matrix::to_string(self : Cryptohashmd5Matrix) -> String {
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

pub(all) struct Cryptohashmd5Vector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_md5_make_vector(comps : Array[Double]) -> Cryptohashmd5Vector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_md5_vector_zero(dim : Int) -> Cryptohashmd5Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Cryptohashmd5Vector::add(self : Cryptohashmd5Vector, other : Cryptohashmd5Vector) -> Cryptohashmd5Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashmd5Vector::sub(self : Cryptohashmd5Vector, other : Cryptohashmd5Vector) -> Cryptohashmd5Vector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Cryptohashmd5Vector::scale(self : Cryptohashmd5Vector, s : Double) -> Cryptohashmd5Vector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Cryptohashmd5Vector::dot(self : Cryptohashmd5Vector, other : Cryptohashmd5Vector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Cryptohashmd5Vector::norm(self : Cryptohashmd5Vector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Cryptohashmd5Vector::normalize(self : Cryptohashmd5Vector) -> Cryptohashmd5Vector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Cryptohashmd5Vector::dist(self : Cryptohashmd5Vector, other : Cryptohashmd5Vector) -> Double {
  self.sub(other).norm()
}

pub fn Cryptohashmd5Vector::to_string(self : Cryptohashmd5Vector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_md5_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_md5_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_md5_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_md5_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_md5_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_md5_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_md5_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_md5_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_md5_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_md5_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_md5_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_md5_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_md5_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_md5_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_md5_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_md5_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_md5_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_md5_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_md5_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_md5_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_md5_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_md5_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_md5_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_md5_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_md5_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_md5_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_md5_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_md5_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_md5_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Cryptohashmd5Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_frame_make(size : Int) -> Cryptohashmd5Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_frame_len(s : Cryptohashmd5Frame) -> Int { s.size }

pub fn crypto_hash_md5_frame_get(s : Cryptohashmd5Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_frame_set(s : Cryptohashmd5Frame, i : Int, v : Double) -> Cryptohashmd5Frame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_frame_sum(s : Cryptohashmd5Frame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_frame_mean(s : Cryptohashmd5Frame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_frame_scale(s : Cryptohashmd5Frame, f : Double) -> Cryptohashmd5Frame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_frame_add(a : Cryptohashmd5Frame, b : Cryptohashmd5Frame) -> Cryptohashmd5Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_frame_copy(s : Cryptohashmd5Frame) -> Cryptohashmd5Frame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_frame_fill(s : Cryptohashmd5Frame, v : Double) -> Cryptohashmd5Frame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_frame_min(s : Cryptohashmd5Frame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_frame_max(s : Cryptohashmd5Frame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_frame_to_string(s : Cryptohashmd5Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_table_make(size : Int) -> Cryptohashmd5Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_table_len(s : Cryptohashmd5Table) -> Int { s.size }

pub fn crypto_hash_md5_table_get(s : Cryptohashmd5Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_table_set(s : Cryptohashmd5Table, i : Int, v : Double) -> Cryptohashmd5Table {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_table_sum(s : Cryptohashmd5Table) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_table_mean(s : Cryptohashmd5Table) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_table_scale(s : Cryptohashmd5Table, f : Double) -> Cryptohashmd5Table {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_table_add(a : Cryptohashmd5Table, b : Cryptohashmd5Table) -> Cryptohashmd5Table {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_table_copy(s : Cryptohashmd5Table) -> Cryptohashmd5Table {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_table_fill(s : Cryptohashmd5Table, v : Double) -> Cryptohashmd5Table {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_table_min(s : Cryptohashmd5Table) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_table_max(s : Cryptohashmd5Table) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_table_to_string(s : Cryptohashmd5Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_graphn_make(size : Int) -> Cryptohashmd5GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_graphn_len(s : Cryptohashmd5GraphN) -> Int { s.size }

pub fn crypto_hash_md5_graphn_get(s : Cryptohashmd5GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_graphn_set(s : Cryptohashmd5GraphN, i : Int, v : Double) -> Cryptohashmd5GraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_graphn_sum(s : Cryptohashmd5GraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_graphn_mean(s : Cryptohashmd5GraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_graphn_scale(s : Cryptohashmd5GraphN, f : Double) -> Cryptohashmd5GraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_graphn_add(a : Cryptohashmd5GraphN, b : Cryptohashmd5GraphN) -> Cryptohashmd5GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_graphn_copy(s : Cryptohashmd5GraphN) -> Cryptohashmd5GraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_graphn_fill(s : Cryptohashmd5GraphN, v : Double) -> Cryptohashmd5GraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_graphn_min(s : Cryptohashmd5GraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_graphn_max(s : Cryptohashmd5GraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_graphn_to_string(s : Cryptohashmd5GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_node_make(size : Int) -> Cryptohashmd5Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_node_len(s : Cryptohashmd5Node) -> Int { s.size }

pub fn crypto_hash_md5_node_get(s : Cryptohashmd5Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_node_set(s : Cryptohashmd5Node, i : Int, v : Double) -> Cryptohashmd5Node {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_node_sum(s : Cryptohashmd5Node) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_node_mean(s : Cryptohashmd5Node) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_node_scale(s : Cryptohashmd5Node, f : Double) -> Cryptohashmd5Node {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_node_add(a : Cryptohashmd5Node, b : Cryptohashmd5Node) -> Cryptohashmd5Node {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_node_copy(s : Cryptohashmd5Node) -> Cryptohashmd5Node {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_node_fill(s : Cryptohashmd5Node, v : Double) -> Cryptohashmd5Node {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_node_min(s : Cryptohashmd5Node) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_node_max(s : Cryptohashmd5Node) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_node_to_string(s : Cryptohashmd5Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_edge_make(size : Int) -> Cryptohashmd5Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_edge_len(s : Cryptohashmd5Edge) -> Int { s.size }

pub fn crypto_hash_md5_edge_get(s : Cryptohashmd5Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_edge_set(s : Cryptohashmd5Edge, i : Int, v : Double) -> Cryptohashmd5Edge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_edge_sum(s : Cryptohashmd5Edge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_edge_mean(s : Cryptohashmd5Edge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_edge_scale(s : Cryptohashmd5Edge, f : Double) -> Cryptohashmd5Edge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_edge_add(a : Cryptohashmd5Edge, b : Cryptohashmd5Edge) -> Cryptohashmd5Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_edge_copy(s : Cryptohashmd5Edge) -> Cryptohashmd5Edge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_edge_fill(s : Cryptohashmd5Edge, v : Double) -> Cryptohashmd5Edge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_edge_min(s : Cryptohashmd5Edge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_edge_max(s : Cryptohashmd5Edge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_edge_to_string(s : Cryptohashmd5Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_path_make(size : Int) -> Cryptohashmd5Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_path_len(s : Cryptohashmd5Path) -> Int { s.size }

pub fn crypto_hash_md5_path_get(s : Cryptohashmd5Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_path_set(s : Cryptohashmd5Path, i : Int, v : Double) -> Cryptohashmd5Path {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_path_sum(s : Cryptohashmd5Path) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_path_mean(s : Cryptohashmd5Path) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_path_scale(s : Cryptohashmd5Path, f : Double) -> Cryptohashmd5Path {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_path_add(a : Cryptohashmd5Path, b : Cryptohashmd5Path) -> Cryptohashmd5Path {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_path_copy(s : Cryptohashmd5Path) -> Cryptohashmd5Path {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_path_fill(s : Cryptohashmd5Path, v : Double) -> Cryptohashmd5Path {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_path_min(s : Cryptohashmd5Path) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_path_max(s : Cryptohashmd5Path) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_path_to_string(s : Cryptohashmd5Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_cluster_make(size : Int) -> Cryptohashmd5Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_cluster_len(s : Cryptohashmd5Cluster) -> Int { s.size }

pub fn crypto_hash_md5_cluster_get(s : Cryptohashmd5Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_cluster_set(s : Cryptohashmd5Cluster, i : Int, v : Double) -> Cryptohashmd5Cluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cluster_sum(s : Cryptohashmd5Cluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_cluster_mean(s : Cryptohashmd5Cluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_cluster_scale(s : Cryptohashmd5Cluster, f : Double) -> Cryptohashmd5Cluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cluster_add(a : Cryptohashmd5Cluster, b : Cryptohashmd5Cluster) -> Cryptohashmd5Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_cluster_copy(s : Cryptohashmd5Cluster) -> Cryptohashmd5Cluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cluster_fill(s : Cryptohashmd5Cluster, v : Double) -> Cryptohashmd5Cluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cluster_min(s : Cryptohashmd5Cluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_cluster_max(s : Cryptohashmd5Cluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_cluster_to_string(s : Cryptohashmd5Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_model_make(size : Int) -> Cryptohashmd5Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_model_len(s : Cryptohashmd5Model) -> Int { s.size }

pub fn crypto_hash_md5_model_get(s : Cryptohashmd5Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_model_set(s : Cryptohashmd5Model, i : Int, v : Double) -> Cryptohashmd5Model {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_model_sum(s : Cryptohashmd5Model) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_model_mean(s : Cryptohashmd5Model) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_model_scale(s : Cryptohashmd5Model, f : Double) -> Cryptohashmd5Model {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_model_add(a : Cryptohashmd5Model, b : Cryptohashmd5Model) -> Cryptohashmd5Model {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_model_copy(s : Cryptohashmd5Model) -> Cryptohashmd5Model {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_model_fill(s : Cryptohashmd5Model, v : Double) -> Cryptohashmd5Model {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_model_min(s : Cryptohashmd5Model) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_model_max(s : Cryptohashmd5Model) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_model_to_string(s : Cryptohashmd5Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_layer_make(size : Int) -> Cryptohashmd5Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_layer_len(s : Cryptohashmd5Layer) -> Int { s.size }

pub fn crypto_hash_md5_layer_get(s : Cryptohashmd5Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_layer_set(s : Cryptohashmd5Layer, i : Int, v : Double) -> Cryptohashmd5Layer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_layer_sum(s : Cryptohashmd5Layer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_layer_mean(s : Cryptohashmd5Layer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_layer_scale(s : Cryptohashmd5Layer, f : Double) -> Cryptohashmd5Layer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_layer_add(a : Cryptohashmd5Layer, b : Cryptohashmd5Layer) -> Cryptohashmd5Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_layer_copy(s : Cryptohashmd5Layer) -> Cryptohashmd5Layer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_layer_fill(s : Cryptohashmd5Layer, v : Double) -> Cryptohashmd5Layer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_layer_min(s : Cryptohashmd5Layer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_layer_max(s : Cryptohashmd5Layer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_layer_to_string(s : Cryptohashmd5Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_buffer_make(size : Int) -> Cryptohashmd5Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_buffer_len(s : Cryptohashmd5Buffer) -> Int { s.size }

pub fn crypto_hash_md5_buffer_get(s : Cryptohashmd5Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_buffer_set(s : Cryptohashmd5Buffer, i : Int, v : Double) -> Cryptohashmd5Buffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_buffer_sum(s : Cryptohashmd5Buffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_buffer_mean(s : Cryptohashmd5Buffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_buffer_scale(s : Cryptohashmd5Buffer, f : Double) -> Cryptohashmd5Buffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_buffer_add(a : Cryptohashmd5Buffer, b : Cryptohashmd5Buffer) -> Cryptohashmd5Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_buffer_copy(s : Cryptohashmd5Buffer) -> Cryptohashmd5Buffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_buffer_fill(s : Cryptohashmd5Buffer, v : Double) -> Cryptohashmd5Buffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_buffer_min(s : Cryptohashmd5Buffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_buffer_max(s : Cryptohashmd5Buffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_buffer_to_string(s : Cryptohashmd5Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_cursor_make(size : Int) -> Cryptohashmd5Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_cursor_len(s : Cryptohashmd5Cursor) -> Int { s.size }

pub fn crypto_hash_md5_cursor_get(s : Cryptohashmd5Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_cursor_set(s : Cryptohashmd5Cursor, i : Int, v : Double) -> Cryptohashmd5Cursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cursor_sum(s : Cryptohashmd5Cursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_cursor_mean(s : Cryptohashmd5Cursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_cursor_scale(s : Cryptohashmd5Cursor, f : Double) -> Cryptohashmd5Cursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cursor_add(a : Cryptohashmd5Cursor, b : Cryptohashmd5Cursor) -> Cryptohashmd5Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_cursor_copy(s : Cryptohashmd5Cursor) -> Cryptohashmd5Cursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cursor_fill(s : Cryptohashmd5Cursor, v : Double) -> Cryptohashmd5Cursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_cursor_min(s : Cryptohashmd5Cursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_cursor_max(s : Cryptohashmd5Cursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_cursor_to_string(s : Cryptohashmd5Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_view_make(size : Int) -> Cryptohashmd5View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_view_len(s : Cryptohashmd5View) -> Int { s.size }

pub fn crypto_hash_md5_view_get(s : Cryptohashmd5View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_view_set(s : Cryptohashmd5View, i : Int, v : Double) -> Cryptohashmd5View {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_view_sum(s : Cryptohashmd5View) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_view_mean(s : Cryptohashmd5View) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_view_scale(s : Cryptohashmd5View, f : Double) -> Cryptohashmd5View {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_view_add(a : Cryptohashmd5View, b : Cryptohashmd5View) -> Cryptohashmd5View {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_view_copy(s : Cryptohashmd5View) -> Cryptohashmd5View {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_view_fill(s : Cryptohashmd5View, v : Double) -> Cryptohashmd5View {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_view_min(s : Cryptohashmd5View) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_view_max(s : Cryptohashmd5View) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_view_to_string(s : Cryptohashmd5View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_range_make(size : Int) -> Cryptohashmd5Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_range_len(s : Cryptohashmd5Range) -> Int { s.size }

pub fn crypto_hash_md5_range_get(s : Cryptohashmd5Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_range_set(s : Cryptohashmd5Range, i : Int, v : Double) -> Cryptohashmd5Range {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_range_sum(s : Cryptohashmd5Range) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_range_mean(s : Cryptohashmd5Range) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_range_scale(s : Cryptohashmd5Range, f : Double) -> Cryptohashmd5Range {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_range_add(a : Cryptohashmd5Range, b : Cryptohashmd5Range) -> Cryptohashmd5Range {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_range_copy(s : Cryptohashmd5Range) -> Cryptohashmd5Range {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_range_fill(s : Cryptohashmd5Range, v : Double) -> Cryptohashmd5Range {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_range_min(s : Cryptohashmd5Range) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_range_max(s : Cryptohashmd5Range) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_range_to_string(s : Cryptohashmd5Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Cryptohashmd5Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_md5_slice_make(size : Int) -> Cryptohashmd5Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_md5_slice_len(s : Cryptohashmd5Slice) -> Int { s.size }

pub fn crypto_hash_md5_slice_get(s : Cryptohashmd5Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_md5_slice_set(s : Cryptohashmd5Slice, i : Int, v : Double) -> Cryptohashmd5Slice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_slice_sum(s : Cryptohashmd5Slice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_md5_slice_mean(s : Cryptohashmd5Slice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_md5_slice_scale(s : Cryptohashmd5Slice, f : Double) -> Cryptohashmd5Slice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_slice_add(a : Cryptohashmd5Slice, b : Cryptohashmd5Slice) -> Cryptohashmd5Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_md5_slice_copy(s : Cryptohashmd5Slice) -> Cryptohashmd5Slice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_slice_fill(s : Cryptohashmd5Slice, v : Double) -> Cryptohashmd5Slice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_md5_slice_min(s : Cryptohashmd5Slice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_md5_slice_max(s : Cryptohashmd5Slice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_md5_slice_to_string(s : Cryptohashmd5Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

