///===
/// extcore/image_morph_hit_miss

pub(all) struct ImagemorphhitmissPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_hit_miss_make_point(x : Double, y : Double) -> ImagemorphhitmissPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_hit_miss_make_point3(x : Double, y : Double, z : Double) -> ImagemorphhitmissPoint {
  { x, y, z, label: 0 }
}

pub fn ImagemorphhitmissPoint::x(self : ImagemorphhitmissPoint) -> Double { self.x }

pub fn ImagemorphhitmissPoint::y(self : ImagemorphhitmissPoint) -> Double { self.y }

pub fn ImagemorphhitmissPoint::z(self : ImagemorphhitmissPoint) -> Double { self.z }

pub fn ImagemorphhitmissPoint::label(self : ImagemorphhitmissPoint) -> Int { self.label }

pub fn ImagemorphhitmissPoint::dist(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ImagemorphhitmissPoint::add(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ImagemorphhitmissPoint::sub(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ImagemorphhitmissPoint::scale(self : ImagemorphhitmissPoint, s : Double) -> ImagemorphhitmissPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ImagemorphhitmissPoint::dot(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ImagemorphhitmissPoint::cross(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ImagemorphhitmissPoint::norm(self : ImagemorphhitmissPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ImagemorphhitmissPoint::normalize(self : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphhitmissPoint::negate(self : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ImagemorphhitmissPoint::mid(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint) -> ImagemorphhitmissPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ImagemorphhitmissPoint::lerp(self : ImagemorphhitmissPoint, other : ImagemorphhitmissPoint, t : Double) -> ImagemorphhitmissPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ImagemorphhitmissPoint::to_string(self : ImagemorphhitmissPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ImagemorphhitmissSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_hit_miss_make_series(vals : Array[Double], name : String) -> ImagemorphhitmissSeries {
  { vals, name, meta: 0 }
}

pub fn ImagemorphhitmissSeries::len(self : ImagemorphhitmissSeries) -> Int { self.vals.length() }

pub fn ImagemorphhitmissSeries::sum(self : ImagemorphhitmissSeries) -> Double { @_common.sum(self.vals) }

pub fn ImagemorphhitmissSeries::mean(self : ImagemorphhitmissSeries) -> Double { @_common.mean(self.vals) }

pub fn ImagemorphhitmissSeries::min(self : ImagemorphhitmissSeries) -> Double { @_common.min(self.vals) }

pub fn ImagemorphhitmissSeries::max(self : ImagemorphhitmissSeries) -> Double { @_common.max(self.vals) }

pub fn ImagemorphhitmissSeries::range(self : ImagemorphhitmissSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ImagemorphhitmissSeries::variance(self : ImagemorphhitmissSeries) -> Double { @_common.variance(self.vals) }

pub fn ImagemorphhitmissSeries::std(self : ImagemorphhitmissSeries) -> Double { @_common.std(self.vals) }

pub fn ImagemorphhitmissSeries::median(self : ImagemorphhitmissSeries) -> Double { @_common.median(self.vals) }

pub fn ImagemorphhitmissSeries::scale(self : ImagemorphhitmissSeries, f : Double) -> ImagemorphhitmissSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ImagemorphhitmissSeries::add(self : ImagemorphhitmissSeries, other : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ImagemorphhitmissSeries::sub(self : ImagemorphhitmissSeries, other : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ImagemorphhitmissSeries::normalize(self : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ImagemorphhitmissSeries::cumsum(self : ImagemorphhitmissSeries) -> ImagemorphhitmissSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ImagemorphhitmissSeries::to_string(self : ImagemorphhitmissSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphhitmissMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_hit_miss_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphhitmissMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_hit_miss_matrix_identity(n : Int) -> ImagemorphhitmissMatrix {
  let m = image_morph_hit_miss_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ImagemorphhitmissMatrix::get(self : ImagemorphhitmissMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ImagemorphhitmissMatrix::transpose(self : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  let result = image_morph_hit_miss_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ImagemorphhitmissMatrix::add(self : ImagemorphhitmissMatrix, other : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = image_morph_hit_miss_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ImagemorphhitmissMatrix::scale(self : ImagemorphhitmissMatrix, s : Double) -> ImagemorphhitmissMatrix {
  let result = image_morph_hit_miss_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ImagemorphhitmissMatrix::multiply(self : ImagemorphhitmissMatrix, other : ImagemorphhitmissMatrix) -> ImagemorphhitmissMatrix {
  if self.cols != other.rows { return image_morph_hit_miss_make_matrix(self.rows, other.cols, 0.0) }
  let result = image_morph_hit_miss_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ImagemorphhitmissMatrix::trace(self : ImagemorphhitmissMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ImagemorphhitmissMatrix::det(self : ImagemorphhitmissMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ImagemorphhitmissMatrix::norm(self : ImagemorphhitmissMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ImagemorphhitmissMatrix::to_string(self : ImagemorphhitmissMatrix) -> String {
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

pub(all) struct ImagemorphhitmissVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_hit_miss_make_vector(comps : Array[Double]) -> ImagemorphhitmissVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_hit_miss_vector_zero(dim : Int) -> ImagemorphhitmissVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ImagemorphhitmissVector::add(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphhitmissVector::sub(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ImagemorphhitmissVector::scale(self : ImagemorphhitmissVector, s : Double) -> ImagemorphhitmissVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ImagemorphhitmissVector::dot(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ImagemorphhitmissVector::norm(self : ImagemorphhitmissVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ImagemorphhitmissVector::normalize(self : ImagemorphhitmissVector) -> ImagemorphhitmissVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ImagemorphhitmissVector::dist(self : ImagemorphhitmissVector, other : ImagemorphhitmissVector) -> Double {
  self.sub(other).norm()
}

pub fn ImagemorphhitmissVector::to_string(self : ImagemorphhitmissVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_hit_miss_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_hit_miss_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_hit_miss_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_hit_miss_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_hit_miss_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_hit_miss_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_hit_miss_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_hit_miss_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_hit_miss_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_hit_miss_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_hit_miss_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_hit_miss_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_hit_miss_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_hit_miss_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_hit_miss_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_hit_miss_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_hit_miss_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_hit_miss_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_hit_miss_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_hit_miss_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_hit_miss_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_hit_miss_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_hit_miss_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_hit_miss_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_hit_miss_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_hit_miss_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_hit_miss_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_hit_miss_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_hit_miss_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphhitmissFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_frame_make(size : Int) -> ImagemorphhitmissFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_frame_len(s : ImagemorphhitmissFrame) -> Int { s.size }

pub fn image_morph_hit_miss_frame_get(s : ImagemorphhitmissFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_frame_set(s : ImagemorphhitmissFrame, i : Int, v : Double) -> ImagemorphhitmissFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_frame_sum(s : ImagemorphhitmissFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_frame_mean(s : ImagemorphhitmissFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_frame_scale(s : ImagemorphhitmissFrame, f : Double) -> ImagemorphhitmissFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_frame_add(a : ImagemorphhitmissFrame, b : ImagemorphhitmissFrame) -> ImagemorphhitmissFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_frame_copy(s : ImagemorphhitmissFrame) -> ImagemorphhitmissFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_frame_fill(s : ImagemorphhitmissFrame, v : Double) -> ImagemorphhitmissFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_frame_min(s : ImagemorphhitmissFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_frame_max(s : ImagemorphhitmissFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_frame_to_string(s : ImagemorphhitmissFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_table_make(size : Int) -> ImagemorphhitmissTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_table_len(s : ImagemorphhitmissTable) -> Int { s.size }

pub fn image_morph_hit_miss_table_get(s : ImagemorphhitmissTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_table_set(s : ImagemorphhitmissTable, i : Int, v : Double) -> ImagemorphhitmissTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_table_sum(s : ImagemorphhitmissTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_table_mean(s : ImagemorphhitmissTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_table_scale(s : ImagemorphhitmissTable, f : Double) -> ImagemorphhitmissTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_table_add(a : ImagemorphhitmissTable, b : ImagemorphhitmissTable) -> ImagemorphhitmissTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_table_copy(s : ImagemorphhitmissTable) -> ImagemorphhitmissTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_table_fill(s : ImagemorphhitmissTable, v : Double) -> ImagemorphhitmissTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_table_min(s : ImagemorphhitmissTable) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_table_max(s : ImagemorphhitmissTable) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_table_to_string(s : ImagemorphhitmissTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_graphn_make(size : Int) -> ImagemorphhitmissGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_graphn_len(s : ImagemorphhitmissGraphN) -> Int { s.size }

pub fn image_morph_hit_miss_graphn_get(s : ImagemorphhitmissGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_graphn_set(s : ImagemorphhitmissGraphN, i : Int, v : Double) -> ImagemorphhitmissGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_graphn_sum(s : ImagemorphhitmissGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_graphn_mean(s : ImagemorphhitmissGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_graphn_scale(s : ImagemorphhitmissGraphN, f : Double) -> ImagemorphhitmissGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_graphn_add(a : ImagemorphhitmissGraphN, b : ImagemorphhitmissGraphN) -> ImagemorphhitmissGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_graphn_copy(s : ImagemorphhitmissGraphN) -> ImagemorphhitmissGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_graphn_fill(s : ImagemorphhitmissGraphN, v : Double) -> ImagemorphhitmissGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_graphn_min(s : ImagemorphhitmissGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_graphn_max(s : ImagemorphhitmissGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_graphn_to_string(s : ImagemorphhitmissGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_node_make(size : Int) -> ImagemorphhitmissNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_node_len(s : ImagemorphhitmissNode) -> Int { s.size }

pub fn image_morph_hit_miss_node_get(s : ImagemorphhitmissNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_node_set(s : ImagemorphhitmissNode, i : Int, v : Double) -> ImagemorphhitmissNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_node_sum(s : ImagemorphhitmissNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_node_mean(s : ImagemorphhitmissNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_node_scale(s : ImagemorphhitmissNode, f : Double) -> ImagemorphhitmissNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_node_add(a : ImagemorphhitmissNode, b : ImagemorphhitmissNode) -> ImagemorphhitmissNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_node_copy(s : ImagemorphhitmissNode) -> ImagemorphhitmissNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_node_fill(s : ImagemorphhitmissNode, v : Double) -> ImagemorphhitmissNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_node_min(s : ImagemorphhitmissNode) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_node_max(s : ImagemorphhitmissNode) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_node_to_string(s : ImagemorphhitmissNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_edge_make(size : Int) -> ImagemorphhitmissEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_edge_len(s : ImagemorphhitmissEdge) -> Int { s.size }

pub fn image_morph_hit_miss_edge_get(s : ImagemorphhitmissEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_edge_set(s : ImagemorphhitmissEdge, i : Int, v : Double) -> ImagemorphhitmissEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_edge_sum(s : ImagemorphhitmissEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_edge_mean(s : ImagemorphhitmissEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_edge_scale(s : ImagemorphhitmissEdge, f : Double) -> ImagemorphhitmissEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_edge_add(a : ImagemorphhitmissEdge, b : ImagemorphhitmissEdge) -> ImagemorphhitmissEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_edge_copy(s : ImagemorphhitmissEdge) -> ImagemorphhitmissEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_edge_fill(s : ImagemorphhitmissEdge, v : Double) -> ImagemorphhitmissEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_edge_min(s : ImagemorphhitmissEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_edge_max(s : ImagemorphhitmissEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_edge_to_string(s : ImagemorphhitmissEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_path_make(size : Int) -> ImagemorphhitmissPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_path_len(s : ImagemorphhitmissPath) -> Int { s.size }

pub fn image_morph_hit_miss_path_get(s : ImagemorphhitmissPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_path_set(s : ImagemorphhitmissPath, i : Int, v : Double) -> ImagemorphhitmissPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_path_sum(s : ImagemorphhitmissPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_path_mean(s : ImagemorphhitmissPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_path_scale(s : ImagemorphhitmissPath, f : Double) -> ImagemorphhitmissPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_path_add(a : ImagemorphhitmissPath, b : ImagemorphhitmissPath) -> ImagemorphhitmissPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_path_copy(s : ImagemorphhitmissPath) -> ImagemorphhitmissPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_path_fill(s : ImagemorphhitmissPath, v : Double) -> ImagemorphhitmissPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_path_min(s : ImagemorphhitmissPath) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_path_max(s : ImagemorphhitmissPath) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_path_to_string(s : ImagemorphhitmissPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_cluster_make(size : Int) -> ImagemorphhitmissCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_cluster_len(s : ImagemorphhitmissCluster) -> Int { s.size }

pub fn image_morph_hit_miss_cluster_get(s : ImagemorphhitmissCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_cluster_set(s : ImagemorphhitmissCluster, i : Int, v : Double) -> ImagemorphhitmissCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cluster_sum(s : ImagemorphhitmissCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_cluster_mean(s : ImagemorphhitmissCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_cluster_scale(s : ImagemorphhitmissCluster, f : Double) -> ImagemorphhitmissCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cluster_add(a : ImagemorphhitmissCluster, b : ImagemorphhitmissCluster) -> ImagemorphhitmissCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_cluster_copy(s : ImagemorphhitmissCluster) -> ImagemorphhitmissCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cluster_fill(s : ImagemorphhitmissCluster, v : Double) -> ImagemorphhitmissCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cluster_min(s : ImagemorphhitmissCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_cluster_max(s : ImagemorphhitmissCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_cluster_to_string(s : ImagemorphhitmissCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_model_make(size : Int) -> ImagemorphhitmissModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_model_len(s : ImagemorphhitmissModel) -> Int { s.size }

pub fn image_morph_hit_miss_model_get(s : ImagemorphhitmissModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_model_set(s : ImagemorphhitmissModel, i : Int, v : Double) -> ImagemorphhitmissModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_model_sum(s : ImagemorphhitmissModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_model_mean(s : ImagemorphhitmissModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_model_scale(s : ImagemorphhitmissModel, f : Double) -> ImagemorphhitmissModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_model_add(a : ImagemorphhitmissModel, b : ImagemorphhitmissModel) -> ImagemorphhitmissModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_model_copy(s : ImagemorphhitmissModel) -> ImagemorphhitmissModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_model_fill(s : ImagemorphhitmissModel, v : Double) -> ImagemorphhitmissModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_model_min(s : ImagemorphhitmissModel) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_model_max(s : ImagemorphhitmissModel) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_model_to_string(s : ImagemorphhitmissModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_layer_make(size : Int) -> ImagemorphhitmissLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_layer_len(s : ImagemorphhitmissLayer) -> Int { s.size }

pub fn image_morph_hit_miss_layer_get(s : ImagemorphhitmissLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_layer_set(s : ImagemorphhitmissLayer, i : Int, v : Double) -> ImagemorphhitmissLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_layer_sum(s : ImagemorphhitmissLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_layer_mean(s : ImagemorphhitmissLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_layer_scale(s : ImagemorphhitmissLayer, f : Double) -> ImagemorphhitmissLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_layer_add(a : ImagemorphhitmissLayer, b : ImagemorphhitmissLayer) -> ImagemorphhitmissLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_layer_copy(s : ImagemorphhitmissLayer) -> ImagemorphhitmissLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_layer_fill(s : ImagemorphhitmissLayer, v : Double) -> ImagemorphhitmissLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_layer_min(s : ImagemorphhitmissLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_layer_max(s : ImagemorphhitmissLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_layer_to_string(s : ImagemorphhitmissLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_buffer_make(size : Int) -> ImagemorphhitmissBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_buffer_len(s : ImagemorphhitmissBuffer) -> Int { s.size }

pub fn image_morph_hit_miss_buffer_get(s : ImagemorphhitmissBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_buffer_set(s : ImagemorphhitmissBuffer, i : Int, v : Double) -> ImagemorphhitmissBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_buffer_sum(s : ImagemorphhitmissBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_buffer_mean(s : ImagemorphhitmissBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_buffer_scale(s : ImagemorphhitmissBuffer, f : Double) -> ImagemorphhitmissBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_buffer_add(a : ImagemorphhitmissBuffer, b : ImagemorphhitmissBuffer) -> ImagemorphhitmissBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_buffer_copy(s : ImagemorphhitmissBuffer) -> ImagemorphhitmissBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_buffer_fill(s : ImagemorphhitmissBuffer, v : Double) -> ImagemorphhitmissBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_buffer_min(s : ImagemorphhitmissBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_buffer_max(s : ImagemorphhitmissBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_buffer_to_string(s : ImagemorphhitmissBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_cursor_make(size : Int) -> ImagemorphhitmissCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_cursor_len(s : ImagemorphhitmissCursor) -> Int { s.size }

pub fn image_morph_hit_miss_cursor_get(s : ImagemorphhitmissCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_cursor_set(s : ImagemorphhitmissCursor, i : Int, v : Double) -> ImagemorphhitmissCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cursor_sum(s : ImagemorphhitmissCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_cursor_mean(s : ImagemorphhitmissCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_cursor_scale(s : ImagemorphhitmissCursor, f : Double) -> ImagemorphhitmissCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cursor_add(a : ImagemorphhitmissCursor, b : ImagemorphhitmissCursor) -> ImagemorphhitmissCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_cursor_copy(s : ImagemorphhitmissCursor) -> ImagemorphhitmissCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cursor_fill(s : ImagemorphhitmissCursor, v : Double) -> ImagemorphhitmissCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_cursor_min(s : ImagemorphhitmissCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_cursor_max(s : ImagemorphhitmissCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_cursor_to_string(s : ImagemorphhitmissCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_view_make(size : Int) -> ImagemorphhitmissView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_view_len(s : ImagemorphhitmissView) -> Int { s.size }

pub fn image_morph_hit_miss_view_get(s : ImagemorphhitmissView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_view_set(s : ImagemorphhitmissView, i : Int, v : Double) -> ImagemorphhitmissView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_view_sum(s : ImagemorphhitmissView) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_view_mean(s : ImagemorphhitmissView) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_view_scale(s : ImagemorphhitmissView, f : Double) -> ImagemorphhitmissView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_view_add(a : ImagemorphhitmissView, b : ImagemorphhitmissView) -> ImagemorphhitmissView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_view_copy(s : ImagemorphhitmissView) -> ImagemorphhitmissView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_view_fill(s : ImagemorphhitmissView, v : Double) -> ImagemorphhitmissView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_view_min(s : ImagemorphhitmissView) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_view_max(s : ImagemorphhitmissView) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_view_to_string(s : ImagemorphhitmissView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_range_make(size : Int) -> ImagemorphhitmissRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_range_len(s : ImagemorphhitmissRange) -> Int { s.size }

pub fn image_morph_hit_miss_range_get(s : ImagemorphhitmissRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_range_set(s : ImagemorphhitmissRange, i : Int, v : Double) -> ImagemorphhitmissRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_range_sum(s : ImagemorphhitmissRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_range_mean(s : ImagemorphhitmissRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_range_scale(s : ImagemorphhitmissRange, f : Double) -> ImagemorphhitmissRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_range_add(a : ImagemorphhitmissRange, b : ImagemorphhitmissRange) -> ImagemorphhitmissRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_range_copy(s : ImagemorphhitmissRange) -> ImagemorphhitmissRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_range_fill(s : ImagemorphhitmissRange, v : Double) -> ImagemorphhitmissRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_range_min(s : ImagemorphhitmissRange) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_range_max(s : ImagemorphhitmissRange) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_range_to_string(s : ImagemorphhitmissRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphhitmissSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_hit_miss_slice_make(size : Int) -> ImagemorphhitmissSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_hit_miss_slice_len(s : ImagemorphhitmissSlice) -> Int { s.size }

pub fn image_morph_hit_miss_slice_get(s : ImagemorphhitmissSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_hit_miss_slice_set(s : ImagemorphhitmissSlice, i : Int, v : Double) -> ImagemorphhitmissSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_slice_sum(s : ImagemorphhitmissSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_hit_miss_slice_mean(s : ImagemorphhitmissSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_hit_miss_slice_scale(s : ImagemorphhitmissSlice, f : Double) -> ImagemorphhitmissSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_slice_add(a : ImagemorphhitmissSlice, b : ImagemorphhitmissSlice) -> ImagemorphhitmissSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_hit_miss_slice_copy(s : ImagemorphhitmissSlice) -> ImagemorphhitmissSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_slice_fill(s : ImagemorphhitmissSlice, v : Double) -> ImagemorphhitmissSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_hit_miss_slice_min(s : ImagemorphhitmissSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_hit_miss_slice_max(s : ImagemorphhitmissSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_hit_miss_slice_to_string(s : ImagemorphhitmissSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

